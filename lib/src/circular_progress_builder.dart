import 'package:flutter/material.dart';

import 'action_controller.dart';
import 'progress_builder.dart';

class CircularProgressBuilder extends ProgressBuilder {
  static Widget _progressBuilder(context, [double? value]) => CircularProgressIndicator(value: value);

  static Widget _adaptiveProgressBuilder(context, [double? value]) => CircularProgressIndicator.adaptive(value: value);

  const CircularProgressBuilder({
    required ProgressChildWidgetBuilder builder,
    ErrorCallback? onError,
    ProgressAction? action,
    VoidCallback? onDone,
    VoidCallback? onStart,
    VoidCallback? onSuccess,
    ActionController? controller,
    int? animationDuration,
    Key? key,
  }) : super(
          action: action,
          builder: builder,
          onDone: onDone,
          onError: onError,
          onStart: onStart,
          onSuccess: onSuccess,
          progressBuilder: _progressBuilder,
          controller: controller,
          animationDuration: animationDuration,
          key: key,
        );

  const CircularProgressBuilder.adaptive({
    required ProgressChildWidgetBuilder builder,
    ErrorCallback? onError,
    ProgressAction? action,
    VoidCallback? onDone,
    VoidCallback? onStart,
    VoidCallback? onSuccess,
    ActionController? controller,
    int? animationDuration,
    Key? key,
  }) : super(
          action: action,
          builder: builder,
          onDone: onDone,
          onError: onError,
          onStart: onStart,
          onSuccess: onSuccess,
          progressBuilder: _adaptiveProgressBuilder,
          controller: controller,
          animationDuration: animationDuration,
          key: key,
        );
}
