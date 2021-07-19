import 'package:flutter/material.dart';

import 'action_controller.dart';

class DefaultActionController extends StatefulWidget {
  const DefaultActionController({
    required this.child,
    Key? key,
  }) : super(key: key);

  /// The widget below this widget in the tree.
  final Widget child;

  static ActionController? of(BuildContext context) => context
      .findAncestorStateOfType<_DefaultActionControllerState>()
      ?._controller;

  @override
  _DefaultActionControllerState createState() =>
      _DefaultActionControllerState();
}

class _DefaultActionControllerState extends State<DefaultActionController> {
  late ActionController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ActionController();
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
