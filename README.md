# Progress Builder

A simple wrapper for asynchronous actions with progress/loading indications and error handling.

## Usage

The following will:
    - await the Future.delayed()
    - show `LinearProgressIndicator` while it is being awaited
    - print 'success' if successful
    - print error: ...exception... in case of an exception
    - print 'done' in all cases

```
import 'package:progress_builder/progress_builder.dart';

...
                LinearProgressBuilder(
                  builder: (action, _) => ElevatedButton(
                    onPressed: action,
                    child: Text('PRESS ME'),
                  ),
                  action: () async {
                    print('loading');
                    await Future.delayed(const Duration(seconds: 2));
                    print('loaded');
                  },
                  onDone: () => print('done'),
                  onError: (error) => print('error $error'),
                  onSuccess: () => print('success'),
                ),

```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/apexlabs-ai/progress_builder/issues
