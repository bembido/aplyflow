import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            title: Text('No response threshold'),
            subtitle: Text('5 days'),
          ),
          ListTile(
            title: Text('Theme'),
            subtitle: Text('System'),
          ),
        ],
      ),
    );
  }
}
