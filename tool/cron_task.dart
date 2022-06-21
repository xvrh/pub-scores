import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:collection/collection.dart';
import 'package:pub_scores/src/model.dart';
import 'package:pub_api_client/pub_api_client.dart';
import 'package:github/github.dart';
import 'package:pool/pool.dart';
import 'package:retry/retry.dart';

const _maxPackagesPerTask = 500;
final _packagesFile = File('lib/data/all_packages.json');

void main() async {
  var currentPackages = await _loadPackages();

  var pubClient = PubClient();
  var packages = await pubClient.packageNameCompletion();

  var startIndex = currentPackages.lastUpdate?.endIndex;
  if (startIndex == null || startIndex >= packages.length) {
    startIndex = 0;
  }

  var newEndIndex = min(packages.length, startIndex + _maxPackagesPerTask);
  var slicedPackages = packages.sublist(startIndex, newEndIndex);
  if (slicedPackages.length < _maxPackagesPerTask) {
    newEndIndex = _maxPackagesPerTask - slicedPackages.length;
    slicedPackages = [...slicedPackages, ...packages.sublist(0, newEndIndex)];
  }

  var packageMap = {...currentPackages.packages};
  packageMap.removeWhere((key, value) => !packages.contains(key));

  var pool = Pool(15);
  final retryOptions = RetryOptions(maxAttempts: 3);

  for (var packageName in slicedPackages) {
    pool.withResource(() async {
      var packageInfo = await retryOptions.retry(
        () => pubClient.packageInfo(packageName),
      );
      var packageScore = await retryOptions.retry(
        () => pubClient.packageScore(packageName),
      );

      var repositoryUri = packageInfo.latest.pubspec.repository ??
          Uri.tryParse(packageInfo.latest.pubspec.homepage ?? '');
      GitHubInfo? github;
      if (repositoryUri != null && repositoryUri.host == 'github.com') {
        var segments = repositoryUri.pathSegments;
        if (segments.length >= 2) {
          var repoName = segments.take(2).join('/');
          var extensionToRemove = '.git';
          if (repoName.endsWith(extensionToRemove)) {
            repoName = repoName.substring(
                0, repoName.length - extensionToRemove.length);
          }
          var slug = RepositorySlug.full(repoName);
          var githubClient = GitHub(auth: findAuthenticationFromEnvironment());
          try {
            var repository =
                await githubClient.repositories.getRepository(slug);
            github = GitHubInfo(repositoryUri.replace(path: repoName),
                starCount: repository.stargazersCount,
                forkCount: repository.forksCount);
          } catch (e) {
            print('Failed to load repository info [$repositoryUri]: $e');
          } finally {
            githubClient.client.close();
          }
        }
      }

      packageMap[packageName] = PubScore(
          pub: PubInfo(
              likeCount: packageScore.likeCount,
              grantedPoints: packageScore.grantedPoints,
              lastUpdated: packageScore.lastUpdated,
              popularityScore: packageScore.popularityScore),
          github: github);
    });
  }

  await pool.close();

  var newPackages = PubScores({
    for (var entry in packageMap.entries.sortedBy((e) => e.key))
      entry.key: entry.value
  }, lastUpdate: Update(date: DateTime.now().toUtc(), endIndex: newEndIndex));

  await _packagesFile
      .writeAsString(JsonEncoder.withIndent('  ').convert(newPackages));

  pubClient.close();
  exit(0);
}

Future<PubScores> _loadPackages() async {
  var content = await _packagesFile.readAsString();
  var json = jsonDecode(content) as Map<String, dynamic>;
  return PubScores.fromJson(json);
}
