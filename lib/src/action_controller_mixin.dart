import 'package:flutter/material.dart';
import 'action_controller.dart';

mixin ActionControllerMixin<T extends StatefulWidget> on State<T> {
  late ActionController _controller;

  @override
  void initState() {
    _controller = ActionController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
