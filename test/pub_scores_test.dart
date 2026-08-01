import 'dart:convert';
import 'dart:io';

import 'package:jsontool/jsontool.dart';
import 'package:pub_scores/pub_scores.dart';
import 'package:pub_scores/src/parser.dart';
import 'package:test/test.dart';

const _dataPath = 'lib/data/all_packages.json';

void main() {
  test('Test read file', () async {
    var content = File(_dataPath).readAsStringSync();
    var json = jsonDecode(content) as Map<String, dynamic>;
    var packages = PubScores.fromJson(json);

    expect(packages.packages, isNotEmpty);
  });

  test('Streaming parser reads the same packages', () async {
    var content = File(_dataPath).readAsBytesSync();
    var packages = readPubScores(JsonReader.fromUtf8(content));

    expect(packages.packages, isNotEmpty);

    var http = packages['http']!;
    expect(http.pub.likeCount, greaterThan(0));
    expect(http.github!.slug, 'dart-lang/http');
  });

  test('downloadCount30Days round-trips', () {
    var scores = PubScores({
      'http': PubScore(
        pub: PubInfo(
          likeCount: 10,
          grantedPoints: 160,
          downloadCount30Days: 10146592,
          lastUpdated: DateTime.utc(2026, 1, 1),
        ),
        github: null,
      ),
    });

    var json = jsonDecode(jsonEncode(scores)) as Map<String, dynamic>;
    expect(json['packages']['http']['pub']['downloadCount30Days'], 10146592);

    var parsed = PubScores.fromJson(json);
    expect(parsed['http']!.pub.downloadCount30Days, 10146592);
  });

  test('Entries written before the download-count switch still parse', () {
    var json = {
      'packages': {
        'legacy': {
          'pub': {
            'likeCount': 3,
            'grantedPoints': 120,
            'popularity': 97,
            'lastUpdated': '2024-07-16T20:09:47.863320Z',
          },
        },
      },
    };

    var pub = PubScores.fromJson(json)['legacy']!.pub;
    expect(pub.likeCount, 3);
    expect(pub.downloadCount30Days, isNull);

    var streamed = readPubScores(
      JsonReader.fromUtf8(utf8.encode(jsonEncode(json))),
    );
    expect(streamed['legacy']!.pub.downloadCount30Days, isNull);
    expect(
      streamed['legacy']!.pub.lastUpdated,
      DateTime.utc(2024, 7, 16, 20, 9, 47, 863, 320),
    );
  });

  test('Null fields are omitted rather than written out', () {
    var scores = PubScores({
      'unscored': PubScore(
        pub: PubInfo(
          likeCount: 0,
          grantedPoints: null,
          downloadCount30Days: null,
          lastUpdated: DateTime.utc(2026, 1, 1),
        ),
        github: null,
      ),
    });

    var pub =
        (jsonDecode(jsonEncode(scores))
                as Map<String, dynamic>)['packages']['unscored']['pub']
            as Map;
    expect(pub.keys, ['likeCount', 'lastUpdated']);
  });
}
