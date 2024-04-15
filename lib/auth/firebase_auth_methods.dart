// ignore_for_file: use_build_context_synchronously
import 'package:arithmania_frontend/auth/login_email_screen.dart';
import 'package:arithmania_frontend/auth/signup_screen.dart';
import 'package:arithmania_frontend/screens/home_screen.dart';
import 'package:arithmania_frontend/welcomepage.dart';
import 'package:arithmania_frontend/widgets/snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  //State Management
  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();

  User get user => _auth.currentUser!;

  //SignUp using Email
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) {
            return const EmailPasswordLogin();
          },
        ),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      displaySnackBar(context, e.message!);
    }
  }

  //SignIn using Email
  Future<void> signInWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) {
            return const EmailPasswordSignup();
          },
        ),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      displaySnackBar(context, e.message!);
    }
  }

  // GOOGLE SIGN IN
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // ignore: unused_local_variable
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) {
            // return BookList();
            // return const WhoReading();
            return HomeScreen();
          },
        ),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      displaySnackBar(context, e.message!);
    }
  }

  //Sign Out
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) {
            return WelcomePage();
          },
        ),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      displaySnackBar(context, e.message!);
    }
  }

  //CHECK FOR EXISTING PROFILE
  Future<bool> checkProfile() async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((value) {
      if (value.exists) {
        return true;
      } else {
        return false;
      }
    });
  }
}
