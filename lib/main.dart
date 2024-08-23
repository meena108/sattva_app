import 'package:flutter/material.dart';
import 'package:sattva_app/screens/UserListScreen.dart';
import 'data/local/DatabaseHelper.dart';
import 'registration_screen.dart'; // Import the RegistrationScreen

void main() {
  runApp(SattvaApp());
}

class SattvaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sattva Help App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserListScreen(), // Set RegistrationScreen as the home screen
      debugShowCheckedModeBanner: false,
    );
  }
}
