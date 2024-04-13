import 'package:ai_playground_project/components/custom_text_field.dart';
import 'package:ai_playground_project/components/header_bungee.dart';
import 'package:ai_playground_project/screens/model_selection_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ai_playground_project/components/hover_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";
  String password = "";
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 48.0,
            ),
            HeaderBungee(
              headerText: 'Login!',
            ),
            const SizedBox(
              height: 48.0,
            ),
            CustomTextField(
              onChanged: (value){
                email=value;
              },
              hintText: 'Enter your Email!',
              color:Colors.purple,
              isPassword: false,
            ),
            const SizedBox(
              height: 8.0,
            ),
            CustomTextField(
              onChanged: (value){
                password=value;
              },
              hintText: 'Enter your Password!',
              color:Colors.purple,
              isPassword: true,
            ),
            const SizedBox(
              height: 24.0,
            ),
            Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: HoverButton(
                      onPressed: _isLoading
                          ? ()=>{}
                          : () async {
                              setState(() {
                                _isLoading = true;
                              });
                              try {
                                final newuser =
                                    await _auth.signInWithEmailAndPassword(
                                  email: email,
                                  password: password,
                                );
                                newuser.user?.sendEmailVerification();
                                if (newuser.user!.emailVerified) {
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ModelSelectionScreen()),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Something is not right. Try again.')));
                                }
                              } catch (e) {
                                print(e);
                              }
                              setState(() {
                                _isLoading = false;
                              });
                            },
                      child: const Center(
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      color: Colors.purple,
                    ),
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
