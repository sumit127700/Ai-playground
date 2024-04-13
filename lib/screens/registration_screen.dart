import 'package:ai_playground_project/components/header_bungee.dart';
import 'package:ai_playground_project/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ai_playground_project/components/hover_button.dart';
import 'package:ai_playground_project/components/custom_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String email = "";
  String password = "";
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 48.0,
            ),
            HeaderBungee(
              headerText: 'Sign Up!',
            ),
            SizedBox(
              height: 48.0,
            ),
            CustomTextField(
              hintText: 'Enter your Email!',
              onChanged: (value) {
                email = value;
              },
              color:const Color(0xFF6200EE),
              isPassword: false,
            ),
            SizedBox(
              height: 8.0,
            ),
            CustomTextField(
              hintText: 'Enter your Password!',
              onChanged: (value) {
                password = value;
              },
              color:const Color(0xFF6200EE),
              isPassword: true,
            ),
            SizedBox(
              height: 24.0,
            ),
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: HoverButton(
                    onPressed: _isLoading
                        ? () => {}
                        : () async {
                            setState(() {
                              _isLoading = true;
                            });
                            try {
                              final newuser =
                                  await _auth.createUserWithEmailAndPassword(
                                      email: email, password: password);
                              newuser.user?.sendEmailVerification();

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                              );
                            } catch (e) {
                              print(e);
                            }
                            setState(() {
                              _isLoading = false;
                            });
                          },
                    child: const Center(
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    color: const Color(0xFF6200EE),
                  ),
                ),
                if (_isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
