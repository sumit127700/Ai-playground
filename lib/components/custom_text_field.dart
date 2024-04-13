
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.hintText = 'Search',
    this.onChanged,
    required this.color,
    required this.isPassword,
  }) : super(key: key);
  final Color color;
  final String hintText;
  final bool isPassword;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      onChanged: onChanged,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding:
        EdgeInsets.symmetric(vertical: 17.0, horizontal: 30.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: color, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: color, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
      ),
    );
  }
}