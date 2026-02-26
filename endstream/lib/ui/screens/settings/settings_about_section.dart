import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import 'settings_section_header.dart';

/// About section showing version info.
class SettingsAboutSection extends StatelessWidget {
  const SettingsAboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsSectionHeader(title: 'ABOUT'),
        Text(
          'EndStream v0.1.0',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 13,
            color: TreeColors.textSecondary,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Tactical time-travel trading card game',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            color: TreeColors.dormant,
          ),
        ),
        SizedBox(height: 32),
      ],
    );
  }
}
