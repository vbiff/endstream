import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/cubits/auth/auth_cubit.dart';
import '../core/cubits/cards/card_collection_cubit.dart';
import '../core/cubits/decks/deck_editor_cubit.dart';
import '../core/cubits/decks/deck_list_cubit.dart';
import '../core/cubits/games/game_board_bloc.dart';
import '../core/cubits/games/game_list_cubit.dart';
import '../core/cubits/social/friends_cubit.dart';
import '../core/services/card_service.dart';
import '../core/services/deck_service.dart';
import '../core/services/game_service.dart';
import '../core/services/social_service.dart';
import '../ui/screens/auth/login_screen.dart';
import '../ui/screens/auth/register_screen.dart';
import '../ui/screens/auth/splash_screen.dart';
import '../ui/screens/board/game_board_screen.dart';
import '../ui/screens/deck/deck_builder_screen.dart';
import '../ui/screens/deck/deck_editor_screen.dart';
import '../ui/screens/games/active_games_screen.dart';
import '../ui/screens/games/new_game_setup_screen.dart';
import '../ui/screens/hub/main_hub_screen.dart';
import '../ui/screens/settings/settings_screen.dart';
import '../ui/screens/social/friend_profile_screen.dart';
import '../ui/screens/social/friends_screen.dart';

/// Route path constants.
abstract final class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const hub = '/hub';
  static const activeGames = '/games';
  static const newGame = '/games/new';
  static const gameBoard = '/games/:gameId';
  static const deckBuilder = '/decks';
  static const deckEditor = '/decks/:deckId';
  static const friends = '/friends';
  static const friendProfile = '/friends/:friendId';
  static const settings = '/settings';
}

/// Application router configuration with auth redirect logic.
abstract final class AppRouter {
  static GoRouter get instance {
    return GoRouter(
      initialLocation: AppRoutes.splash,
      redirect: _authRedirect,
      routes: _routes,
    );
  }

  /// Global redirect based on authentication state.
  static String? _authRedirect(BuildContext context, GoRouterState state) {
    final authState = context.read<AuthCubit>().state;
    final isOnAuthPage = state.matchedLocation == AppRoutes.splash ||
        state.matchedLocation == AppRoutes.login ||
        state.matchedLocation == AppRoutes.register;

    if (authState is Authenticated && isOnAuthPage) {
      return AppRoutes.hub;
    }
    if (authState is Unauthenticated && !isOnAuthPage) {
      return AppRoutes.login;
    }
    return null;
  }

  static SupabaseClient get _supabase => Supabase.instance.client;

  static final List<RouteBase> _routes = [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: AppRoutes.hub,
      builder: (context, state) => const MainHubScreen(),
    ),
    GoRoute(
      path: AppRoutes.activeGames,
      builder: (context, state) => BlocProvider(
        create: (_) => GameListCubit(GameService(_supabase))..loadGames(),
        child: const ActiveGamesScreen(),
      ),
      routes: [
        GoRoute(
          path: 'new',
          builder: (context, state) => BlocProvider(
            create: (_) => DeckListCubit(DeckService(_supabase))..loadDecks(),
            child: const NewGameSetupScreen(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.gameBoard,
      builder: (context, state) {
        final gameId = state.pathParameters['gameId']!;
        return BlocProvider(
          create: (_) => GameBoardBloc(GameService(_supabase))
            ..add(LoadGame(gameId)),
          child: GameBoardScreen(gameId: gameId),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.deckBuilder,
      builder: (context, state) => BlocProvider(
        create: (_) => DeckListCubit(DeckService(_supabase))..loadDecks(),
        child: const DeckBuilderScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.deckEditor,
      builder: (context, state) {
        final deckId = state.pathParameters['deckId']!;
        return BlocProvider(
          create: (_) => DeckEditorCubit(
            deckService: DeckService(_supabase),
            cardService: CardService(_supabase),
          )..loadDeck(deckId),
          child: DeckEditorScreen(deckId: deckId),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.friends,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => FriendsCubit(SocialService(_supabase))..loadFriends(),
          ),
          BlocProvider(
            create: (_) => CardCollectionCubit(CardService(_supabase)),
          ),
        ],
        child: const FriendsScreen(),
      ),
      routes: [
        GoRoute(
          path: ':friendId',
          builder: (context, state) => FriendProfileScreen(
            friendId: state.pathParameters['friendId']!,
          ),
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.settings,
      builder: (context, state) => const SettingsScreen(),
    ),
  ];
}
