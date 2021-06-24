# Progress Builder

A simple wrapper for asynchronous actions with progress/loading indications and error handling.

See a demo at: https://progress-builder.flutter.apexlabs.ai

## Usage

The following will:
* await the Future.delayed()
* show `LinearProgressIndicator` while it is being awaited
* print 'success' if successful
* print error: ...exception... at random in case of an exception
* print 'done' in all cases

```
import 'package:progress_builder/progress_builder.dart';

...
              LinearProgressBuilder(
                builder: (action) => ElevatedButton(
                  onPressed: action,
                  child: Text('PRESS ME'),
                ),
                action: (onProgress) async {
                  _showMessage('loading undetermined');
                  await Future.delayed(const Duration(seconds: 1));
                  for (final progress in [10, 20, 30, 40, 50, 60, 70, 80, 90]) {
                    _showMessage('loaded $progress%');
                    onProgress(100, progress);
                    await Future.delayed(const Duration(milliseconds: 500));
                  }
                  if (_random.nextBool()) {
                    throw Exception('Loading failed');
                  }
                  _showMessage('loaded');
                },
                onDone: () => _showMessage('done'),
                onError: (error) => _showSnackbar('error $error'),
                onSuccess: () => _showSnackbar('success'),
              ),

```

## TODO
[X] Add documentation on how to use the actual progress value callback

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/apexlabs-ai/progress_builder/issues
