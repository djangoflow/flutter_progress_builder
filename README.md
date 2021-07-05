# Progress Builder

A short-hand builder for performing simple asynchronous actions with progress/loading indications and built-in error
handling.

Demo at: https://progress-builder.flutter.apexlabs.ai

You can think of this widget as a short-hand for:

```
SomeButton(
    ...
    onPressed: () async {
        onStart...
        showLoading...

        try {
            await doAction... showProgress... 10...20...30...
            showLoaded...
            onSuccess...

        } catch(e) {
            onError...
        } finally {
            onDone...
        }
    }
    ...
```

Anything more complex than that, you probably should be using a `Cubit` or `Bloc`



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
            builder: (context, action, error) => Column(
              children: [
                ElevatedButton(
                  onPressed: action,
                  child: Text(
                    '50/50 chance of success',
                  ),
                ),
                if (error != null)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.all(16.0),
                    child: Text(error.toString()),
                  )
              ],
            ),
            action: (onProgress) async {
              _fail = !_fail;
              _showMessage('loading undetermined');
              await Future.delayed(const Duration(seconds: 1));
              for (final progress in [10, 20, 30, 40, 50, 60, 70, 80, 90]) {
                _showMessage('loaded $progress%');
                onProgress(progress / 100);
                await Future.delayed(const Duration(milliseconds: 200));
              }
              if (_fail) {
                throw Exception('Loading failed');
              }
              _showMessage('loaded');
            },
            onDone: () => _showMessage('done'),
            onError: (error) => _showSnackbar('error $error'),
            onSuccess: () => _showSnackbar('success'),
          ),
```

### Usage with reactive_forms

This packages comes very handy together with https://pub.dev/packages/reactive_forms

You can wrap your submit button with, for example, below:

```
LinearProgressBuilder(
  action: (_) async {
    // your action
  },
  onError: (e) {
   // handle your exceptions here
  },
  onSuccess: () {
    // do something
  },
  builder: (context, action, error) =>
      ElevatedButton(
        onPressed: (ReactiveForm.of(context)?.valid ?? false) ? action : null,
        child: const Text('...your action text'),
      ),
);
```

## TODO

[X] Add documentation on how to use the actual progress value callback

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/apexlabs-ai/progress_builder/issues
