import 'package:clive/app.dart';
import 'package:dio_request_inspector/dio_request_inspector.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DioRequestInspectorMain(
    inspector: App.inspector,
    child: App.sharedInstance,
  ));
}