// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PubScores _$PubScoresFromJson(Map<String, dynamic> json) => PubScores(
      (json['packages'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, PubScore.fromJson(e as Map<String, dynamic>)),
      ),
      lastUpdate: json['lastUpdate'] == null
          ? null
          : Update.fromJson(json['lastUpdate'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PubScoresToJson(PubScores instance) => <String, dynamic>{
      'packages': instance.packages,
      'lastUpdate': instance.lastUpdate,
    };

PubScore _$PubScoreFromJson(Map<String, dynamic> json) => PubScore(
      pub: PubInfo.fromJson(json['pub'] as Map<String, dynamic>),
      github: json['github'] == null
          ? null
          : GitHubInfo.fromJson(json['github'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PubScoreToJson(PubScore instance) {
  final val = <String, dynamic>{
    'pub': instance.pub,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('github', instance.github);
  return val;
}

PubInfo _$PubInfoFromJson(Map<String, dynamic> json) => PubInfo(
      likeCount: json['likeCount'] as int,
      grantedPoints: json['grantedPoints'] as int?,
      popularityScore: json['popularityScore'] as num?,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$PubInfoToJson(PubInfo instance) => <String, dynamic>{
      'likeCount': instance.likeCount,
      'grantedPoints': instance.grantedPoints,
      'popularityScore': instance.popularityScore,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
    };

GitHubInfo _$GitHubInfoFromJson(Map<String, dynamic> json) => GitHubInfo(
      Uri.parse(json['uri'] as String),
      starCount: json['starCount'] as int,
      forkCount: json['forkCount'] as int,
    );

Map<String, dynamic> _$GitHubInfoToJson(GitHubInfo instance) =>
    <String, dynamic>{
      'uri': instance.uri.toString(),
      'starCount': instance.starCount,
      'forkCount': instance.forkCount,
    };

Update _$UpdateFromJson(Map<String, dynamic> json) => Update(
      endIndex: json['endIndex'] as int,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$UpdateToJson(Update instance) => <String, dynamic>{
      'endIndex': instance.endIndex,
      'date': instance.date.toIso8601String(),
    };
