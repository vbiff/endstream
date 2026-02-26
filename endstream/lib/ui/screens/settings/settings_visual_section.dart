import 'package:flutter/material.dart';

import 'settings_section_header.dart';
import 'settings_slider_row.dart';
import 'settings_toggle_row.dart';

/// Visual settings section.
class SettingsVisualSection extends StatelessWidget {
  const SettingsVisualSection({
    super.key,
    required this.reduceMotion,
    required this.treeDensity,
    required this.onReduceMotionChanged,
    required this.onTreeDensityChanged,
  });

  final bool reduceMotion;
  final double treeDensity;
  final ValueChanged<bool> onReduceMotionChanged;
  final ValueChanged<double> onTreeDensityChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SettingsSectionHeader(title: 'VISUAL'),
        SettingsToggleRow(
          label: 'Reduce Motion',
          value: reduceMotion,
          onChanged: onReduceMotionChanged,
        ),
        SettingsSliderRow(
          label: 'Tree Density',
          value: treeDensity,
          onChanged: onTreeDensityChanged,
        ),
      ],
    );
  }
}
