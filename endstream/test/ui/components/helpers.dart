import 'package:endstream/app/theme.dart';
import 'package:flutter/material.dart';

/// Wraps a widget in MaterialApp with the EndStream theme for testing.
Widget testApp(Widget child) {
  return MaterialApp(
    theme: EndStreamTheme.data,
    home: Scaffold(body: child),
  );
}

/// Wraps a widget in MaterialApp with disableAnimations set via MediaQuery.
Widget testAppWithReducedMotion(Widget child) {
  return MaterialApp(
    theme: EndStreamTheme.data,
    home: MediaQuery(
      data: const MediaQueryData(disableAnimations: true),
      child: Scaffold(body: child),
    ),
  );
}
