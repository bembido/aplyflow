import 'package:aplyflow/presentation/app/router.dart';
import 'package:flutter/material.dart';

class StarterScreen extends StatelessWidget {
  const StarterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text('Starter Screen'),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(AppRouter.auth);
              },
              child: Text('Auth'),
            ),
          ],
        ),
      ),
    );
  }
}
