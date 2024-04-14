import 'package:arithmania_frontend/auth/firebase_auth_methods.dart';
import 'package:arithmania_frontend/widgets/auth_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage2 extends StatefulWidget {
  @override
  State<LoginPage2> createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void loginUser() async {
    context.read<FirebaseAuthMethods>().signInWithEmail(
          email: emailController.text,
          password: passwordController.text,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/starbuckslogo2.png', // Replace 'path_to_your_image.png' with the actual path to your image asset
              height: 352,
              fit: BoxFit
                  .cover, // This ensures the image covers the entire space without distortion
            ),

            const Padding(
              padding: EdgeInsets.only(left: 28, top: 40),
              child: Text(
                'Enter your',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 51,
                  fontFamily: 'Clash Grotesk',
                  fontWeight: FontWeight.w600,
                  height: 0.02,
                  letterSpacing: 1.03,
                ),
              ),
            ),
            const SizedBox(height: 50), // Add space between "email" and button
            const Padding(
              padding: EdgeInsets.only(left: 28, bottom: 20),
              child: Text(
                'email',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 51,
                  fontFamily: 'Clash Grotesk',
                  fontWeight: FontWeight.w600,
                  height: 0.02,
                  letterSpacing: 1.03,
                ),
              ),
            ),
            SizedBox(height: 20), // Add space between "email" and button
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: AuthTextField(
                controller: emailController,
                hintText: 'Enter your email',
              ),
            ),
            SizedBox(height: 16), // Add space between buttons
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: AuthTextField(
                controller: passwordController,
                hintText: 'Enter your password',
              ),
            ),
            const SizedBox(height: 16), // Add space between buttons and text

            const SizedBox(height: 16), // Add space between text and button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage2()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Color(0xFF019254), // Change the color to #019254
                  padding: EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Continue with email',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white, // Change the text color to white
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 25, top: 16, right: 25),
              child: Text(
                'By continuing, you agree to the r.ai Terms & Conditions',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
