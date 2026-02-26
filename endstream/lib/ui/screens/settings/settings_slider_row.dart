import 'package:flutter/material.dart';

import '../../../app/theme.dart';

/// A row with a label and a styled slider.
class SettingsSliderRow extends StatelessWidget {
  const SettingsSliderRow({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final double value;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  color: TreeColors.textPrimary,
                ),
              ),
              Text(
                '${(value * 100).round()}%',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: TreeColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: TreeColors.branchActive,
              inactiveTrackColor: TreeColors.branchDefault,
              thumbColor: TreeColors.highlight,
              overlayColor: TreeColors.highlight.withValues(alpha: 0.1),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
              trackHeight: 2,
            ),
            child: Slider(
              value: value,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
