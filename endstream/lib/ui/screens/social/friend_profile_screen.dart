import 'package:flutter/material.dart';

class FriendProfileScreen extends StatelessWidget {
  const FriendProfileScreen({super.key, required this.friendId});

  final String friendId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Friend Profile: $friendId')),
    );
  }
}
