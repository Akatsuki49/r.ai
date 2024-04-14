import 'package:flutter/material.dart';
import 'package:arithmania_frontend/login_page1.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  // double secondImageHeight =
  //     20.0; // Initial height of the second image // Initial bottom padding of the second image

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/1st.png',
            width: 700, // Adjust the width as needed
            height: 700, // Adjust the height as needed
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage1()),
              );
            },
            child: Image.asset(
              'assets/images/1stbutton.png',
              // width: 1200, // Adjust the width as needed
              // height: secondImageHeight, // Use the variable for height
            ),
          ),
        ],
      ),
    );
  }
}
