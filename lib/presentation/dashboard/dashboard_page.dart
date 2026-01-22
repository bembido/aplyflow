import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: ListTile(title: Text('Total'), trailing: Text('12')),
            ),
            Card(
              child: ListTile(title: Text('Interviews'), trailing: Text('3')),
            ),
            Card(
              child: ListTile(title: Text('Offers'), trailing: Text('1')),
            ),
          ],
        ),
      ),
    );
  }
}
