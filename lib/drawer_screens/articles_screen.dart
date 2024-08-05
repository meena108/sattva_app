import 'package:flutter/material.dart';
import 'main_drawer.dart'; // Import the main drawer

class ArticlesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blogs and Articles'),
        backgroundColor: Colors.teal[100],
        foregroundColor: Colors.teal[900],
      ),
      drawer: MainDrawer(firstName: 'User'), // Replace 'User' with dynamic firstName if needed
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          ListTile(
            title: const Text('Article 1'),
            subtitle: const Text('Description of article 1'),
            onTap: () {
              // Handle article tap
            },
          ),
          ListTile(
            title: const Text('Article 2'),
            subtitle: const Text('Description of article 2'),
            onTap: () {
              // Handle article tap
            },
          ),
          // Add more articles here
        ],
      ),
    );
  }
}
