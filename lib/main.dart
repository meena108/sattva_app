import 'package:flutter/material.dart';
import 'package:sattva_app/registration_screen.dart';
import 'package:sattva_app/splash_screen.dart';
import 'login.dart';
import 'drawer_screens/main_drawer.dart';
import 'drawer_screens/articles_screen.dart';
import 'drawer_screens/mindful_check_in.dart';
import 'drawer_screens/notification_screen.dart';
import 'drawer_screens/about_screen.dart';
import 'drawer_screens/dashboard_screen.dart';

void main() {
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
      initialRoute: '/',  // Start with splash screen
      routes: {
        '/': (context) => const SplashScreen(),  // Splash screen
        '/login': (context) => const LoginScreen(),  // Login screen
        '/registration': (context) => RegistrationScreen(),  // Registration screen
        '/mainDrawer': (context) => MainDrawerScreen(firstName: ''),  // Main drawer after login/registration
        '/dashboard': (context) => DashboardScreen(firstName: ''),
        '/articles': (context) => ArticlesScreen(),
        '/notification': (context) => NotificationScreen(),
        '/about': (context) => AboutScreen(),
        '/mindfulCheckIn': (context) => const MindfulCheckInPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

// The screen containing the drawer and routes to other pages.
class MainDrawerScreen extends StatelessWidget {
  final String firstName;

  const MainDrawerScreen({required this.firstName, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, $firstName'),
      ),
      drawer: MainDrawer(firstName: firstName),  // Pass firstName to the drawer
      body: Center(
        child: Text('Choose an option from the drawer'),
      ),
    );
  }
}
