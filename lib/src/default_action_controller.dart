import 'package:flutter/material.dart';

import 'action_controller.dart';
import 'action_controller_mixin.dart';

class DefaultActionController extends StatefulWidget {
  const DefaultActionController({
    required this.child,
    this.broadcast = true,
    Key? key,
  }) : super(key: key);

  /// The widget below this widget in the tree.
  final Widget child;

  /// Create a broadcast stream
  final bool broadcast;

  static ActionController? of(BuildContext context) => context
      .findAncestorStateOfType<_DefaultActionControllerState>()
      ?.controller;

  @override
  _DefaultActionControllerState createState() =>
      _DefaultActionControllerState();
}

class _DefaultActionControllerState extends State<DefaultActionController>
    with ActionControllerMixin {
  @override
  void initState() {
    super.initState();
    controller =
        widget.broadcast ? ActionController.broadcast() : ActionController();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
