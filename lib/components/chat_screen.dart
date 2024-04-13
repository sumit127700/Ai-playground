import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ai_playground_project/util/chatgpt_api_service.dart';
import 'package:ai_playground_project/util/claude_api_service.dart';
import 'package:ai_playground_project/util/gemini_api_service.dart';

class ChatScreen extends StatefulWidget {
  final String model;
  final Color color;

  const ChatScreen({
   super.key,
    required this.model,
    required this.color,
  }) ;

  @override
  _ChatScreen createState() => _ChatScreen();
}

class _ChatScreen extends State<ChatScreen> with SingleTickerProviderStateMixin {
  final _controller = TextEditingController();
  final _messages = <Message>[];
  late final _APIService;
  bool _isLoading = false;
  List<String> previousMessages=[];
  late AnimationController _animationController;
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    switch (widget.model) {
      case "Gpt":
        _APIService = ChatGptApiService();
        break;
      case "Claude":
        _APIService = ClaudeAPIService();
        break;
      case "Gemini":
        _APIService = GeminiAPIService();
        break;
      default:
        _APIService = ChatGptApiService();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _sendMessage() async {
    final message = _controller.text.trim();
    if (message.isNotEmpty) {
      _addMessage(Message(text: message, isUser: true));

      _controller.clear();

      setState(() {
        _isLoading = true;
      });

      try {
        final response = await _APIService.sendMessage(previousMessages,message);
        previousMessages.add(message);
        previousMessages.add(response);
        _addMessage(Message(text: response, isUser: false));

      } catch (e) {
        _addMessage(Message(text: 'Error: $e', isUser: false));

      } finally {

        setState(() {
          _isLoading = false;
        });
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    }
  }

  void _addMessage(Message message) {
    setState(() {
      _messages.add(message);
      _animationController.forward(from: 0.0); // Start the animation
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(widget.model),
        backgroundColor: widget.color.withOpacity(0.4), // Purple color
        foregroundColor: Colors.white, // White text color
        elevation: 4,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _messages.length,
        controller: _scrollController,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isLatestMessage = index == _messages.length - 1;

                return AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return SlideTransition(
                      position: Tween(
                        begin: Offset(isLatestMessage ? (message.isUser ? 1.0 : -1.0) : 0.0, 0.0),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve: Curves.easeInOut,
                        ),
                      ),
                      child: child,
                    );
                  },
                  child: Column(
                    crossAxisAlignment: message.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12.0),
                            topLeft: Radius.circular(12.0),
                            bottomLeft: message.isUser ? Radius.circular(12.0) : Radius.zero,
                            bottomRight: message.isUser ? Radius.zero : Radius.circular(12.0),
                          ),
                          color: message.isUser ? widget.color : Colors.grey[300],
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
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: widget.color,
              ),
              padding: const EdgeInsets.all(12.0),
              child: DefaultTextStyle(
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText(widget.model+' is typing...'),
                  ],
                  isRepeatingAnimation: true,
                ),
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
                  backgroundColor: widget.color,
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
  }}
class Message {
  final String text;
  final bool isUser;

  Message({
    required this.text,
    required this.isUser,
  });
}