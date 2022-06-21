import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class Packages {
  final Map<String, Package> packages;
  final Update? lastUpdate;

  Packages(this.packages, {this.lastUpdate});

  factory Packages.fromJson(Map<String, dynamic> json) =>
      _$PackagesFromJson(json);

  Map<String, dynamic> toJson() => _$PackagesToJson(this);
}

@JsonSerializable()
class Package {
  final PubInfo pub;
  final GitHubInfo? github;

  Package({
    required this.pub,
    required this.github,
  });

  factory Package.fromJson(Map<String, dynamic> json) =>
      _$PackageFromJson(json);

  Map<String, dynamic> toJson() => _$PackageToJson(this);
}

@JsonSerializable()
class PubInfo {
  final int? grantedPoints;
  final int popularityScore;
  final DateTime lastUpdated;

  PubInfo({
    required this.grantedPoints,
    required this.popularityScore,
    required this.lastUpdated,
  });

  factory PubInfo.fromJson(Map<String, dynamic> json) =>
      _$PubInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PubInfoToJson(this);
}

@JsonSerializable()
class GitHubInfo {
  final Uri uri;
  final int starCount;
  final int forkCount;

  GitHubInfo(
    this.uri, {
    required this.starCount,
    required this.forkCount,
  });

  factory GitHubInfo.fromJson(Map<String, dynamic> json) =>
      _$GitHubInfoFromJson(json);

  Map<String, dynamic> toJson() => _$GitHubInfoToJson(this);
}

@JsonSerializable()
class Update {
  final String? endPackageName;
  final DateTime date;

  Update({required this.endPackageName, required this.date});

  factory Update.fromJson(Map<String, dynamic> json) => _$UpdateFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateToJson(this);
}
