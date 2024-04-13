import 'package:ai_playground_project/components/hover_button.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ai_playground_project/components//chat_screen.dart';

import '../components/header_bungee.dart';
import 'package:ai_playground_project/components/sidebar.dart';
class ModelSelectionScreen extends StatefulWidget {
  const ModelSelectionScreen({super.key});

  @override
  _ModelSelectionScreen createState() => _ModelSelectionScreen();
}

class _ModelSelectionScreen extends State<ModelSelectionScreen> {
  bool _isSidebarOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(_isSidebarOpen ? Icons.close : Icons.menu),
          onPressed: () {
            setState(() {
              _isSidebarOpen = !_isSidebarOpen;
            });
          },
        ),

        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 4,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: _isSidebarOpen
          ? Drawer(
        child: Sidebar(),
      )
          : Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            HeaderBungee(
              headerText: 'Select',
            ),
            HeaderBungee(
              headerText: 'Model',
            ),
            SizedBox(
              height: 48.0,
            ),
            HoverButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      model: 'Gpt',
                      color: Colors.purple,
                    ),
                  ),
                );
              },
              child: const Center(
                child: const Text(
                  'Model: GPT  |  Version: 3.5',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
              color: Colors.purple,
            ),
            SizedBox(
              height: 20.0,
            ),
            HoverButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      model: 'Claude',
                      color: const Color(0xFF6200EE),
                    ),
                  ),
                );
              },
              child: const Center(
                child: const Text(
                  'Model: Claude  |  Version: 3        ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
              color: const Color(0xFF6200EE),
            ),
            SizedBox(
              height: 20.0,
            ),
            HoverButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      model: 'Gemini',
                      color: Colors.teal,
                    ),
                  ),
                );
              },
              child: const Center(
                child: const Text(
                  'Model: Gemini  |  Version: 1.5     ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
              color: Colors.teal,
            ),
          ],
        ),
      ),
    );
  }
}