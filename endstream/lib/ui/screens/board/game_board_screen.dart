import 'package:flutter/material.dart';

class GameBoardScreen extends StatelessWidget {
  const GameBoardScreen({super.key, required this.gameId});

  final String gameId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Game Board: $gameId')),
    );
  }
}
