import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  bool isWaterReminderOn = false;

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    _requestNotificationPermission();
    _configureLocalTimeZone();
  }

  // Initialize the notifications plugin
  void _initializeNotifications() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const androidSettings = AndroidInitializationSettings('app_icon');
    final iosSettings = DarwinInitializationSettings(); // Updated for iOS

    final initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    flutterLocalNotificationsPlugin.initialize(initSettings);

    // Show a test notification to confirm setup
    _showTestNotification();
  }

  // Request notification permission on Android 13+ (API 33+)
  Future<void> _requestNotificationPermission() async {
    if (await Permission.notification.isGranted) {
      print("Notification permission already granted.");
    } else {
      final status = await Permission.notification.request();

      if (status.isGranted) {
        print("Notification permission granted.");
      } else {
        print("Notification permission denied.");
      }
    }
  }

  // Configure the local timezone for scheduling notifications
  Future<void> _configureLocalTimeZone() async {
    tz_data.initializeTimeZones();
    final String? timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
  }

  // Show a test notification immediately
  Future<void> _showTestNotification() async {
    print("Showing test notification...");  // Log for debugging

    const androidDetails = AndroidNotificationDetails(
      'test_channel',
      'Test Notification',
      importance: Importance.high,
    );
    const iosDetails = DarwinNotificationDetails(); // Updated for iOS

    const generalNotificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Test Notification',
      'This is a test notification content',
      generalNotificationDetails,
    );

    print("Test notification shown.");  // Log to confirm execution
  }

  // Toggle Water Reminder
  Future<void> toggleWaterReminder() async {
    if (isWaterReminderOn) {
      // Cancel the existing water reminder notification
      await flutterLocalNotificationsPlugin.cancel(0);
      print("Water reminder canceled.");
    } else {
      const androidDetails = AndroidNotificationDetails(
        'water_channel',
        'Water Reminder',
        importance: Importance.high,
      );
      const iosDetails = DarwinNotificationDetails(); // Updated for iOS

      const generalNotificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      // Schedule for 10-second intervals
      _schedulePeriodicNotification(0, generalNotificationDetails, 10);
      print("Water reminder scheduled.");
    }

    setState(() {
      isWaterReminderOn = !isWaterReminderOn;
    });

    // Show confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(isWaterReminderOn ? 'Water Reminder is ON' : 'Water Reminder is OFF')),
    );
  }

  // Schedule notification every specified seconds
  void _schedulePeriodicNotification(int id, NotificationDetails details, int seconds) {
    tz.TZDateTime nextInstance = tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds));
    flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      'Water Reminder',
      'Time to drink water!',
      nextInstance,
      details,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.wallClockTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: '',
    );

    // Reschedule the notification periodically
    if (isWaterReminderOn) {
      Future.delayed(Duration(seconds: seconds), () {
        _schedulePeriodicNotification(id, details, seconds);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
        backgroundColor: Colors.teal[100],
        foregroundColor: Colors.teal[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Choose your reminder:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: toggleWaterReminder, // Correctly references the toggle method
              style: ElevatedButton.styleFrom(
                backgroundColor: isWaterReminderOn ? Colors.blue[200] : Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                isWaterReminderOn ? 'Water Reminder On' : 'Set Water Reminder',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
