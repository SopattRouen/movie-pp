import 'package:flutter/material.dart';
import 'package:movietime/src/auth/login-page.dart';
import 'package:movietime/src/auth/register-page.dart';

class AuthControllPage extends StatefulWidget {
  const AuthControllPage({super.key});

  @override
  State<AuthControllPage> createState() => _AuthControllPageState();
}

class _AuthControllPageState extends State<AuthControllPage> {
  bool isLogin = true;
  void toogleScreen() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      return LoginPage(showRegister: toogleScreen);
    } else {
      return RegisterPage(showLogin: toogleScreen);
    }
  }
}
