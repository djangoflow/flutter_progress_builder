import 'package:flutter/material.dart';

import 'progress_builder.dart';

class CircularProgressBuilder extends ProgressBuilder {
  static Widget _progressBuilder([double? value]) =>
      CircularProgressIndicator(value: value);

  static Widget _adaptiveProgressBuilder([double? value]) =>
      CircularProgressIndicator.adaptive(value: value);

  CircularProgressBuilder(
      {required Widget Function(void Function()?, Object?) builder,
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

  CircularProgressBuilder.adaptive(
      {required Widget Function(void Function()?, Object?) builder,
      void Function(Object)? onError,
      void Function()? onSuccess,
      void Function()? onDone,
      Future<void> Function(void Function(int, int))? action})
      : super(
            builder: builder,
            progressBuilder: _adaptiveProgressBuilder,
            onError: onError,
            onSuccess: onSuccess,
            onDone: onDone,
            action: action);
}
