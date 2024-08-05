import 'package:flutter/material.dart';
import 'main_drawer.dart'; // Import the main drawer

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: Colors.teal[100],
        foregroundColor: Colors.teal[900],
      ),
      drawer: MainDrawer(firstName: 'User'), // Replace 'User' with dynamic firstName if needed
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'About Sattva Help App',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.teal[900]),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Sattva Help App is designed to provide self-help resources and support to individuals seeking to improve their mental health and well-being. Our app offers guided meditations, articles, and tools to track your progress.',
              style: TextStyle(color: Colors.teal[900]),
            ),
            // Add more about information here
          ],
        ),
      ),
    );
  }
}
