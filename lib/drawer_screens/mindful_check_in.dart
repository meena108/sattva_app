import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class MindfulCheckInPage extends StatefulWidget {
  @override
  _MindfulCheckInPageState createState() => _MindfulCheckInPageState();
}

class _MindfulCheckInPageState extends State<MindfulCheckInPage> {
  final TextEditingController _journalController = TextEditingController();
  String selectedEmotion = 'Neutral';
  final List<String> emotions = ['Happy', 'Sad', 'Anxious', 'Neutral', 'Grateful'];
  List<Map<String, String>> checkInHistory = [];

  @override
  void initState() {
    super.initState();
    _loadCheckInHistory();
  }

  Future<void> _loadCheckInHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? historyData = prefs.getString('checkInHistory');
    if (historyData != null) {
      setState(() {
        checkInHistory = List<Map<String, String>>.from(json.decode(historyData));
      });
    }
  }

  Future<void> _saveCheckIn(String emotion, String journalEntry) async {
    Map<String, String> newCheckIn = {
      'emotion': emotion,
      'journal': journalEntry,
      'date': DateTime.now().toIso8601String(),
    };

    setState(() {
      checkInHistory.add(newCheckIn);
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('checkInHistory', json.encode(checkInHistory));

    _journalController.clear();
  }

  void _submitCheckIn() {
    String journalEntry = _journalController.text;
    String emotion = selectedEmotion;

    _saveCheckIn(emotion, journalEntry);

    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Check-In Saved'),
          content: Text('Emotion: $emotion\nEntry: $journalEntry'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mindful Check-In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'How are you feeling today?',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedEmotion,
              items: emotions.map((String emotion) {
                return DropdownMenuItem<String>(
                  value: emotion,
                  child: Text(emotion),
                );
              }).toList(),
              onChanged: (String? newEmotion) {
                setState(() {
                  selectedEmotion = newEmotion!;
                });
              },
            ),
            SizedBox(height: 20),
            const Text(
              'Journal Entry:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _journalController,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Write your thoughts here...',
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _submitCheckIn,
                child: Text('Submit Check-In'),
              ),
            ),
            SizedBox(height: 20),
            const Text(
              'Previous Check-Ins:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: checkInHistory.length,
                itemBuilder: (context, index) {
                  final checkIn = checkInHistory[index];
                  return ListTile(
                    title: Text(checkIn['emotion']!),
                    subtitle: Text(
                      '${checkIn['journal']}\nDate: ${checkIn['date']}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
