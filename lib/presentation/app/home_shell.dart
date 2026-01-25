import 'package:aplyflow/presentation/applications/applications_page.dart';
import 'package:aplyflow/presentation/dashboard/dashboard_page.dart';
import 'package:aplyflow/presentation/followups/followups_page.dart';
import 'package:aplyflow/presentation/settings/settings_page.dart';
import 'package:flutter/material.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int index = 0;
  final pages = [
      ApplicationsPage(),
      DashboardPage(),
      FollowupsPage(),
      SettingsPage(),
    ];

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() {
          index = value;
        }),
        destinations: [
          NavigationDestination(icon: Icon(Icons.work_outline), label: 'Apps'),
          NavigationDestination(icon: Icon(Icons.analytics_outlined), label: 'Status'),
          NavigationDestination(icon: Icon(Icons.notifications_outlined), label: 'To-do'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'Settings'),
          
        ],
      ),
    );
  }
}
