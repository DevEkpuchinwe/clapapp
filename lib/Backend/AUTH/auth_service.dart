import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<String> createUserAndDatabase(
      String email, String password, String name) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;
      //await get(Uri.http('worldtimeapi.org/api/timezone/Africa/Lagos'));
      final userDetails = <String, String>{
        "name": name,
        "email": email,
        "balance": "0.00",
        "coins": "0.00",
        "freecoins": "false"
      };
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection("users").doc(user!.uid).set(userDetails);
      //'name': name,
      //'email': email,
      //'balance': 0.00,
      //'coins': 0.00,
      return "success";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          return 'EMAIL USED: The email provided is already used.';
        case 'invalid-email':
          return 'INVALID EMAIL: Please provide a valid email.';
        case 'weak-password':
          return 'WEAK PASSWORD: Please provide a strong password.';
        default:
          return 'Error : $e';
      }
    }
  }

  Future<String> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "success";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return 'NO USER: No user found for that email';
        case 'wrong-password':
          return 'WRONG PASSWORD: The password is incorrect';
        default:
          return 'Error: $e';
      }
    }
  }

  Future<void> signout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log("Something went wrong");
    }
  }
}

final user = FirebaseAuth.instance.currentUser;
String userUid = user?.uid ?? '';
//String userName = user?.displayName ?? '';
String userEmail = user?.email ?? '';