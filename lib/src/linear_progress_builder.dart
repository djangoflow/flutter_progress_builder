import 'package:flutter/material.dart';

import 'progress_builder.dart';

class LinearProgressBuilder extends ProgressBuilder {
  static Widget _progressBuilder([context, double? value]) =>
      LinearProgressIndicator(value: value);

  LinearProgressBuilder({
    required ProgressChildWidgetBuilder builder,
    ErrorCallback? onError,
    ProgressAction? action,
    VoidCallback? onDone,
    VoidCallback? onStart,
    VoidCallback? onSuccess,
  }) : super(
          action: action,
          builder: builder,
          onDone: onDone,
          onError: onError,
          onStart: onStart,
          onSuccess: onSuccess,
          progressBuilder: _progressBuilder,
        );
}
