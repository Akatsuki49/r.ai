import 'dart:async';
import 'dart:convert';
import 'package:arithmania_frontend/screens/speech_recognition.dart';
import 'package:arithmania_frontend/widgets/filled_text_field.dart';
import 'package:arithmania_frontend/widgets/message_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Message {
  final String text;
  final bool isUser;

  Message({
    required this.text,
    required this.isUser,
  });
}

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Message> messages = [
    Message(text: 'Hello!', isUser: false),
    Message(text: 'Hi there!', isUser: true),
  ];
  final TextEditingController _messageController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 0,
                child: Container(color: Colors.black),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF1E1E1E),
                        Color(0xFF2D2D2D),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 40, 10, 0),
                                    child: GestureDetector(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SpeechRecognitionScreen())),
                                      child: Image.asset(
                                        'assets/images/mascot.png',
                                        height: 50,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: messages.length,
                                itemBuilder: (context, index) {
                                  return MessageBubble(
                                    text: messages[index].text,
                                    isUser: messages[index].isUser,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      _buildMessageInput(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Row(
        children: [
          Expanded(
            child: FilledTextField(
              controller: _messageController,
              maxLines: 2,
              hintText: 'Type your message...',
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.send, color: Colors.grey[400]),
                onPressed: _isLoading ? null : _sendMessage,
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SpeechRecognitionScreen(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.mic_external_on_outlined,
                  color: Colors.white,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  // void _sendMessage() async {
  //   // Ensure the message text is not empty
  //   String messageText = _messageController.text.trim();
  //   if (messageText.isNotEmpty) {
  //     setState(() {
  //       _isLoading = true;
  //     });

  //     // Get the current user's ID
  //     String userId = FirebaseAuth.instance.currentUser!.uid;

  //     try {
  //       // Make the HTTP POST request
  //       print({'question': messageText, 'user_id': userId});
  //       var response = await http.post(
  //         Uri.parse('https://b825-104-28-252-172.ngrok-free.app/query'),
  //         body: json.encode({'question': messageText, 'user_id': userId}),
  //         // headers: {'Content-Type': 'application/json'},
  //       );
  //       // Check if the request was successful (status code 200)
  //       if (response.statusCode == 200) {
  //         // Parse the response if necessary
  //         var responseData = json.decode(response.body);

  //         // Add the user message to the chat
  //         _addUserMessage(messageText);

  //         // Add the bot reply to the chat
  //         _addBotReply(responseData['response']);
  //       } else {
  //         // Handle the error if the request was not successful
  //         print('Request failed with status: ${response.statusCode}');
  //       }
  //     } catch (error) {
  //       // Handle any errors that occur during the HTTP request
  //       print('Error sending message: $error');
  //     } finally {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     }

  //     // Clear the message input field
  //     _messageController.clear();
  //   }
  // }
  void _sendMessage() {
    // Ensure the message text is not empty
    String messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      // Prepare the request data
      Map<String, dynamic> requestData = {
        "question": messageText,
        "user_id": FirebaseAuth.instance.currentUser!.uid,
      };

      // Send POST request to the backend endpoint
      http
          .post(
        Uri.parse('https://b825-104-28-252-172.ngrok-free.app/query'),
        body: requestData,
      )
          .then((response) {
        if (response.statusCode == 200) {
          // Parse the response if necessary
          var responseData = json.decode(response.body);

          // Add the user message to the chat
          _addUserMessage(messageText);

          // Add the bot reply to the chat
          _addBotReply(responseData['response']);
        } else {
          print(
              'Failed to send message to the backend. Status code: ${response.statusCode}');
        }
      }).catchError((error) {
        print('Error sending message to the backend: $error');
      }).whenComplete(() {
        setState(() {
          _isLoading = false;
        });
      });

      // Clear the message input field
      _messageController.clear();
    }
  }

  // void _sendMessage() {
  //   // print("UserID");
  //   // print(FirebaseAuth.instance.currentUser!.uid);
  //   String messageText = _messageController.text.trim();
  //   if (messageText.isNotEmpty) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     _addUserMessage(messageText);
  //     _getBotReply(messageText);
  //     _messageController.clear();
  //   }
  // }

  void _addUserMessage(String messageText) {
    Message userMessage = Message(text: messageText, isUser: true);
    setState(() {
      messages.add(userMessage);
    });
  }

  void _getBotReply(String messageText) {
    // Simulate a delay to mimic a backend request
    Timer(Duration(seconds: 2), () {
      String botReply = _generateBotReply(messageText);
      _addBotReply(botReply);
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _addBotReply(String botReply) {
    Message botMessage = Message(text: botReply, isUser: false);
    setState(() {
      messages.add(botMessage);
    });
  }

  String _generateBotReply(String message) {
    // This is a dummy function to generate a bot reply based on the user's message
    return 'This is a dummy bot reply to "$message".';
  }
}
