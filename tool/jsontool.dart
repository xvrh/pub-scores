import 'dart:io';

import 'package:jsontool/jsontool.dart';
import 'package:pub_scores/src/parser.dart';

void main() async {
  for (var i = 0; i < 50; i++) {
    var stopwatch = Stopwatch()..start();
    var dataPath = 'lib/data/all_packages.json';
    var content = File(dataPath).readAsBytesSync();
    print('Step 1: ${stopwatch.elapsedMilliseconds}ms');

    var reader = JsonReader.fromUtf8(content);

    var scores = readPubScores(reader);
    print('scores: ${scores.packages.length}');

    print('Elapsed: ${stopwatch.elapsedMilliseconds}ms');
  }
}
