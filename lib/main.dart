import 'package:flutter/material.dart';
import 'drawer_screens/main_drawer.dart';
import 'login.dart';
import 'drawer_screens/articles_screen.dart';
import 'drawer_screens/support_screen.dart';
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
      initialRoute: '/',
      routes: {
        '/': (context) => MainDrawer(firstName: '',),
        '/dashboard': (context) => DashboardScreen(firstName: ''),
        '/articles': (context) => ArticlesScreen(),
        '/support': (context) =>   SupportScreen(),
        '/about': (context) => AboutScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
