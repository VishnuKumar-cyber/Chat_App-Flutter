import 'package:demo_app/Authentication/login.dart';
import 'package:demo_app/Authentication/registration.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool ShowPages = true;

  void TogglePages() {
    setState(() {
      ShowPages = !ShowPages;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (ShowPages) {
      return LoginForm(onTap: TogglePages);
    } else {
      return RegisterForm(onTap: TogglePages);
    }
  }
}
