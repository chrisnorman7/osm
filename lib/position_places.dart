import 'package:geolocator/geolocator.dart';

import 'src/json/feature_list.dart';

/// A class which holds a [position] and a [featureCollection].
class PositionPlaces {
  /// Create an instance.
  const PositionPlaces({
    required this.position,
    required this.featureCollection,
  });

  /// The current position.
  final Position position;

  /// The places that are near [position].
  final FeatureCollection featureCollection;
}
