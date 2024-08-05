import 'package:flutter/material.dart';
import 'main_drawer.dart'; // Import the main drawer

class SupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Support'),
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
              'Support',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.teal[900]),
            ),
            SizedBox(height: 16.0),
            Text('If you have any issues, please contact us at:', style: TextStyle(color: Colors.teal[900])),
            SizedBox(height: 8.0),
            Text('Email: support@example.com', style: TextStyle(color: Colors.teal[900])),
            SizedBox(height: 8.0),
            Text('Phone: +1 234 567 890', style: TextStyle(color: Colors.teal[900])),
            // Add more support information here
          ],
        ),
      ),
    );
  }
}
