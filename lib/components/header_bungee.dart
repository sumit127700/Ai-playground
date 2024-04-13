import 'package:ai_playground_project/components/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class HeaderBungee extends StatelessWidget {
  const HeaderBungee({
    Key? key,
    this.headerText = 'Search',

  }) : super(key: key);

  final String headerText;

  @override
  Widget build(BuildContext context) {
    return  Text(
      headerText,
      style: GoogleFonts.bungee(
        textStyle: const TextStyle(
          color: Colors.white,
          letterSpacing: .5,
          fontSize: 45,
        ),
      ),
    );
  }
}