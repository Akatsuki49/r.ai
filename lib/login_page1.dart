import 'package:flutter/material.dart';
import './login_page2.dart';

class LoginPage1 extends StatelessWidget {
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
              'Welcome',
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
          const SizedBox(height: 50), // Add some space between the texts
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              'to r.ai',
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
          const SizedBox(height: 40), // Add some space between the texts
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              'All your financial needs in one app. Whether',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              'you’re a beginner or a pro.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 20), // Add some space between the texts and buttons
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
          SizedBox(height: 16), // Add some space between the buttons
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
          const SizedBox(
              height: 16), // Add some space between the buttons and the text
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
