import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import 'position_places.dart';
import 'src/json/feature_list.dart';

/// The dio provider.
final dioProvider = Provider((final ref) => Dio());

/// The provider for the last known position.
final lastKnownPositionProvider =
    FutureProvider((final ref) => Geolocator.getLastKnownPosition());

/// A provider to get the updating position.
final positionStreamProvider = StreamProvider(
  (final ref) => Geolocator.getPositionStream(
    locationSettings: const LocationSettings(),
  ),
);

/// Provide whether or not the location service is enabled.
final locationServiceEnabledProvider =
    FutureProvider((final ref) => Geolocator.isLocationServiceEnabled());

/// The location services permission provider.
final locationServicePermissionsProvider =
    FutureProvider((final ref) => Geolocator.checkPermission());

/// A class to hold the most recently returned position.
class _LastKnownPositionNotifier extends StateNotifier<Position?> {
  /// Create an instance.
  _LastKnownPositionNotifier() : super(null);

  /// Get the position.
  Position? get actualPosition => state;

  /// Update the current position.
  set position(final Position position) => state = position;
}

/// Get the last known position.
final _lastKnownPositionProvider =
    StateProvider((final ref) => _LastKnownPositionNotifier());

/// The current places provider.
final currentPlacesProvider = StreamProvider((final ref) async* {
  final stream = ref.watch(positionStreamProvider.stream);
  final oldPositionProvider = ref.watch(_lastKnownPositionProvider);
  final oldPosition = oldPositionProvider.actualPosition;
  await for (final newPosition in stream) {
    if (oldPosition == null ||
        newPosition.accuracy >
            Geolocator.distanceBetween(
              oldPosition.latitude,
              oldPosition.longitude,
              newPosition.latitude,
              newPosition.longitude,
            )) {
      oldPositionProvider.position = newPosition;
      final dio = ref.watch(dioProvider);
      final url =
          'https://api.opentripmap.com/0.1/en/places/radius?radius=1000.0&lon=${newPosition.longitude}&lat=${newPosition.latitude}&apikey=5ae2e3f221c38a28845f05b60c1a90594183cebc681ef52514d61395';
      final response = await dio.get<Map<String, dynamic>>(url);
      final data = response.data;
      if (data == null) {
        throw StateError('$response has no data.');
      }
      yield PositionPlaces(
        position: newPosition,
        featureCollection: FeatureCollection.fromJson(data),
      );
    }
  }
});
