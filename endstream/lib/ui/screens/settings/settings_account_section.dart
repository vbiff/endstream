import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/theme.dart';
import '../../../core/cubits/auth/auth_cubit.dart';
import '../../components/components.dart';
import 'settings_section_header.dart';

/// Account section showing player info and sign-out button.
class SettingsAccountSection extends StatelessWidget {
  const SettingsAccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SettingsSectionHeader(title: 'ACCOUNT'),
        BlocBuilder<AuthCubit, AuthCubitState>(
          builder: (context, state) {
            if (state is Authenticated) {
              return _SettingsAccountInfo(
                displayName: state.player.displayName,
                rank: state.player.rank,
              );
            }
            return const SizedBox.shrink();
          },
        ),
        const SizedBox(height: 16),
        TreeButton(
          onPressed: () => context.read<AuthCubit>().signOut(),
          label: 'SIGN OUT',
          variant: TreeButtonVariant.danger,
        ),
      ],
    );
  }
}

class _SettingsAccountInfo extends StatelessWidget {
  const _SettingsAccountInfo({
    required this.displayName,
    required this.rank,
  });

  final String displayName;
  final int rank;

  @override
  Widget build(BuildContext context) {
    return TreeCard(
      child: Row(
        children: [
          const TreeNode(size: 10, color: TreeColors.highlight),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                displayName,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14,
                  color: TreeColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'RANK $rank',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  letterSpacing: 1.0,
                  color: TreeColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
