import 'package:clive/app.dart';
import 'package:dio_request_inspector/dio_request_inspector.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DioRequestInspectorMain(
    inspector: App.inspector,
    child: MyApp(),
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clive',
      home: App.sharedInstance,
      navigatorObservers: [
        DioRequestInspector.navigatorObserver,
      ],
    );
  }
}