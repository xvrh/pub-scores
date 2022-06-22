import 'package:jsontool/jsontool.dart';

import 'model.dart';

PubScores readPubScores(JsonReader reader) {
  reader.expectObject();
  var result = <String, PubScore>{};
  while (true) {
    var key = reader.tryKey(const ["packages"]);
    if (key == "packages") {
      reader.expectObject();
      var packageName = reader.nextKey();
      while (packageName != null) {
        result[packageName] = _readPubScore(reader);
        packageName = reader.nextKey();
      }
    } else if (!reader.skipObjectEntry()) {
      break;
    }
  }
  return PubScores(result);
}

PubScore _readPubScore(JsonReader reader) {
  reader.expectObject();

  PubInfo? pub;
  GitHubInfo? github;
  while (reader.hasNextKey()) {
    switch (reader.nextKey()!) {
      case "pub":
        pub = _readPubInfo(reader);
        break;
      case "github":
        github = _readGithubInfo(reader);
        break;
      default:
        reader.skipAnyValue();
    }
  }

  return PubScore(pub: pub!, github: github);
}

PubInfo _readPubInfo(JsonReader reader) {
  reader.expectObject();

  int? likeCount;
  int? grantedPoints;
  num? popularityScore;

  while (reader.hasNextKey()) {
    switch (reader.nextKey()!) {
      case "likeCount":
        likeCount = reader.expectInt();
        break;
      case "grantedPoints":
        if (!reader.tryNull()) {
          grantedPoints = reader.expectInt();
        }
        break;
      case "popularityScore":
        if (!reader.tryNull()) {
          popularityScore = reader.expectNum();
        }
        break;
      default:
        reader.skipAnyValue();
    }
  }

  return PubInfo(
      likeCount: likeCount!,
      grantedPoints: grantedPoints,
      popularityScore: popularityScore,
      lastUpdated: DateTime.now());
}

GitHubInfo _readGithubInfo(JsonReader reader) {
  reader.expectObject();

  String? slug;
  int? starCount;
  int? forkCount;

  while (reader.hasNextKey()) {
    switch (reader.nextKey()!) {
      case "slug":
        slug = reader.expectString();
        break;
      case "starCount":
        starCount = reader.expectInt();
        break;
      case "forkCount":
        forkCount = reader.expectInt();
        break;
      default:
        reader.skipAnyValue();
    }
  }

  return GitHubInfo(
    slug!,
    starCount: starCount!,
    forkCount: forkCount!,
  );
}
