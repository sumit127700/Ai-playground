import 'package:flutter/material.dart';
class Sidebar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
       // Purple background
      ),
      child: Column(
        children: [
          SizedBox(height: 24.0),

          SizedBox(height: 24.0),
          ListTile(
            title: const Center(
              child: Text(
                'Select Models',
                style: TextStyle(
                  color: Colors.white, // White text
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onTap: () {
// Navigate to the home screen
            },
          ),
          const Divider(
            color: Colors.white, // White divider
            thickness: 1.0,
          ),
          ListTile(
            title: const Center(
              child: Text(
                'Playground',
                style: TextStyle(
                  color: Colors.white, // White text
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onTap: () {
// Navigate to the playground screen
            },
          ),
          const Divider(
            color: Colors.white, // White divider
            thickness: 1.0,
          ),
          ListTile(
            title: const Center(
              child: Text(
                'Settings',
                style: TextStyle(
                  color: Colors.white, // White text
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onTap: () {
// Navigate to the settings screen
            },
          ),
        ],
      ),
    );
  }
}
