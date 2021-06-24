import 'package:flutter/material.dart';

class ProgressBuilder extends StatefulWidget {
  final Widget Function(void Function()?) builder;
  final Widget Function([double?]) progressBuilder;
  final void Function(Object)? onError;
  final void Function()? onSuccess;
  final void Function()? onDone;
  final void Function()? onStart;
  final Future<void> Function(void Function(int, int))? action;

  ProgressBuilder({
    required this.builder,
    required this.progressBuilder,
    this.action,
    this.onError,
    this.onSuccess,
    this.onDone,
    this.onStart,
  });

  @override
  _ProgressBuilderState createState() => _ProgressBuilderState();
}

class _ProgressBuilderState extends State<ProgressBuilder> {
  double? _progress;

  void _progressCallback(int? count, int? total) {
    setState(() {
      if (count != null && total != null) {
        _progress = total / count;
      } else {
        _progress = -1;
      }
    });
  }

  Future<void> _action() async {
    setState(() {
      _progress = -1;
    });
    widget.onStart?.call();
    try {
      await widget.action?.call(_progressCallback);
      widget.onSuccess?.call();
    } catch (e) {
      if (widget.onError != null) {
        widget.onError!(e);
      } else {
        rethrow;
      }
    } finally {
      setState(() {
        _progress = null;
      });
      widget.onDone?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_progress != null) {
      final progress = _progress! < 0 ? null : _progress;
      return widget.progressBuilder.call(progress);
    } else {
      return widget.builder(
          widget.action != null ? _action : null);
    }
  }
}
