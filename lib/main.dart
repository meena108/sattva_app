import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz; // Import timezone initialization
import 'drawer_screens/main_drawer.dart';
import 'drawer_screens/articles_screen.dart';
import 'drawer_screens/notification_screen.dart';
import 'drawer_screens/about_screen.dart';
import 'drawer_screens/dashboard_screen.dart';

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
      initialRoute: '/',
      routes: {
        '/': (context) => MainDrawer(firstName: ''),
        '/dashboard': (context) => const DashboardScreen(firstName: ''),
        '/articles': (context) => ArticlesScreen(),
        '/notification': (context) => NotificationScreen(), // Notification screen route
        '/about': (context) => AboutScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
