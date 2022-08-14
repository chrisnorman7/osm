import 'package:json_annotation/json_annotation.dart';

import 'feature_list.dart';
import 'geometry.dart';

part 'feature.g.dart';

/// A feature in a [FeatureCollection].
@JsonSerializable()
class Feature {
  /// Create an instance.
  const Feature({
    required this.type,
    required this.id,
    required this.geometry,
    required this.properties,
  });

  /// Create an instance from a JSON object.
  factory Feature.fromJson(final Map<String, dynamic> json) =>
      _$FeatureFromJson(json);

  /// The type of this feature.
  final String type;

  /// The ID of this feature.
  final String id;

  /// The geometry of this feature.
  final Geometry geometry;

  /// The properties of this feature.
  final Map<String, dynamic> properties;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$FeatureToJson(this);

  /// Get the name of this feature.
  String get name => (properties['name'] as String?)!;
}
