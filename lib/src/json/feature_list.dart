import 'package:json_annotation/json_annotation.dart';

import 'feature.dart';

part 'feature_list.g.dart';

/// A list of [features].
@JsonSerializable()
class FeatureCollection {
  /// Create an instance.
  const FeatureCollection({
    required this.type,
    required this.features,
  });

  /// Create an instance from a JSON object.
  factory FeatureCollection.fromJson(final Map<String, dynamic> json) =>
      _$FeatureCollectionFromJson(json);

  /// The type of the [features].
  final String type;

  /// The features in this collection.
  final List<Feature> features;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$FeatureCollectionToJson(this);
}
