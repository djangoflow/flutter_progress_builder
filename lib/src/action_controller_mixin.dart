import 'package:flutter/material.dart';

import 'action_controller.dart';

mixin ActionControllerMixin<T extends StatefulWidget> on State<T> {
  late ActionController controller;

  @override
  void initState() {
    controller = ActionController();
    super.initState();
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }
}
