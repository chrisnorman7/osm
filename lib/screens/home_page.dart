import 'package:backstreets_widgets/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../position_places.dart';
import '../providers.dart';
import '../util.dart';
import '../widgets/copy_list_tile.dart';
import 'error_screen.dart';
import 'loading_screen.dart';

/// The home page for the application.
class HomePage extends ConsumerWidget {
  /// Create an instance.
  const HomePage({super.key});

  /// Build the widget.
  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final provider = ref.watch(currentPlacesProvider);
    return provider.when(
      data: getBody,
      error: (final error, final stackTrace) => ErrorScreen(
        error: error,
        stackTrace: stackTrace,
      ),
      loading: LoadingScreen.new,
    );
  }

  /// Get the body of the widget.
  Widget getBody(final PositionPlaces positionPlace) {
    final position = positionPlace.position;
    final places = positionPlace.featureCollection.features;
    final heading = position.heading;
    final children = [
      CopyListTile(
        title: 'Longitude',
        subtitle: '${position.longitude} °',
        autofocus: places.isEmpty,
      ),
      CopyListTile(title: 'Latitude', subtitle: '${position.latitude} °'),
      CopyListTile(
        title: 'Heading',
        subtitle: heading.isNaN ? 'Unknown' : '${heading.floor()} °',
      ),
      CopyListTile(
        title: 'Accuracy',
        subtitle: sensibleDistance(position.accuracy),
      )
    ];
    return SimpleScaffold(
      title: 'Loaded',
      body: ListView.builder(
        itemBuilder: (final context, final index) {
          if (index < children.length) {
            return children[index];
          }
          final placeIndex = index - children.length;
          final place = places[placeIndex];
          final geometry = place.geometry;
          final distance = sensibleDistance(
            Geolocator.distanceBetween(
              position.latitude,
              position.longitude,
              geometry.latitude,
              geometry.longitude,
            ),
          );
          final bearing = (Geolocator.bearingBetween(
                    position.latitude,
                    position.longitude,
                    geometry.latitude,
                    geometry.longitude,
                  ) %
                  360)
              .floor();
          return CopyListTile(
            autofocus: placeIndex == 0,
            title: place.name,
            subtitle: '$distance ($bearing °)',
          );
        },
        itemCount: children.length + places.length,
      ),
    );
  }
}
