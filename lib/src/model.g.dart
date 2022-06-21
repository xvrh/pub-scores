// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Packages _$PackagesFromJson(Map<String, dynamic> json) => Packages(
      (json['packages'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Package.fromJson(e as Map<String, dynamic>)),
      ),
      lastUpdate: json['lastUpdate'] == null
          ? null
          : Update.fromJson(json['lastUpdate'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PackagesToJson(Packages instance) => <String, dynamic>{
      'packages': instance.packages,
      'lastUpdate': instance.lastUpdate,
    };

Package _$PackageFromJson(Map<String, dynamic> json) => Package(
      pub: PubInfo.fromJson(json['pub'] as Map<String, dynamic>),
      github: json['github'] == null
          ? null
          : GitHubInfo.fromJson(json['github'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PackageToJson(Package instance) => <String, dynamic>{
      'pub': instance.pub,
      'github': instance.github,
    };

PubInfo _$PubInfoFromJson(Map<String, dynamic> json) => PubInfo(
      grantedPoints: json['grantedPoints'] as int?,
      popularityScore: json['popularityScore'] as int,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$PubInfoToJson(PubInfo instance) => <String, dynamic>{
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
      endPackageName: json['endPackageName'] as String?,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$UpdateToJson(Update instance) => <String, dynamic>{
      'endPackageName': instance.endPackageName,
      'date': instance.date.toIso8601String(),
    };
