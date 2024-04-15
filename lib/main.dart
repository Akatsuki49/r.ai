import 'package:arithmania_frontend/auth/firebase_auth_methods.dart';
import 'package:arithmania_frontend/firebase_options.dart';
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
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthMethods>(
          create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
        ),
        // Other providers if any
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ReadMore',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasData && snapshot.data != null) {
              // return const WhoReading(); // If user is logged in, show home screen
              return HomeScreen();
            } else {
              return WelcomePage(); // If user is not logged in, show login screen
            }
          },
        ),
      ),
    );
  }
}
