import 'package:flutter/material.dart';
import '/screens/chat_screen.dart';
import '/screens/investment_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Finance App'),
        backgroundColor: Colors.blue[800],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue[200]!,
              Colors.blue[400]!,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Leave space for the Lottie file (animated mascot)
              Container(
                height: 200,
                width: 200,
                color: Colors.grey[300],
                child: Image.asset('assets/images/mascot.png'),
              ),
              SizedBox(height: 20),
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
                      'Chat',
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
                            builder: (context) => InvestmentScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.green[800],
                    ),
                    child: Text(
                      'Investments',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
