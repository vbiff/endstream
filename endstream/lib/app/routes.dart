import 'package:go_router/go_router.dart';

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

/// Application router configuration.
///
/// Encapsulated for testability and future DI of auth redirect logic.
abstract final class AppRouter {
  static GoRouter get instance => GoRouter(
        initialLocation: AppRoutes.splash,
        routes: _routes,
      );

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
      builder: (context, state) => const ActiveGamesScreen(),
      routes: [
        GoRoute(
          path: 'new',
          builder: (context, state) => const NewGameSetupScreen(),
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.gameBoard,
      builder: (context, state) => GameBoardScreen(
        gameId: state.pathParameters['gameId']!,
      ),
    ),
    GoRoute(
      path: AppRoutes.deckBuilder,
      builder: (context, state) => const DeckBuilderScreen(),
    ),
    GoRoute(
      path: AppRoutes.deckEditor,
      builder: (context, state) => DeckEditorScreen(
        deckId: state.pathParameters['deckId']!,
      ),
    ),
    GoRoute(
      path: AppRoutes.friends,
      builder: (context, state) => const FriendsScreen(),
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
