import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> with SingleTickerProviderStateMixin {
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
  final List<String> tipHistory = [];

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _showDailyTip();

    // Initialize animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Show a random daily tip
  void _showDailyTip() {
    final randomTip = tips[DateTime.now().day % tips.length];
    setState(() {
      dailyTip = randomTip;
      tipHistory.add(randomTip);
    });
  }

  // Share the tip using share_plus
  void _shareTip() {
    Share.share(dailyTip, subject: 'Daily Yoga Tip');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Yoga Tip'),
        backgroundColor: Colors.teal[100],
        foregroundColor: Colors.teal[900],
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () => print("Toggle theme"), // Replace with theme toggle logic
          ),
        ],
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
            FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
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
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _shareTip,
              icon: const Icon(Icons.share),
              label: const Text('Share Tip'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: tipHistory.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text(tipHistory[index]),
                      leading: const Icon(Icons.bookmark),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
