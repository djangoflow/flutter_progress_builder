import 'dart:async';

import 'package:flutter/material.dart';
import 'package:progress_builder/progress_builder.dart';
import 'action_controller.dart';

///
/// Builds a widget in the non-progress/loading state
///
typedef ProgressChildWidgetBuilder = Widget Function(
    BuildContext context, void Function()? action, Object? error);

/// Builds a progress indicator with [double progress]
typedef ProgressIndicatorWidgetBuilder = Widget Function(BuildContext context,
    [double? progress]);

/// The call back from action to notify about the progress
typedef ProgressCallback = void Function(double? progress);

typedef ProgressAction = Future<void> Function(ProgressCallback);

typedef ErrorCallback = void Function(Object error);

///
/// Base ProgressBuilder
///
/// ```dart
/// ProgressBuilder(
///   builder: (context, state, error) {
///   // return the widget here (e.g. a button) or an error widget, or both
///   }
/// )
/// ```
class ProgressBuilder extends StatefulWidget {
  /// Builds both the initial state and once the action is done, both successfully and after an exception.
  /// dart
  final ProgressChildWidgetBuilder builder;
  final ProgressIndicatorWidgetBuilder progressBuilder;

  /// Called if exception is thrown
  final ErrorCallback? onError;

  /// Called when done and no exception was thrown
  final VoidCallback? onSuccess;

  /// Always called (i.e. finally...)
  final VoidCallback? onDone;

  /// Called when loading/progress indicator is displayed before the action
  final VoidCallback? onStart;

  /// The action to be executed
  final ProgressAction? action;

  /// The stream to listen for triggering action externally
  final ActionController? controller;

  /// Creates a ProgressBuilder.
  ///
  /// The [builder]  builds the child, either in initial, done or error state (error != null).
  ///
  /// The [progressBuilder] builds the state when action is in progress, e.g. LinearLoadingIndicator
  ///
  const ProgressBuilder({
    required this.builder,
    required this.progressBuilder,
    this.action,
    this.controller,
    this.onError,
    this.onSuccess,
    this.onDone,
    this.onStart,
    Key? key,
  }) : super(key: key);

  @override
  _ProgressBuilderState createState() => _ProgressBuilderState();
}

class _ProgressBuilderState extends State<ProgressBuilder> {
  double? _progress;
  dynamic _error;

  StreamSubscription<ActionType>? _subscription;

  @override
  void initState() {
    _subscription = (widget.controller ?? DefaultActionController.of(context))
        ?.stream
        .listen((event) {
      if (event == ActionType.start && mounted && _progress == null) {
        _action();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _progressCallback(double? progress) {
    setState(() {
      _progress = progress ?? -1;
    });
  }

  Future<void> _action() async {
    setState(() {
      _progress = -1;
      _error = null;
    });
    widget.onStart?.call();
    try {
      await widget.action?.call(_progressCallback);
      widget.onSuccess?.call();
    } catch (e) {
      _error = e;
      if (widget.onError != null) {
        widget.onError!(e);
      } else {
        rethrow;
      }
    } finally {
      if (mounted) {
        setState(() {
          _progress = null;
        });
      }
      widget.onDone?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_progress != null) {
      final progress = _progress! < 0 ? null : _progress;
      return widget.progressBuilder.call(context, progress);
    } else {
      return widget.builder(
          context, widget.action != null ? _action : null, _error);
    }
  }
}
