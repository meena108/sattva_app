import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  final String firstName;

  MainDrawer({required this.firstName});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.teal[100], // Calming teal color
            ),
            child: Text(
              'Hello, $firstName',
              style: TextStyle(
                color: Colors.teal[900], // Darker teal for contrast
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.dashboard, color: Colors.teal[900]),
            title: Text('Dashboard', style: TextStyle(color: Colors.teal[900])),
            onTap: () {
              Navigator.pushNamed(context, '/dashboard');
            },
          ),
          ListTile(
            leading: Icon(Icons.library_books, color: Colors.teal[900]),
            title: Text('Blogs and Articles', style: TextStyle(color: Colors.teal[900])),
            onTap: () {
              Navigator.pushNamed(context, '/articles');
            },
          ),
          ListTile(
            leading: Icon(Icons.support, color: Colors.teal[900]),
            title: Text('Notification', style: TextStyle(color: Colors.teal[900])),
            onTap: () {
              Navigator.pushNamed(context, '/notification');
            },
          ),
          ListTile(
            leading: Icon(Icons.info, color: Colors.teal[900]),
            title: Text('About', style: TextStyle(color: Colors.teal[900])),
            onTap: () {
              Navigator.pushNamed(context, '/about');
            },
          ),
        ],
      ),
    );
  }


}
