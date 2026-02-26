import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme.dart';
import '../../../core/cubits/social/friends_cubit.dart';
import '../../components/components.dart';
import '../shared/shared.dart';
import 'friends_list_section.dart';
import 'friends_pending_section.dart';
import 'friends_search_bar.dart';

/// Friends list screen with search, pending requests, and online/offline sections.
class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const _FriendsTopBar(),
            FriendsSearchBar(
              onSearch: (query) async {
                final results =
                    await context.read<FriendsCubit>().searchPlayers(query);
                // Search results could be shown in a future iteration.
                if (results.isNotEmpty && context.mounted) {
                  context.read<FriendsCubit>().sendFriendRequest(results.first.id);
                }
              },
            ),
            const SizedBox(height: 8),
            const TreeDivider(),
            Expanded(
              child: BlocBuilder<FriendsCubit, FriendsState>(
                builder: (context, state) {
                  if (state is FriendsLoading || state is FriendsInitial) {
                    return const ScreenLoadingIndicator();
                  }
                  if (state is FriendsError) {
                    return ScreenErrorDisplay(
                      message: state.message,
                      onRetry: () =>
                          context.read<FriendsCubit>().loadFriends(),
                    );
                  }
                  if (state is FriendsLoaded) {
                    return _FriendsBody(state: state);
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FriendsTopBar extends StatelessWidget {
  const _FriendsTopBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: const Text(
              '<',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 18,
                color: TreeColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'FRIENDS',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 15,
              fontWeight: FontWeight.w400,
              letterSpacing: 2.0,
              color: TreeColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _FriendsBody extends StatelessWidget {
  const _FriendsBody({required this.state});

  final FriendsLoaded state;

  @override
  Widget build(BuildContext context) {
    final hasFriends =
        state.friends.isNotEmpty || state.pendingRequests.isNotEmpty;

    if (!hasFriends) {
      return const ScreenEmptyDisplay(
        message: 'No friends yet\nSearch to add friends',
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FriendsPendingSection(
            requests: state.pendingRequests,
            onAccept: (id) =>
                context.read<FriendsCubit>().acceptRequest(id),
            onDecline: (id) =>
                context.read<FriendsCubit>().declineRequest(id),
          ),
          FriendsListSection(
            label: 'ONLINE',
            friends: state.onlineFriends,
            isOnline: true,
            onTap: (id) => context.push('/friends/$id'),
          ),
          FriendsListSection(
            label: 'OFFLINE',
            friends: state.offlineFriends,
            isOnline: false,
            onTap: (id) => context.push('/friends/$id'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
