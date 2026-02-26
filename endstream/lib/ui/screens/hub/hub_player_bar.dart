import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/theme.dart';
import '../../../core/cubits/auth/auth_cubit.dart';
import '../../components/components.dart';

/// Player info bar showing name, rank badge, and avatar node.
class HubPlayerBar extends StatelessWidget {
  const HubPlayerBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthCubitState>(
      builder: (context, state) {
        if (state is! Authenticated) return const SizedBox.shrink();
        final player = state.player;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              const TreeNode(
                size: 14,
                color: TreeColors.highlight,
                shape: TreeNodeShape.diamond,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      player.displayName.toUpperCase(),
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.0,
                        color: TreeColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'RANK ${player.rank}',
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        letterSpacing: 1.0,
                        color: TreeColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              TreeBadge(
                text: 'XP ${player.xp}',
                color: TreeColors.activation,
              ),
            ],
          ),
        );
      },
    );
  }
}
