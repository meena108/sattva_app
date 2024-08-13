import 'package:flutter/material.dart';
import 'feedback_screen.dart';
import 'main_drawer.dart';

class DashboardScreen extends StatefulWidget {
  final String firstName;

  const DashboardScreen({super.key, required this.firstName});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Wake-Up Time:',
      'type': 'radio',
      'options': ['4:00 AM - 6:00 AM', '6:00 AM - 8:00 AM', 'After 8:00 AM'],
      'answer': '',
    },
    {
      'question': 'Sleep Time:',
      'type': 'radio',
      'options': ['8:00 PM - 10:00 PM', '10:00 PM - 12:00 AM', 'After 12:00 AM'],
      'answer': '',
    },
    {
      'question': 'Meditation/Mantra Meditation Duration:',
      'type': 'radio',
      'options': ['Less than 30 minutes', 'More than 30 minutes'],
      'answer': '',
    },
    {
      'question': 'Yoga Practice:',
      'type': 'radio',
      'options': ['Yes', 'No'],
      'answer': '',
    },
    {
      'question': 'Meal Timings:',
      'type': 'checkbox',
      'options': [
        'Breakfast (7:00 AM - 9:00 AM)',
        'Lunch (12:00 PM - 2:00 PM)',
        'Dinner (6:00 PM - 8:00 PM)',
      ],
      'answer': [],
    },
    {
      'question': 'Water Intake:',
      'type': 'checkbox',
      'options': [
        'Did you drink water immediately after waking up?',
        'Did you drink at least 8 glasses of water today?',
      ],
      'answer': [],
    },
    {
      'question': 'Daily Reading:',
      'type': 'radio',
      'options': ['Yes', 'No'],
      'answer': '',
    },
    {
      'question': 'Journaling:',
      'type': 'radio',
      'options': ['Yes', 'No'],
      'answer': '',
    },
    {
      'question': 'Screen Time:',
      'type': 'radio',
      'options': ['Yes', 'No'],
      'answer': '',
    },
    {
      'question': 'Social Connection:',
      'type': 'radio',
      'options': ['Yes', 'No'],
      'answer': '',
    },
  ];

  AnimationController? _animationController;
  Animation<double>? _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeIn,
    );

    _animationController?.forward();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  // Method to reset the answers in the form
  void _resetData() {
    setState(() {
      for (var question in _questions) {
        if (question['type'] == 'checkbox') {
          question['answer'] = [];
        } else {
          question['answer'] = '';
        }
      }
    });
  }

  void _submitAnswers() {
    List<String> feedbackMessages = [];

    for (var question in _questions) {
      if (question['question'] == 'Wake-Up Time:') {
        switch (question['answer']) {
          case '4:00 AM - 6:00 AM':
            feedbackMessages.add('Great job! Waking up early helps set a positive tone for the day and aligns with natural circadian rhythms.');
            break;
          case '6:00 AM - 8:00 AM':
            feedbackMessages.add('Good start to the day! If possible, try waking up a bit earlier to maximize morning productivity.');
            break;
          case 'After 8:00 AM':
            feedbackMessages.add('Consider adjusting your wake-up time to earlier in the morning to gain more time for your daily activities and start the day with energy.');
            break;
        }
      } else if (question['question'] == 'Sleep Time:') {
        switch (question['answer']) {
          case '8:00 PM - 10:00 PM':
            feedbackMessages.add('Excellent! Early bedtime ensures adequate rest and better health.');
            break;
          case '10:00 PM - 12:00 AM':
            feedbackMessages.add('You\'re on the right track, but consider going to bed earlier to improve your sleep quality.');
            break;
          case 'After 12:00 AM':
            feedbackMessages.add('Late sleep times can affect your health negatively. Try to wind down earlier for better rest and recovery.');
            break;
        }
      } else if (question['question'] == 'Meditation/Mantra Meditation Duration:') {
        if (question['answer'] == 'More than 30 minutes') {
          feedbackMessages.add('Fantastic! You’re dedicating significant time to mindfulness and spiritual practices, which can greatly enhance your well-being.');
        } else if (question['answer'] == 'Less than 30 minutes') {
          feedbackMessages.add('A good start! Gradually try to increase your meditation time to deepen its benefits.');
        }
      } else if (question['question'] == 'Yoga Practice:') {
        if (question['answer'] == 'Yes') {
          feedbackMessages.add('Great work! Regular yoga practice contributes to both physical and mental well-being.');
        } else if (question['answer'] == 'No') {
          feedbackMessages.add('Consider incorporating yoga into your routine. Even a short daily session can make a big difference in your overall health.');
        }
      } else if (question['question'] == 'Meal Timings:') {
        if (question['answer'].contains('Breakfast (7:00 AM - 9:00 AM)')) {
          feedbackMessages.add('Well done! Eating breakfast at this time helps kickstart your metabolism and energy levels for the day.');
        } else {
          feedbackMessages.add('Skipping breakfast can lead to energy slumps later in the day. Try to include a nutritious breakfast to start your day right.');
        }
        if (question['answer'].contains('Lunch (12:00 PM - 2:00 PM)')) {
          feedbackMessages.add('Good job! A balanced lunch within this window supports sustained energy throughout the day.');
        } else {
          feedbackMessages.add('Skipping or delaying lunch can disrupt your energy and focus. Aim to have lunch within this timeframe to maintain balance.');
        }
        if (question['answer'].contains('Dinner (6:00 PM - 8:00 PM)')) {
          feedbackMessages.add('Excellent! Eating dinner early allows for better digestion and sleep quality.');
        } else {
          feedbackMessages.add('Consider having dinner earlier to aid digestion and improve your sleep patterns.');
        }
      } else if (question['question'] == 'Water Intake:') {
        if (question['answer'].contains('Did you drink water immediately after waking up?')) {
          feedbackMessages.add('Great habit! Drinking water first thing in the morning helps rehydrate your body and kickstart your metabolism.');
        } else {
          feedbackMessages.add('Try starting your day with a glass of water to boost hydration and wakefulness.');
        }
        if (question['answer'].contains('Did you drink at least 8 glasses of water today?')) {
          feedbackMessages.add('Excellent! Staying well-hydrated is crucial for overall health.');
        } else {
          feedbackMessages.add('Aim to drink more water throughout the day. Hydration is key to maintaining energy levels and bodily functions.');
        }
      } else if (question['question'] == 'Daily Reading:') {
        if (question['answer'] == 'Yes') {
          feedbackMessages.add('Fantastic! Reading daily expands your knowledge and stimulates mental growth.');
        } else if (question['answer'] == 'No') {
          feedbackMessages.add('Consider incorporating some reading into your daily routine. It’s a great way to relax and learn something new.');
        }
      } else if (question['question'] == 'Journaling:') {
        if (question['answer'] == 'Yes') {
          feedbackMessages.add('Great work! Journaling helps process emotions, set goals, and reflect on your day.');
        } else if (question['answer'] == 'No') {
          feedbackMessages.add('Try starting a journaling habit. It can be a powerful tool for self-reflection and personal growth.');
        }
      } else if (question['question'] == 'Screen Time:') {
        if (question['answer'] == 'Yes') {
          feedbackMessages.add('Excellent! Limiting screen time helps reduce eye strain and allows more time for other enriching activities.');
        } else if (question['answer'] == 'No') {
          feedbackMessages.add('Try to be mindful of your screen time. Reducing it can improve your focus and overall well-being.');
        }
      } else if (question['question'] == 'Social Connection:') {
        if (question['answer'] == 'Yes') {
          feedbackMessages.add('Great! Spending quality time with loved ones strengthens relationships and boosts emotional health.');
        } else if (question['answer'] == 'No') {
          feedbackMessages.add('Consider reaching out to friends or family. Social connections are vital for emotional support and happiness.');
        }
      }
    }

    // Navigate to FeedbackScreen with the generated feedback
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FeedbackScreen(
          firstName: widget.firstName,
          feedbackMessages: feedbackMessages,
        ),
      ),
    );

    // Reset the data after navigating
    _resetData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daily Well-Being Assessment',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      drawer: MainDrawer(firstName: widget.firstName),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[50]!, Colors.teal[100]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnimation!,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Text(
                    'Welcome, ${widget.firstName}!',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                ..._questions.map((question) {
                  if (question['type'] == 'radio') {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 8.0),
                          child: Text(
                            question['question'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                        ),
                        ...question['options'].map<Widget>((option) {
                          return RadioListTile(
                            title: Text(
                              option,
                              style: const TextStyle(color: Colors.black87),
                            ),
                            value: option,
                            groupValue: question['answer'],
                            onChanged: (value) {
                              setState(() {
                                question['answer'] = value;
                              });
                            },
                            activeColor: Colors.teal,
                          );
                        }).toList(),
                        const SizedBox(height: 10),
                      ],
                    );
                  } else if (question['type'] == 'checkbox') {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 8.0),
                          child: Text(
                            question['question'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                        ),
                        ...question['options'].map<Widget>((option) {
                          return CheckboxListTile(
                            title: Text(
                              option,
                              style: const TextStyle(color: Colors.black87),
                            ),
                            value: question['answer'].contains(option),
                            onChanged: (value) {
                              setState(() {
                                if (value == true) {
                                  question['answer'].add(option);
                                } else {
                                  question['answer'].remove(option);
                                }
                              });
                            },
                            activeColor: Colors.teal,
                            checkColor: Colors.white,
                          );
                        }).toList(),
                        const SizedBox(height: 10),
                      ],
                    );
                  }
                  return Container();
                }).toList(),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitAnswers,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
