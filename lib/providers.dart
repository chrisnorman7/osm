import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:osm_nominatim/osm_nominatim.dart';

import 'position_place.dart';

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

/// The reverse search provider.
final reverseSearchProvider = FutureProvider.family<Place, Position>(
  (final ref, final position) => Nominatim.reverseSearch(
    lat: position.latitude,
    lon: position.longitude,
    addressDetails: true,
    nameDetails: true,
    extraTags: true,
  ),
);

/// The current place provider.
final currentPlaceProvider = FutureProvider(
  (final ref) async {
    final position = await ref.watch(positionStreamProvider.future);
    return PositionPlace(
      position: position,
      place: await ref.watch(reverseSearchProvider.call(position).future),
    );
  },
);
