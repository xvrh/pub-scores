import 'dart:convert';
import 'dart:io';

import 'package:all_pub_metrics/all_pub_metrics.dart';
import 'package:test/test.dart';

void main() {
  test('Test read file', () async {
    var dataPath = 'data/all_packages.json';

    var content = File(dataPath).readAsStringSync();
    var json = jsonDecode(content) as Map<String, dynamic>;
    var packages = Packages.fromJson(json);

    expect(packages.packages, isNotEmpty);
  });
}
