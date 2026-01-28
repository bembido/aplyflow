// import 'package:aplyflow/presentation/app/home_shell.dart';
// import 'package:aplyflow/presentation/pages/auth/auth_page.dart';
import 'package:aplyflow/presentation/app/router.dart';
// import 'package:aplyflow/presentation/screens/splash/splash_screen.dart';
// import 'package:aplyflow/presentation/auth/login_screen.dart';
import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

void main(){

  // await Supabase.initialize(anonKey: , url: );

  runApp(AplyFlowApp());
}

class AplyFlowApp extends StatelessWidget {
  const AplyFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRouter.splash,
      onGenerateRoute: AppRouter.onGenerateRoute,
      title: "AplyFlow",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      // home: SplashScreen()
    );
  }
}