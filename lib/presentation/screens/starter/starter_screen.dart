import 'package:aplyflow/presentation/app/router.dart';
import 'package:flutter/material.dart';

class StarterScreen extends StatelessWidget {
  const StarterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 20),

              // Top illustration / logo area
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/images/AplyFlow_logo_no_text.png',
                          width: 140,
                          height: 140,
                        ),
                      ),
                      const SizedBox(height: 48),

                      // Title
                      Text(
                        'One Flow.\nEvery Internship.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.displayMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Subtitle
                      Text(
                        'Track your applications, ace your interviews, and land your dream job with ease.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onBackground.withOpacity(0.7),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom Actions
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(AppRouter.auth);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 2,
                      shadowColor: theme.colorScheme.primary.withOpacity(0.4),
                    ),
                    child: const Text(
                      'Get Started',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Optional: A secondary button if you want one in the future
                  // TextButton(
                  //   onPressed: () {
                  //     Navigator.of(context).pushReplacementNamed(AppRouter.auth);
                  //   },
                  //   child: const Text('Log In'),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
