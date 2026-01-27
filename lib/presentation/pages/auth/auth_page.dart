import 'package:aplyflow/presentation/app/home_shell.dart';
import 'package:aplyflow/presentation/pages/auth/login_screen.dart';
import 'package:aplyflow/presentation/pages/auth/signup_screen.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool page = true;
  void next(){
    setState(() {
      page = !page;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (page){
      return LoginScreen(next);
    } else{
      return SignupScreen(next);
    }
  }
}