import 'package:json_annotation/json_annotation.dart';

import 'feature.dart';

part 'geometry.g.dart';

/// The geometry of a [Feature].
@JsonSerializable()
class Geometry {
  /// Create an instance.
  const Geometry({
    required this.type,
    required this.coordinates,
  });

  /// Create an instance from a JSON object.
  factory Geometry.fromJson(final Map<String, dynamic> json) =>
      _$GeometryFromJson(json);

  /// The type of this geometry.
  final String type;

  /// The coordinates of this geometry.
  final List<double> coordinates;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$GeometryToJson(this);

  /// Get the longitude of this geometry.
  double get longitude => coordinates.first;

  /// Get the latitude coordinate of this geometry.
  double get latitude => coordinates.last;
}
