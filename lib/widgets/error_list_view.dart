import 'package:backstreets_widgets/util.dart';
import 'package:flutter/material.dart';

/// A screen to show an error.
class ErrorListView extends StatelessWidget {
  /// Create an instance.
  const ErrorListView({
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
  Widget build(final BuildContext context) {
    final s = stackTrace;
    return ListView(
      children: [
        ListTile(
          autofocus: true,
          title: const Text('Error Description'),
          subtitle: Text(error.toString()),
          onTap: () => setClipboardText(error.toString()),
        ),
        if (s != null)
          ListTile(
            title: const Text('Stack Trace'),
            subtitle: Text(s.toString()),
            onTap: () => setClipboardText(s.toString()),
          )
      ],
    );
  }
}
