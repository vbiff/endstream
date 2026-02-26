import 'package:flutter/material.dart';

import '../../components/components.dart';

/// Search bar for finding players.
class FriendsSearchBar extends StatefulWidget {
  const FriendsSearchBar({super.key, required this.onSearch});

  final ValueChanged<String> onSearch;

  @override
  State<FriendsSearchBar> createState() => _FriendsSearchBarState();
}

class _FriendsSearchBarState extends State<FriendsSearchBar> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TreeInput(
        controller: _controller,
        hint: 'SEARCH PLAYERS',
        onSubmitted: widget.onSearch,
      ),
    );
  }
}
