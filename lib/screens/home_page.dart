import 'package:backstreets_widgets/screens.dart';
import 'package:backstreets_widgets/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../providers.dart';
import 'error_screen.dart';
import 'loading_screen.dart';

/// The home page for the application.
class HomePage extends ConsumerWidget {
  /// Create an instance.
  const HomePage({super.key});

  /// Build the widget.
  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final provider = ref.watch(positionStreamProvider);
    return provider.when(
      data: getBody,
      error: (final error, final stackTrace) =>
          ErrorScreen(error: error, stackTrace: stackTrace),
      loading: LoadingScreen.new,
    );
  }

  /// Get the body of the widget.
  Widget getBody(final Position position) => SimpleScaffold(
        title: 'Loaded',
        body: ListView(
          children: [
            ListTile(
              autofocus: true,
              title: const Text('Latitude'),
              subtitle: Text(position.latitude.toStringAsFixed(2)),
              onTap: () => setClipboardText(position.latitude.toString()),
            ),
            ListTile(
              title: const Text('Longitude'),
              subtitle: Text(position.longitude.toStringAsFixed(2)),
              onTap: () => setClipboardText(position.longitude.toString()),
            )
          ],
        ),
      );
}
