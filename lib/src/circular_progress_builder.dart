import 'package:flutter/material.dart';

import 'progress_builder.dart';

class CircularProgressBuilder extends ProgressBuilder {
  static Widget _progressBuilder(context, [double? value]) =>
      CircularProgressIndicator(value: value);

  static Widget _adaptiveProgressBuilder(context, [double? value]) =>
      CircularProgressIndicator.adaptive(value: value);

  const CircularProgressBuilder({
    required super.builder,
    super.onError,
    super.action,
    super.onDone,
    super.onStart,
    super.onSuccess,
    super.controller,
    super.key,
  }) : super(
          progressBuilder: _progressBuilder,
        );

  const CircularProgressBuilder.adaptive({
    required super.builder,
    super.onError,
    super.action,
    super.onDone,
    super.onStart,
    super.onSuccess,
    super.controller,
    super.key,
  }) : super(
          progressBuilder: _adaptiveProgressBuilder,
        );
}
