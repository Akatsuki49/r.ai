import 'dart:async';
import 'package:arithmania_frontend/screens/speech_recognition.dart';
import 'package:flutter/material.dart';
import '/widgets/filled_text_field.dart';
import '/widgets/message_widget.dart';

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

  void _sendMessage() {
    String messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      _addUserMessage(messageText);
      _getBotReply(messageText);
      _messageController.clear();
    }
  }

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
