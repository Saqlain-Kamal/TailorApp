import 'package:flutter/material.dart';
import 'package:tailor_app/app/auth/screens/get_started.dart';
import 'package:tailor_app/app/auth/screens/login.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isShowing = false;

  void togglePages() {
    setState(() {
      isShowing = !isShowing;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isShowing) {
      return Login(onTap: togglePages);
    } else {
      return GetStarted(
        cxt: context,
        onTap: togglePages,
      );
    }
  }
}
