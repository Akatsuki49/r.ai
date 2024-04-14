import 'package:flutter/material.dart';

class LoginPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 402),
          const Padding(
            padding: EdgeInsets.only(left: 16),
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
            padding: EdgeInsets.only(left: 16),
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () {
                // Add button functionality
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Change the color to white
                padding: EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const SizedBox(
                width: double.infinity,
                child: Text(
                  'Continue with Google',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black, // Change the text color to black
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16), // Add space between buttons
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () {
                // Add button functionality
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Change the color to white
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
                    color: Colors.black, // Change the text color to black
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16), // Add space between buttons and text
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
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
    );
  }
}
