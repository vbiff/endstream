import 'package:flutter/material.dart';

class DeckEditorScreen extends StatelessWidget {
  const DeckEditorScreen({super.key, required this.deckId});

  final String deckId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Deck Editor: $deckId')),
    );
  }
}
