import 'package:backstreets_widgets/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../position_place.dart';
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
    final provider = ref.watch(currentPlaceProvider);
    return provider.when(
      data: getBody,
      error: (final error, final stackTrace) =>
          ErrorScreen(error: error, stackTrace: stackTrace),
      loading: LoadingScreen.new,
    );
  }

  /// Get the body of the widget.
  Widget getBody(final PositionPlace positionPlace) {
    final position = positionPlace.position;
    final place = positionPlace.place;
    final heading = position.heading;
    return SimpleScaffold(
      title: 'Loaded',
      body: ListView(
        children: [
          CopyListTile(
            title: 'Place Name',
            subtitle: place.address.toString(),
            autofocus: true,
          ),
          CopyListTile(
            title: 'Type',
            subtitle: place.type,
          ),
          CopyListTile(title: 'Category', subtitle: place.category),
          CopyListTile(title: 'Icon', subtitle: place.icon ?? 'Not Set'),
          ...[
            for (final entry
                in (place.extraTags ?? <String, dynamic>{}).entries)
              CopyListTile(title: entry.key, subtitle: entry.value.toString())
          ],
          CopyListTile(
            title: 'Latitude',
            subtitle: position.latitude.toString(),
            autofocus: true,
          ),
          CopyListTile(
            title: 'Longitude',
            subtitle: position.longitude.toString(),
          ),
          CopyListTile(
            title: 'Direction',
            subtitle: heading.isNaN ? 'Unknown' : '${heading.floor()} °',
          ),
          CopyListTile(
            title: 'Accuracy',
            subtitle: sensibleDistance(position.accuracy),
          )
        ],
      ),
    );
  }
}
