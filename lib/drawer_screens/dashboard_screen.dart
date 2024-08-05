import 'package:flutter/material.dart';
import 'main_drawer.dart'; // Import the main drawer

class DashboardScreen extends StatelessWidget {
  final String firstName;

  DashboardScreen({required this.firstName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      drawer: MainDrawer(firstName: firstName),
      body: Center(
        child: Text('Welcome to your dashboard, $firstName!'),
      ),
    );
  }
}
