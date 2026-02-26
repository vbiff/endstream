import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../components/components.dart';
import 'hub_navigation_panel.dart';
import 'hub_player_bar.dart';

/// Main hub screen — central navigation for the app.
class MainHubScreen extends StatelessWidget {
  const MainHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HubPlayerBar(),
            TreeDivider(),
            SizedBox(height: 32),
            _HubTitle(),
            SizedBox(height: 32),
            HubNavigationPanel(),
          ],
        ),
      ),
    );
  }
}

class _HubTitle extends StatelessWidget {
  const _HubTitle();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'ENDSTREAM',
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 22,
        fontWeight: FontWeight.w300,
        letterSpacing: 4.0,
        color: TreeColors.textPrimary,
      ),
    );
  }
}
