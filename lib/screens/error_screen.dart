import 'package:backstreets_widgets/screens.dart';
import 'package:flutter/material.dart';

import '../widgets/error_list_view.dart';

/// A widget that displays an error.
class ErrorScreen extends StatelessWidget {
  /// Create an instance.
  const ErrorScreen({
    required this.error,
    this.stackTrace,
    super.key,
  });

  /// The error to show.
  final Object error;

  /// The stack trace to show.
  final StackTrace? stackTrace;

  /// Build the widget.
  @override
  Widget build(final BuildContext context) => SimpleScaffold(
        title: 'Error',
        body: ErrorListView(error: error, stackTrace: stackTrace),
      );
}
