import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:http/http.dart' as http;

class SpeechRecognitionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpeechScreen();
  }
}

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  final Map<String, HighlightedWord> _highlights = {
    'flutter': HighlightedWord(
      onTap: () => print('flutter'),
      textStyle: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ),
    ),
    'voice': HighlightedWord(
      onTap: () => print('voice'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
    'subscribe': HighlightedWord(
      onTap: () => print('subscribe'),
      textStyle: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ),
    'like': HighlightedWord(
      onTap: () => print('like'),
      textStyle: const TextStyle(
        color: Colors.blueAccent,
        fontWeight: FontWeight.bold,
      ),
    ),
    'comment': HighlightedWord(
      onTap: () => print('comment'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
  };

  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;
  double _buttonPosition = 0.6;
  String _backendResponse = '';
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> sendTextToBackend(String text) async {
    try {
      var url = Uri.parse('https://b825-104-28-252-172.ngrok-free.app/query');
      var response = await http.post(
        url,
        body: {'text': text, 'user_id': _auth.currentUser!.uid},
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        print(
            'Failed to send text to backend. Status code: ${response.statusCode}');
        return 'Failed to send text to backend. Status code: ${response.statusCode}';
      }
    } catch (e) {
      print('Error sending text to backend: $e');
      return 'Error sending text to backend: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111111),
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height * 0.20,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: TextHighlight(
                  text: _text,
                  words: _highlights,
                  textStyle: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 32.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 40.0,
            left: 20.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Confidence: ${(_confidence * 100.0).toStringAsFixed(1)}%',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Listening: ${_isListening ? 'Yes' : 'No'}',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 20.0,
            right: 20.0,
            child: Row(
              children: [
                FloatingActionButton(
                  onPressed: _listen,
                  backgroundColor: Color.fromARGB(0, 47, 47, 47),
                  child: Icon(
                    _isListening ? Icons.mic : Icons.mic_none,
                    size: 36.0,
                  ),
                ),
                SizedBox(width: 10.0),
                FloatingActionButton(
                  onPressed: () {
                    // Trigger response here
                  },
                  backgroundColor: Color.fromARGB(255, 0, 0, 0),
                  child: Icon(Icons.navigate_next),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20.0,
            left: 20.0,
            right: 20.0,
            child: Container(
              padding: EdgeInsets.all(10.0),
              color: Colors.black.withOpacity(0.5),
              child: Text(
                _backendResponse,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) {
          print('onStatus: $val');
          if (val == 'listening') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Listening...'),
                duration: Duration(seconds: 3),
              ),
            );
          }
        },
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();

      String response = await sendTextToBackend(_text);
      setState(() {
        _backendResponse = response;
      });
    }
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Voice',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SpeechRecognitionScreen(),
    );
  }
}
