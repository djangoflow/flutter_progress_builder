import 'package:flutter/material.dart';

import 'progress_builder.dart';

class LinearProgressBuilder extends ProgressBuilder {
  static Widget _progressBuilder([context, double? value]) =>
      LinearProgressIndicator(value: value);

  const LinearProgressBuilder({
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
}
