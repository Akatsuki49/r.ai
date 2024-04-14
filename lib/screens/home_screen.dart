import 'package:arithmania_frontend/auth/login_screen.dart';
import 'package:arithmania_frontend/screens/speech_recognition.dart';
import 'package:arithmania_frontend/screens/spendings_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '/screens/chat_screen.dart';
import '/screens/investment_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () async {
//               // Implement logout functionality here
//               FirebaseAuth.instance.signOut();
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const LoginScreen()),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Container(
//         color: Colors.black,
//         child: Center(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               // Leave space for the Lottie file (animated mascot)
//               Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: Text('Welcome Siddhant!',
//                     style: GoogleFonts.roboto(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 44)),
//               ),
//               SizedBox(height: 70),
//               Center(
//                 child: Container(
//                   height: 200,
//                   width: 200,
//                   child: Image.asset('assets/images/mascot.png'),
//                 ),
//               ),
//               SizedBox(height: 40),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 30),
//                 child: Text(
//                     'I’m r.ai and I’ll be your personal finance mentor. You can choose to chat with me via text or voice!',
//                     style:
//                         GoogleFonts.roboto(color: Colors.white, fontSize: 20)),
//               ),
//               SizedBox(height: 40),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => ChatPage()),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.indigo[800],
//                     ),
//                     child: Text(
//                       'Use r.ai for Text',
//                       style: TextStyle(
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => SpeechRecognitionScreen()),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green[400],
//                       foregroundColor: Colors.green[800],
//                     ),
//                     child: Text(
//                       'Use r.ai for Voice',
//                       style: TextStyle(
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Leave space for the Lottie file (animated mascot)
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text('Welcome Siddhant!',
                        style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 44)),
                  ),
                  SizedBox(height: 70),
                  Center(
                    child: Container(
                      height: 200,
                      width: 200,
                      child: Image.asset('assets/images/mascot.png'),
                    ),
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                        'I’m r.ai and I’ll be your personal finance mentor. You can choose to chat with me via text or voice!',
                        style: GoogleFonts.roboto(
                            color: Colors.white, fontSize: 20)),
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChatPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.indigo[800],
                        ),
                        child: Text(
                          'Use r.ai for Text',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SpeechRecognitionScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[400],
                          foregroundColor: Colors.green[800],
                        ),
                        child: Text(
                          'Use r.ai for Voice',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                top: 38, // Adjust this value as needed to position the button
                right: 30, // Adjust this value as needed to position the button
                child: FloatingActionButton(
                  onPressed: () {
                    // Add functionality for the wallet button here
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SpendingsPage()));
                  },
                  backgroundColor: Colors.brown[400],
                  foregroundColor: Colors.white,
                  child: Text(
                    'Wallet',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
