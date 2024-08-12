import 'package:flutter/material.dart';

class FeedbackScreen extends StatelessWidget {
  final String firstName;
  final String message;

  const FeedbackScreen({super.key, required this.firstName, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, $firstName!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Your well-being assessment suggests:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              message,
              style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 20),
            const Text(
              'Suggested Actions:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              '- Practice mindfulness and relaxation techniques.',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '- Maintain a balanced diet with plenty of fruits and vegetables.',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '- Ensure you get at least 7-8 hours of sleep each night.',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '- Stay physically active with regular exercise.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
