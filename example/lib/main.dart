import 'package:flutter/material.dart';
import 'package:progress_builder/progress_builder.dart';
import 'package:widget_with_codeview/widget_with_codeview.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Progress Builder Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Scaffold(
          body: WidgetWithCodeView(
            sourceFilePath: 'lib/main.dart',
            codeLinkPrefix:
                'https://github.com/apexlabs-ai/progress_builder/blob/master/example',
            child: MyHomePage(),
          ),
        ),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _fail = true;
  String _message = '';

  void _showMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  void _showSnackbar(String message) => ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(message)));

  @override
  Widget build(BuildContext context) => DefaultActionController(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LinearProgressBuilder(
              builder: (context, action, error) => Column(
                children: [
                  ElevatedButton(
                    onPressed: action,
                    child: const Text(
                      '50/50 chance of success',
                    ),
                  ),
                  if (error != null)
                    Container(
                      color: Colors.red,
                      padding: const EdgeInsets.all(16.0),
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
            Text(_message),
            // We need this to have the DefaultActionController in the context
            Builder(
              builder: (context) => ElevatedButton(
                onPressed: () =>
                    DefaultActionController.of(context)?.add(ActionType.start),
                child: const Text('Trigger action via controller'),
              ),
            )
          ],
          // This trailing comma makes auto-formatting nicer for build methods.
        ),
      );
}
