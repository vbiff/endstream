import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    log('onCreate: ${bloc.runtimeType}', name: 'BLoC');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log(
      'onChange: ${bloc.runtimeType}\n'
      '  current: ${change.currentState}\n'
      '  next: ${change.nextState}',
      name: 'BLoC',
    );
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log(
      'onError: ${bloc.runtimeType}\n$error',
      name: 'BLoC',
      error: error,
      stackTrace: stackTrace,
    );

    // Report BLoC errors to Sentry with context
    Sentry.captureException(
      error,
      stackTrace: stackTrace,
      withScope: (scope) {
        scope.setTag('bloc', bloc.runtimeType.toString());
      },
    );
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    log('onClose: ${bloc.runtimeType}', name: 'BLoC');
  }
}
