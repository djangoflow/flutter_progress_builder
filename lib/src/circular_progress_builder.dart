import 'package:flutter/material.dart';

import 'progress_builder.dart';

class CircularProgressBuilder extends ProgressBuilder {
  static Widget _progressBuilder(context, [double? value]) =>
      CircularProgressIndicator(value: value);

  static Widget _adaptiveProgressBuilder(context, [double? value]) =>
      CircularProgressIndicator.adaptive(value: value);

  CircularProgressBuilder({
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

  CircularProgressBuilder.adaptive({
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
          progressBuilder: _adaptiveProgressBuilder,
        );
}
