import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:streaming_app/component/bottom_navbar.dart';
import 'package:streaming_app/page/landing.dart';
import 'package:streaming_app/page/login_data/login/state_login.dart';

class Auth_Page extends StatelessWidget {
  const Auth_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BottomNavbar();
          } else {
            return StateLogin(
              onRegisterSuccess: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LandingPage()),
                );
              },
            );
          }
        },
      ),
    );
  }
}
