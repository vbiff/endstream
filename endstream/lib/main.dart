import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/bloc_observer.dart';
import 'app/routes.dart';
import 'app/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  runApp(const EndStreamApp());
}

class EndStreamApp extends StatelessWidget {
  const EndStreamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'EndStream',
      debugShowCheckedModeBanner: false,
      theme: EndStreamTheme.data,
      routerConfig: AppRouter.instance,
    );
  }
}
