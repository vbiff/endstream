import 'package:flutter/material.dart';

import '../../../core/models/enums.dart';
import '../../components/components.dart';
import 'deck_editor_filter_chip.dart';

/// Filter bar with search input and card type filter chips.
class DeckEditorFilterBar extends StatelessWidget {
  const DeckEditorFilterBar({
    super.key,
    required this.searchController,
    required this.selectedType,
    required this.onSearchChanged,
    required this.onTypeSelected,
  });

  final TextEditingController searchController;
  final CardType? selectedType;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<CardType?> onTypeSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          TreeInput(
            controller: searchController,
            hint: 'SEARCH CARDS',
            onChanged: onSearchChanged,
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                DeckEditorFilterChip(
                  label: 'ALL',
                  isSelected: selectedType == null,
                  onTap: () => onTypeSelected(null),
                ),
                const SizedBox(width: 6),
                ...CardType.values.map((type) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: DeckEditorFilterChip(
                      label: type.name.toUpperCase(),
                      isSelected: selectedType == type,
                      onTap: () => onTypeSelected(
                        selectedType == type ? null : type,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
