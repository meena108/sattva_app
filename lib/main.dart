import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz; // Import timezone initialization
import 'drawer_screens/main_drawer.dart';
import 'drawer_screens/articles_screen.dart';
import 'drawer_screens/notification_screen.dart';
import 'drawer_screens/about_screen.dart';
import 'drawer_screens/dashboard_screen.dart';
import 'drawer_screens/mindful_check_in.dart'; // Import the Mindful Check-In screen

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure widgets binding
  tz.initializeTimeZones(); // Initialize timezones
  runApp(SattvaApp());
}

class SattvaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sattva Help App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/dashboard', // Set the initial route to the dashboard
      routes: {
        '/': (context) => MainDrawer(firstName: ''), // This should be a screen, not the drawer itself
        '/dashboard': (context) => const DashboardScreen(firstName: 'User'),
        '/articles': (context) => ArticlesScreen(),
        '/notification': (context) => NotificationScreen(), // Notification screen route
        '/about': (context) => AboutScreen(),
        '/mindfulCheckIn': (context) => MindfulCheckInPage(), // Mindful Check-In route
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
