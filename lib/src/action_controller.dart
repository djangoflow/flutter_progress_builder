import 'dart:async';

/// At the moment only start, but may add cancel in the future
enum ActionType { start }

typedef ActionController = StreamController<ActionType>;
