import 'package:clive/util/route/route_handler.dart';
import 'package:dio_request_inspector/dio_request_inspector.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({super.key});
  static final App sharedInstance = App();

  static final DioRequestInspector inspector = DioRequestInspector(
    isInspectorEnabled: true,
  );

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: RouteHandler.routes,
      initialRoute: RouteHandler.initialRoute,
      onGenerateRoute: RouteHandler.onGenerateRoute,
    );
  }
}
