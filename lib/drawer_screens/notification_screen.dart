import 'dart:async';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // List of daily tips
  final List<String> tips = [
    'Start your day with Sun Salutations.',
    'Focus on your breath during practice.',
    'Incorporate meditation into your routine.',
    'Practice gratitude daily.',
    'Stay hydrated throughout the day.',
    'Stretch for 10 minutes before bed.',
    'Try a new yoga pose each week.',
  ];

  late String dailyTip;

  @override
  void initState() {
    super.initState();
    _showDailyTip();
  }

  // Show a random daily tip
  void _showDailyTip() {
    final randomTip = tips[DateTime.now().day % tips.length];
    setState(() {
      dailyTip = randomTip;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Yoga Tip'),
        backgroundColor: Colors.teal[100],
        foregroundColor: Colors.teal[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Your Tip for Today:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.teal[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                dailyTip,
                style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
