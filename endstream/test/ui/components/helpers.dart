import 'package:endstream/app/theme.dart';
import 'package:flutter/material.dart';

/// Wraps a widget in MaterialApp with the EndStream theme for testing.
Widget testApp(Widget child) {
  return MaterialApp(
    theme: EndStreamTheme.data,
    home: Scaffold(body: child),
  );
}
