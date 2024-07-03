import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:streaming_app/page/login_data/component_login/my_button.dart';
import 'package:streaming_app/page/login_data/component_login/my_textfield.dart';

class LoginPage extends StatelessWidget {
  final Function()? onTap;

  LoginPage({super.key, required this.onTap});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void Login(BuildContext context) async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      pesan(context, "Silahkan isi semua kolom");
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: usernameController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'user-not-found') {
        message = 'Pengguna tidak ditemukan.';
      } else if (e.code == 'wrong-password') {
        message = 'Kata sandi salah.';
      } else {
        message = 'Terjadi kesalahan. Silakan coba lagi.';
      }
      pesan(context, message);
    } catch (e) {
      pesan(context, 'Terjadi kesalahan. Silakan coba lagi.');
    }
  }

  void pesan(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(text),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Oke"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.movie_filter_outlined, color: Colors.amber, size: 150),

            // welcome back, you've been missed!
            Text(
              'Welcome back you\'ve been missed!',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 25),

            // username textfield
            MyTextField(
              onSubmitted: (value) => Login(context),
              controller: usernameController,
              hintText: 'Username',
              obscureText: false,
            ),

            const SizedBox(height: 10),

            // password textfield
            MyTextField(
              onSubmitted: (value) => Login(context),
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
            ),

            const SizedBox(height: 10),

            // forgot password?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // sign in button
            MyButton(
              text: "Login",
              onTap: () => Login(context),
            ),
            const SizedBox(height: 15),

            // not a member? register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Not a member?',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(width: 4),
                InkWell(
                  onTap: onTap,
                  child: const Text(
                    'Register now',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
