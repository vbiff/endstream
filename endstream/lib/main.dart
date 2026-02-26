import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/bloc_observer.dart';
import 'app/routes.dart';
import 'app/theme.dart';
import 'core/cubits/auth/auth_cubit.dart';
import 'core/cubits/settings/settings_cubit.dart';
import 'core/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();

  // Load environment variables
  await dotenv.load();

  // Initialize Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();

  runApp(EndStreamApp(prefs: prefs));
}

class EndStreamApp extends StatelessWidget {
  const EndStreamApp({super.key, required this.prefs});

  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;
    final authService = AuthService(supabase);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthCubit(authService)..checkSession(),
        ),
        BlocProvider(
          create: (_) => SettingsCubit(prefs),
        ),
      ],
      child: MaterialApp.router(
        title: 'EndStream',
        debugShowCheckedModeBanner: false,
        theme: EndStreamTheme.data,
        routerConfig: AppRouter.instance,
      ),
    );
  }
}
