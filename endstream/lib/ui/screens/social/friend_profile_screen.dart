import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme.dart';
import '../../../core/cubits/social/friends_cubit.dart';
import '../../components/components.dart';
import '../shared/shared.dart';
import 'friend_profile_actions.dart';
import 'friend_profile_header.dart';
import 'friend_profile_stats.dart';

/// Friend profile screen showing details and actions.
class FriendProfileScreen extends StatelessWidget {
  const FriendProfileScreen({super.key, required this.friendId});

  final String friendId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const _FriendProfileTopBar(),
            Expanded(
              child: BlocBuilder<FriendsCubit, FriendsState>(
                buildWhen: (previous, current) =>
                    current is! FriendsLoaded ||
                    previous is! FriendsLoaded ||
                    previous != current,
                builder: (context, state) {
                  if (state is! FriendsLoaded) {
                    return const ScreenLoadingIndicator();
                  }

                  final friend = state.friends
                      .where((f) => f.id == friendId)
                      .firstOrNull;

                  if (friend == null) {
                    return const ScreenErrorDisplay(
                      message: 'Friend not found',
                    );
                  }

                  final isOnline = state.onlineIds.contains(friendId);

                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 32),
                        FriendProfileHeader(
                          displayName: friend.displayName,
                          rank: friend.rank,
                          isOnline: isOnline,
                        ),
                        const SizedBox(height: 24),
                        const TreeDivider(),
                        const SizedBox(height: 16),
                        const FriendProfileStats(),
                        const SizedBox(height: 24),
                        FriendProfileActions(
                          onChallenge: () {
                            context.push('/games/new?friendId=$friendId');
                          },
                          onRemove: () async {
                            final cubit = context.read<FriendsCubit>();
                            final nav = GoRouter.of(context);
                            await cubit.removeFriend(friendId);
                            nav.pop();
                          },
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FriendProfileTopBar extends StatelessWidget {
  const _FriendProfileTopBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Semantics(
            button: true,
            label: 'Go back',
            child: GestureDetector(
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
          ),
          const SizedBox(width: 16),
          const Text(
            'PROFILE',
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
