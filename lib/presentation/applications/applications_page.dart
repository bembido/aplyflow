import 'package:flutter/material.dart';

class ApplicationsPage extends StatelessWidget {
  const ApplicationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Applications')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('TCO - Intern Flontend'),
            subtitle: Text('Applied Company Site'),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            title: Text('Kaspi - Junior Flutter'),
            subtitle: Text('Interview Refferal'),
            trailing: Icon(Icons.chevron_right),
          )
        ],
      ),
    );
  }
}
