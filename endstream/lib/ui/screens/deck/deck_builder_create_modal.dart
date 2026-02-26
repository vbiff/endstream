import 'package:flutter/material.dart';

import '../../components/components.dart';

/// Modal for creating a new deck with a name input.
class DeckBuilderCreateModal extends StatefulWidget {
  const DeckBuilderCreateModal({super.key, required this.onCreate});

  final ValueChanged<String> onCreate;

  @override
  State<DeckBuilderCreateModal> createState() =>
      _DeckBuilderCreateModalState();
}

class _DeckBuilderCreateModalState extends State<DeckBuilderCreateModal> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleCreate() {
    final name = _controller.text.trim();
    if (name.isNotEmpty) {
      widget.onCreate(name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TreeModal(
      onClose: () => Navigator.of(context).pop(),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TreeInput(
              controller: _controller,
              hint: 'DECK NAME',
              onSubmitted: (_) => _handleCreate(),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TreeButton(
                    onPressed: _handleCreate,
                    label: 'CREATE',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TreeButton(
                    onPressed: () => Navigator.of(context).pop(),
                    label: 'CANCEL',
                    variant: TreeButtonVariant.secondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
