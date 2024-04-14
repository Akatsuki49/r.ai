import 'package:arithmania_frontend/auth/firebase_auth_methods.dart';
import 'package:arithmania_frontend/firebase_options.dart';
import 'package:arithmania_frontend/screens/get_started.dart';
import 'package:arithmania_frontend/welcomepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ReadMore',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: WelcomePage());
  }
}
