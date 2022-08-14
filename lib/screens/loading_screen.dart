import 'package:backstreets_widgets/screens.dart';
import 'package:flutter/material.dart';

import '../widgets/loading_widget.dart';

/// A widget that displays a loading screen.
class LoadingScreen extends StatelessWidget {
  /// Create an instance.
  const LoadingScreen({super.key});

  /// Build the widget.
  @override
  Widget build(final BuildContext context) =>
      const SimpleScaffold(title: 'Loading', body: LoadingWidget());
}
