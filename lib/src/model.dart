import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class PubScores {
  final Map<String, PubScore> packages;
  final Update? lastUpdate;

  PubScores(this.packages, {this.lastUpdate});

  factory PubScores.fromJson(Map<String, dynamic> json) =>
      _$PubScoresFromJson(json);

  Map<String, dynamic> toJson() => _$PubScoresToJson(this);
}

@JsonSerializable(includeIfNull: false)
class PubScore {
  final PubInfo pub;
  final GitHubInfo? github;

  PubScore({
    required this.pub,
    required this.github,
  });

  factory PubScore.fromJson(Map<String, dynamic> json) =>
      _$PubScoreFromJson(json);

  Map<String, dynamic> toJson() => _$PubScoreToJson(this);
}

@JsonSerializable()
class PubInfo {
  final int likeCount;
  final int? grantedPoints;
  final num? popularityScore;
  final DateTime lastUpdated;

  PubInfo({
    required this.likeCount,
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
  final int endIndex;
  final DateTime date;

  Update({required this.endIndex, required this.date});

  factory Update.fromJson(Map<String, dynamic> json) => _$UpdateFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateToJson(this);
}
