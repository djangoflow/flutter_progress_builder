import 'dart:async';

import 'package:flutter/material.dart';
import 'package:progress_builder/progress_builder.dart';

///
/// Builds a widget in the non-progress/loading state
///
typedef ProgressChildWidgetBuilder = Widget Function(BuildContext context, void Function()? action, Object? error);

/// Builds a progress indicator with [double progress]
typedef ProgressIndicatorWidgetBuilder = Widget Function(BuildContext context, [double? progress]);

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

  /// The animation duration in milliseconds, defaults to 500
  final int? animationDuration;

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
    this.animationDuration,
    Key? key,
  }) : super(key: key);

  @override
  _ProgressBuilderState createState() => _ProgressBuilderState();
}

class _ProgressBuilderState extends State<ProgressBuilder> with SingleTickerProviderStateMixin {
  dynamic _error;
  bool _isInProgress = false;
  AnimationController? _progressAnimationController;
  StreamSubscription<ActionType>? _subscription;
  late final Duration _animationDuration;

  @override
  void initState() {
    super.initState();
    _animationDuration = Duration(milliseconds: widget.animationDuration ?? 500);
    _progressAnimationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );

    _subscription = (widget.controller ?? DefaultActionController.of(context))?.stream.listen((event) {
      if (event == ActionType.start && mounted && !_isInProgress) {
        _action();
      }
    });
  }

  @override
  void dispose() {
    _progressAnimationController?.dispose();
    _subscription?.cancel();
    super.dispose();
  }

  Future<void> _action() async {
    _isInProgress = true;
    _progressAnimationController?.value = 0.0;
    _error = null;
    widget.onStart?.call();
    try {
      await widget.action?.call((progress) {
        _progressAnimationController?.animateTo(
          progress ?? 0,
          duration: _animationDuration,
          curve: Curves.ease,
        );
      });
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
        _isInProgress = false;
      }
      widget.onDone?.call();
    }
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _progressAnimationController!,
        builder: (context, child) {
          if (_isInProgress) {
            return widget.progressBuilder.call(context, _progressAnimationController!.value);
          } else {
            return widget.builder(context, widget.action != null ? _action : null, _error);
          }
        },
      );
}
