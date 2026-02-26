import 'package:flutter/material.dart';

import 'settings_section_header.dart';
import 'settings_toggle_row.dart';

/// Game settings section.
class SettingsGameSection extends StatelessWidget {
  const SettingsGameSection({
    super.key,
    required this.autoEndTurn,
    required this.confirmEndTurn,
    required this.onAutoEndChanged,
    required this.onConfirmEndChanged,
  });

  final bool autoEndTurn;
  final bool confirmEndTurn;
  final ValueChanged<bool> onAutoEndChanged;
  final ValueChanged<bool> onConfirmEndChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SettingsSectionHeader(title: 'GAME'),
        SettingsToggleRow(
          label: 'Auto-End Turn',
          value: autoEndTurn,
          onChanged: onAutoEndChanged,
        ),
        SettingsToggleRow(
          label: 'Confirm End Turn',
          value: confirmEndTurn,
          onChanged: onConfirmEndChanged,
        ),
      ],
    );
  }
}
