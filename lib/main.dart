// import 'package:aplyflow/presentation/app/home_shell.dart';
import 'package:aplyflow/presentation/auth/auth_page.dart';
// import 'package:aplyflow/presentation/auth/login_screen.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(AplyFlowApp());
}

class AplyFlowApp extends StatelessWidget {
  const AplyFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "AplyFlow",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: AuthPage()
    );
  }
}