import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme.dart';
import '../../components/components.dart';
import 'hub_navigation_branch.dart';

/// Navigation panel with branches to main sections.
class HubNavigationPanel extends StatelessWidget {
  const HubNavigationPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          HubNavigationBranch(
            label: 'ACTIVE GAMES',
            onTap: () => context.push('/games'),
          ),
          const _HubBranchConnector(),
          HubNavigationBranch(
            label: 'DECK BUILDER',
            onTap: () => context.push('/decks'),
          ),
          const _HubBranchConnector(),
          HubNavigationBranch(
            label: 'FRIENDS',
            onTap: () => context.push('/friends'),
          ),
          const _HubBranchConnector(),
          HubNavigationBranch(
            label: 'SETTINGS',
            onTap: () => context.push('/settings'),
          ),
        ],
      ),
    );
  }
}

class _HubBranchConnector extends StatelessWidget {
  const _HubBranchConnector();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 24),
      child: TreeBranch(
        direction: TreeBranchDirection.vertical,
        length: 20,
        color: TreeColors.branchDefault,
      ),
    );
  }
}
