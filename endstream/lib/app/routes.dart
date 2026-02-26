import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../ui/animations/easing_curves.dart';

import '../core/cubits/auth/auth_cubit.dart';
import '../core/cubits/cards/card_collection_cubit.dart';
import '../core/cubits/decks/deck_editor_cubit.dart';
import '../core/cubits/decks/deck_list_cubit.dart';
import '../core/cubits/games/game_board_bloc.dart';
import '../core/cubits/games/game_list_cubit.dart';
import '../core/cubits/games/matchmaking_cubit.dart';
import '../core/cubits/social/friends_cubit.dart';
import '../core/services/cache_service.dart';
import '../core/services/impl/supabase_card_service.dart';
import '../core/services/impl/supabase_deck_service.dart';
import '../core/services/impl/supabase_game_service.dart';
import '../core/services/impl/supabase_social_service.dart';
import '../core/cubits/settings/settings_cubit.dart';
import '../ui/screens/auth/login_screen.dart';
import '../ui/screens/auth/register_screen.dart';
import '../ui/screens/auth/splash_screen.dart';
import '../ui/screens/board/game_board_screen.dart';
import '../ui/screens/deck/deck_builder_screen.dart';
import '../ui/screens/deck/deck_editor_screen.dart';
import '../ui/screens/games/active_games_screen.dart';
import '../ui/screens/games/matchmaking_screen.dart';
import '../ui/screens/games/new_game_setup_screen.dart';
import '../ui/screens/hub/main_hub_screen.dart';
import '../ui/screens/onboarding/onboarding_screen.dart';
import '../ui/screens/settings/settings_screen.dart';
import '../ui/screens/social/friend_profile_screen.dart';
import '../ui/screens/social/friends_screen.dart';
import '../ui/screens/tutorial/tutorial_screen.dart';

/// Route path constants.
abstract final class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const hub = '/hub';
  static const activeGames = '/games';
  static const newGame = '/games/new';
  static const matchmaking = '/games/matchmaking';
  static const gameBoard = '/games/:gameId';
  static const deckBuilder = '/decks';
  static const deckEditor = '/decks/:deckId';
  static const friends = '/friends';
  static const friendProfile = '/friends/:friendId';
  static const settings = '/settings';
  static const onboarding = '/onboarding';
  static const tutorial = '/tutorial';
}

/// Application router configuration with auth redirect logic.
abstract final class AppRouter {
  /// Set from main.dart before creating the router.
  static CacheService? cacheService;

  static GoRouter? _cachedInstance;

  /// Initialize the router. Call once from main().
  static void init() {
    _cachedInstance = GoRouter(
      initialLocation: AppRoutes.splash,
      redirect: _authRedirect,
      routes: _routes,
    );
  }

  /// Returns the cached router instance.
  static GoRouter get instance {
    assert(_cachedInstance != null, 'AppRouter.init() must be called first');
    return _cachedInstance!;
  }

  /// Global redirect based on authentication state.
  static String? _authRedirect(BuildContext context, GoRouterState state) {
    final authState = context.read<AuthCubit>().state;
    final isOnAuthPage = state.matchedLocation == AppRoutes.splash ||
        state.matchedLocation == AppRoutes.login ||
        state.matchedLocation == AppRoutes.register;

    if (authState is Authenticated && isOnAuthPage) {
      final settings = context.read<SettingsCubit>().state;
      if (!settings.onboardingCompleted) return AppRoutes.onboarding;
      return AppRoutes.hub;
    }
    if (authState is Unauthenticated &&
        !isOnAuthPage &&
        state.matchedLocation != AppRoutes.onboarding &&
        state.matchedLocation != AppRoutes.tutorial) {
      return AppRoutes.login;
    }
    return null;
  }

  static SupabaseClient get _supabase => Supabase.instance.client;

  static CustomTransitionPage<void> _buildPage(
    Widget child,
    GoRouterState state,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionDuration: TreeDurations.transition,
      reverseTransitionDuration: TreeDurations.normal,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final fade = CurvedAnimation(
          parent: animation,
          curve: TreeCurves.standard,
        );
        return FadeTransition(opacity: fade, child: child);
      },
    );
  }

  static final List<RouteBase> _routes = [
    GoRoute(
      path: AppRoutes.splash,
      pageBuilder: (context, state) =>
          _buildPage(const SplashScreen(), state),
    ),
    GoRoute(
      path: AppRoutes.login,
      pageBuilder: (context, state) =>
          _buildPage(const LoginScreen(), state),
    ),
    GoRoute(
      path: AppRoutes.register,
      pageBuilder: (context, state) =>
          _buildPage(const RegisterScreen(), state),
    ),
    GoRoute(
      path: AppRoutes.hub,
      pageBuilder: (context, state) =>
          _buildPage(const MainHubScreen(), state),
    ),
    GoRoute(
      path: AppRoutes.activeGames,
      pageBuilder: (context, state) => _buildPage(
        BlocProvider(
          create: (_) => GameListCubit(SupabaseGameService(_supabase))..loadGames(),
          child: const ActiveGamesScreen(),
        ),
        state,
      ),
      routes: [
        GoRoute(
          path: 'new',
          pageBuilder: (context, state) {
            final friendId = state.uri.queryParameters['friendId'];
            return _buildPage(
              MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (_) =>
                        GameListCubit(SupabaseGameService(_supabase))..loadGames(),
                  ),
                  BlocProvider(
                    create: (_) =>
                        DeckListCubit(SupabaseDeckService(_supabase))..loadDecks(),
                  ),
                ],
                child: NewGameSetupScreen(friendId: friendId),
              ),
              state,
            );
          },
        ),
        GoRoute(
          path: 'matchmaking',
          pageBuilder: (context, state) {
            final deckId = state.extra is String ? state.extra as String : '';
            return _buildPage(
              BlocProvider(
                create: (_) => MatchmakingCubit(SupabaseGameService(_supabase))
                  ..startSearching(deckId: deckId),
                child: const MatchmakingScreen(),
              ),
              state,
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.gameBoard,
      pageBuilder: (context, state) {
        final gameId = state.pathParameters['gameId'] ?? '';
        if (gameId.isEmpty) {
          return _buildPage(const SizedBox.shrink(), state);
        }
        return _buildPage(
          BlocProvider(
            create: (_) => GameBoardBloc(SupabaseGameService(_supabase))
              ..add(LoadGame(gameId)),
            child: GameBoardScreen(gameId: gameId),
          ),
          state,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.deckBuilder,
      pageBuilder: (context, state) => _buildPage(
        BlocProvider(
          create: (_) => DeckListCubit(SupabaseDeckService(_supabase))..loadDecks(),
          child: const DeckBuilderScreen(),
        ),
        state,
      ),
    ),
    GoRoute(
      path: AppRoutes.deckEditor,
      pageBuilder: (context, state) {
        final deckId = state.pathParameters['deckId'] ?? '';
        if (deckId.isEmpty) {
          return _buildPage(const SizedBox.shrink(), state);
        }
        return _buildPage(
          BlocProvider(
            create: (_) => DeckEditorCubit(
              deckService: SupabaseDeckService(_supabase),
              cardService: SupabaseCardService(_supabase, cacheService: cacheService),
            )..loadDeck(deckId),
            child: DeckEditorScreen(deckId: deckId),
          ),
          state,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.friends,
      pageBuilder: (context, state) => _buildPage(
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => FriendsCubit(SupabaseSocialService(_supabase))..loadFriends(),
            ),
            BlocProvider(
              create: (_) => CardCollectionCubit(
                SupabaseCardService(_supabase, cacheService: cacheService),
              ),
            ),
          ],
          child: const FriendsScreen(),
        ),
        state,
      ),
      routes: [
        GoRoute(
          path: ':friendId',
          pageBuilder: (context, state) {
            final friendId = state.pathParameters['friendId'] ?? '';
            if (friendId.isEmpty) {
              return _buildPage(const SizedBox.shrink(), state);
            }
            return _buildPage(
              BlocProvider(
                create: (_) => FriendsCubit(SupabaseSocialService(_supabase))..loadFriends(),
                child: FriendProfileScreen(friendId: friendId),
              ),
              state,
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.settings,
      pageBuilder: (context, state) =>
          _buildPage(const SettingsScreen(), state),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      pageBuilder: (context, state) =>
          _buildPage(const OnboardingScreen(), state),
    ),
    GoRoute(
      path: AppRoutes.tutorial,
      pageBuilder: (context, state) =>
          _buildPage(const TutorialScreen(), state),
    ),
  ];
}
