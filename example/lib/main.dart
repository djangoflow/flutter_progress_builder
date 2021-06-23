import 'package:flutter/material.dart';
import 'package:progress_builder/progress_builder.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Progress Builder Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                Text('Watch the console for messages')
              ]),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
}
