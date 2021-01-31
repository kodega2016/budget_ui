import 'package:expense_tracker/src/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff25466F),
        accentColor: Color(0xff030308),
        fontFamily: GoogleFonts.capriola().fontFamily,
      ),
      home: HomeScreen(),
    );
  }
}
