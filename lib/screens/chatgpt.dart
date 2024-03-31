import 'package:flutter/material.dart';

import 'package:ai_playground_project/util/chatgpt_api_service.dart';

class ChatGpt extends StatefulWidget {
  const ChatGpt({super.key});

  @override
  _ChatGpt createState() => _ChatGpt();
}

class _ChatGpt extends State<ChatGpt> {
  final _controller = TextEditingController();
  final _messages = <Message>[];
  final _ChatGptApiservice = ChatGptApiService();
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
        final response = await _ChatGptApiservice.sendMessage(message);
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
        title: const Text('GPT 3.5'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
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
                        padding: const EdgeInsets.all(12.0),
                        child: const Text('Claude is typing...'),
                      ),
                      const SizedBox(height: 8.0),
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
                          borderRadius: BorderRadius.circular(12.0),
                          color: message.isUser ? Colors.blue : Colors.grey[300],
                        ),
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          message.text,
                          style: TextStyle(
                            color: message.isUser ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
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
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    controller: _controller,
                    decoration: InputDecoration(

                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 14.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
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