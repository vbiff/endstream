import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'firebase_options.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/audio_initializer.dart';
import 'app/bloc_observer.dart';
import 'app/push_notification_initializer.dart';
import 'app/routes.dart';
import 'app/theme.dart';
import 'core/cubits/auth/auth_cubit.dart';
import 'core/cubits/settings/settings_cubit.dart';
import 'core/data/database_provider.dart';
import 'core/services/audio_service.dart';
import 'core/services/auth_service.dart';
import 'core/services/cache_service.dart';
import 'core/services/impl/audio_player_audio_service.dart';
import 'core/services/impl/drift_cache_service.dart';
import 'core/services/impl/fcm_push_service.dart';
import 'core/services/impl/supabase_auth_service.dart';
import 'core/services/push_service.dart';
import 'ui/background/time_tree_shell.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();

  // Load environment variables
  await dotenv.load();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Initialize Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();

  // Initialize local database for caching
  final database = constructDb();
  final cacheService = DriftCacheService(database);

  AppRouter.cacheService = cacheService;

  // Create services once — not inside build()
  final supabase = Supabase.instance.client;
  final authService = SupabaseAuthService(supabase);
  final pushService = FcmPushService(supabase);
  final audioService = AudioPlayerAudioService();

  // Initialize the cached router
  AppRouter.init();

  final sentryDsn = dotenv.env['SENTRY_DSN'] ?? '';

  if (sentryDsn.isNotEmpty && !kDebugMode) {
    await SentryFlutter.init(
      (options) {
        options.dsn = sentryDsn;
        options.tracesSampleRate = 0.2;
        options.environment = kReleaseMode ? 'production' : 'staging';
      },
      appRunner: () => runApp(
        EndStreamApp(
          prefs: prefs,
          cacheService: cacheService,
          authService: authService,
          pushService: pushService,
          audioService: audioService,
        ),
      ),
    );
  } else {
    runApp(EndStreamApp(
      prefs: prefs,
      cacheService: cacheService,
      authService: authService,
      pushService: pushService,
      audioService: audioService,
    ));
  }
}

class EndStreamApp extends StatelessWidget {
  const EndStreamApp({
    super.key,
    required this.prefs,
    required this.cacheService,
    required this.authService,
    required this.pushService,
    required this.audioService,
  });

  final SharedPreferences prefs;
  final CacheService cacheService;
  final AuthService authService;
  final PushService pushService;
  final AudioService audioService;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthCubit(authService),
        ),
        BlocProvider(
          create: (_) => SettingsCubit(prefs),
        ),
      ],
      child: AudioInitializer(
        audioService: audioService,
        child: PushNotificationInitializer(
          pushService: pushService,
          child: MaterialApp.router(
            title: 'EndStream',
            debugShowCheckedModeBanner: false,
            theme: EndStreamTheme.data,
            routerConfig: AppRouter.instance,
            builder: (context, child) => TimeTreeShell(child: child!),
          ),
        ),
      ),
    );
  }
}
