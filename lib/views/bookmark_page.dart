import 'package:flutter/material.dart';

final class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          'Bookmarks will appear here',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}