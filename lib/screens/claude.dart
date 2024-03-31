import 'package:flutter/material.dart';

import 'package:ai_playground_project/util/claude_api_service.dart';

class ClaudeScreen extends StatefulWidget {
  @override
  _ClaudeScreenState createState() => _ClaudeScreenState();
}

class _ClaudeScreenState extends State<ClaudeScreen> {
  final _controller = TextEditingController();
  final _messages = <Message>[];
  final _claudeAPIService = ClaudeAPIService();
  bool _isLoading = false;

  void _sendMessage() async {
    final message = _controller.text.trim();
    if (message.isNotEmpty) {
      _addMessage(Message(text: message, isUser: true));
      _controller.clear();

      setState(() {
        _isLoading = true;
      });

      try {
        final response = await _claudeAPIService.sendMessage(message);
        _addMessage(Message(text: response, isUser: false));
      } catch (e) {
        _addMessage(Message(text: 'Error: $e', isUser: false));
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _addMessage(Message message) {
    setState(() {
      _messages.add(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Claude AI Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: _messages.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length && _isLoading) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.grey[300],
                        ),
                        padding: EdgeInsets.all(12.0),
                        child: Text('Claude is typing...'),
                      ),
                      SizedBox(height: 8.0),
                    ],
                  );
                } else {
                  final message = _messages[index];
                  return Column(
                    crossAxisAlignment:
                    message.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:BorderRadius.only(topRight: Radius.circular(12.0),topLeft: Radius.circular(12.0),bottomLeft:  message.isUser ? Radius.circular(12.0):Radius.zero,bottomRight: message.isUser ? Radius.zero:Radius.circular(12.0)),
                          color: message.isUser ? Colors.blue : Colors.grey[300],

                        ),
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          message.text,
                          style: TextStyle(
                            color: message.isUser ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                    ],
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    controller: _controller,
                    decoration: InputDecoration(

                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 14.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String text;
  final bool isUser;

  Message({
    required this.text,
    required this.isUser,
  });
}