import 'package:geolocator/geolocator.dart';
import 'package:osm_nominatim/osm_nominatim.dart';

/// A class which holds a [position] and a [place].
class PositionPlace {
  /// Create an instance.
  const PositionPlace({
    required this.position,
    required this.place,
  });

  /// The current position.
  final Position position;

  /// THe current place.
  final Place place;
}
