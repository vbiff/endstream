import 'package:flutter/material.dart';

import 'settings_section_header.dart';
import 'settings_slider_row.dart';

/// Audio settings section with volume sliders.
class SettingsAudioSection extends StatelessWidget {
  const SettingsAudioSection({
    super.key,
    required this.musicVolume,
    required this.sfxVolume,
    required this.onMusicChanged,
    required this.onSfxChanged,
  });

  final double musicVolume;
  final double sfxVolume;
  final ValueChanged<double> onMusicChanged;
  final ValueChanged<double> onSfxChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SettingsSectionHeader(title: 'AUDIO'),
        SettingsSliderRow(
          label: 'Music Volume',
          value: musicVolume,
          onChanged: onMusicChanged,
        ),
        SettingsSliderRow(
          label: 'SFX Volume',
          value: sfxVolume,
          onChanged: onSfxChanged,
        ),
      ],
    );
  }
}
