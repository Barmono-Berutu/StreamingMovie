import 'package:flutter/material.dart';
import 'package:streaming_app/page/login_data/login/login_page.dart';
import 'package:streaming_app/page/login_data/login/register.dart';

class StateLogin extends StatefulWidget {
  final VoidCallback onRegisterSuccess;

  const StateLogin({super.key, required this.onRegisterSuccess});

  @override
  State<StateLogin> createState() => _StateLoginState();
}

class _StateLoginState extends State<StateLogin> {
  bool isLogin = true;

  void toggleLogin() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      return LoginPage(onTap: toggleLogin);
    } else {
      return RegisPage(
        onTap: toggleLogin,
        onRegisterSuccess: widget.onRegisterSuccess,
      );
    }
  }
}
