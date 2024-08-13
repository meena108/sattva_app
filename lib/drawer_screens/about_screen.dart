import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart'; // For loading the PDF file from assets
import 'package:path_provider/path_provider.dart'; // For accessing device storage
import 'dart:io'; // For file handling

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
            const SizedBox(height: 16.0),
            Text(
              'Address:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.teal[900]),
            ),
            Text(
              '38 Bridge Street,\nWest Bromwich,\nUnited Kingdom',
              style: TextStyle(color: Colors.teal[900]),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Phone:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.teal[900]),
            ),
            Text(
              '+44 871 718 8299',
              style: TextStyle(color: Colors.teal[900]),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _downloadNewsletter(context);
              },
              child: Text('Download Newsletter'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.teal[300],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _downloadNewsletter(BuildContext context) async {
    try {
      // Load the PDF file from assets
      final ByteData data = await rootBundle.load('assets/health.pdf');
      final List<int> bytes = data.buffer.asUint8List();

      // Get the directory to save the file
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/health.pdf');

      // Write the PDF data to the file
      await file.writeAsBytes(bytes);

      // Open the PDF file using a PDF viewer
      if (await file.exists()) {
        await launch(file.path);
      } else {
        _showErrorDialog(context, 'File not found.');
      }
    } catch (e) {
      _showErrorDialog(context, 'Error downloading the newsletter.');
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
