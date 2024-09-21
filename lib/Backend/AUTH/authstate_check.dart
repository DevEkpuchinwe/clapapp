import 'package:clapapp/Backend/AUTH/login_screen.dart';
import 'package:clapapp/Backend/PIN/pin_auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show a loading spinner while waiting
        } else if (snapshot.hasData) {
          // User is signed in
          return const PinAuthScreen();
        } else {
          // User is not signed in
          return const LoginScreen();
        }
      },
    );
  }
}
