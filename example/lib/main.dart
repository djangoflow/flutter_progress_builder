import 'dart:math';

import 'package:flutter/material.dart';
import 'package:progress_builder/progress_builder.dart';
import 'package:widget_with_codeview/widget_with_codeview.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Progress Builder Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
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
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _random = Random();
  String _message = '';

  void _showMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  void _showSnackbar(String message) => ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(message)));

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LinearProgressBuilder(
            builder: (action, error) => Column(
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
          Text(_message)
        ],
        // This trailing comma makes auto-formatting nicer for build methods.
      );
}
