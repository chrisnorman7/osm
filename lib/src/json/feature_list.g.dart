// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeatureCollection _$FeatureCollectionFromJson(Map<String, dynamic> json) =>
    FeatureCollection(
      type: json['type'] as String,
      features: (json['features'] as List<dynamic>)
          .map((e) => Feature.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FeatureCollectionToJson(FeatureCollection instance) =>
    <String, dynamic>{
      'type': instance.type,
      'features': instance.features,
    };
