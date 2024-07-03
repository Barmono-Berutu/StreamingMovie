import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:streaming_app/page/login_data/component_login/my_button.dart';
import 'package:streaming_app/page/login_data/component_login/my_textfield.dart';

class RegisPage extends StatelessWidget {
  final Function()? onTap;
  final VoidCallback onRegisterSuccess;

  RegisPage({super.key, required this.onTap, required this.onRegisterSuccess});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final konfirmasiController = TextEditingController();

  // sign user in method
  void Regis(BuildContext context) async {
    if (usernameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        konfirmasiController.text.isEmpty) {
      pesan(context, "Harap isi semua kolom.");
      return;
    }
    if (passwordController.text != konfirmasiController.text) {
      pesan(context, "Password dan konfirmasi password tidak cocok.");
      return;
    }

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: usernameController.text,
        password: passwordController.text,
      );
      FirebaseFirestore.instance
          .collection("user")
          .doc(userCredential.user!.email)
          .set({
        "username": usernameController.text.split('@')[0],
        "bio": "jomblo"
      });
      onRegisterSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        pesan(context, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        pesan(context, 'The account already exists for that email.');
      }
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
      backgroundColor: Color(0xff1f1D2B),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                const Icon(
                  Icons.lock,
                  size: 100,
                ),

                const SizedBox(height: 25),

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
                  onSubmitted: (value) => Regis(context),
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  onSubmitted: (value) => Regis(context),
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                // password textfield
                MyTextField(
                  onSubmitted: (value) => Regis(context),
                  controller: konfirmasiController,
                  hintText: 'Konfirmasi Password',
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
                  onTap: () => Regis(context),
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
                        'Login now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
