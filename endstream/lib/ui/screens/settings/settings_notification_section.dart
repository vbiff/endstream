import 'package:flutter/material.dart';

import 'settings_section_header.dart';
import 'settings_toggle_row.dart';

/// Notification settings section.
class SettingsNotificationSection extends StatelessWidget {
  const SettingsNotificationSection({
    super.key,
    required this.pushNotifications,
    required this.turnReminders,
    required this.onPushChanged,
    required this.onRemindersChanged,
  });

  final bool pushNotifications;
  final bool turnReminders;
  final ValueChanged<bool> onPushChanged;
  final ValueChanged<bool> onRemindersChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SettingsSectionHeader(title: 'NOTIFICATIONS'),
        SettingsToggleRow(
          label: 'Push Notifications',
          value: pushNotifications,
          onChanged: onPushChanged,
        ),
        SettingsToggleRow(
          label: 'Turn Reminders',
          value: turnReminders,
          onChanged: onRemindersChanged,
        ),
      ],
    );
  }
}
