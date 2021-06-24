import 'package:flutter/material.dart';

import 'progress_builder.dart';

class LinearProgressBuilder extends ProgressBuilder {
  static Widget _progressBuilder([context, double? value]) =>
      LinearProgressIndicator(value: value);

  LinearProgressBuilder(
      {required ProgressChildWidgetBuilder builder,
      void Function(Object)? onError,
      void Function()? onSuccess,
      void Function()? onDone,
      Future<void> Function(void Function(int, int))? action})
      : super(
            builder: builder,
            progressBuilder: _progressBuilder,
            onError: onError,
            onSuccess: onSuccess,
            onDone: onDone,
            action: action);
}
