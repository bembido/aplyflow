import 'package:flutter/material.dart';

class FollowupsPage extends StatelessWidget {
  const FollowupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Follow - ups')),
      body: ListView(
        children: [
          ListTile(
            title: Text('Write to TCO'),
            subtitle: Text('Due: tomorrow'),
            trailing: Icon(Icons.circle_outlined),
          ),
        ],
      ),
    );
  }
}
