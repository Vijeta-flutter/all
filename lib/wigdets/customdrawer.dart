import 'package:firebaseflutterproject/Screens/loginscreen.dart';
import 'package:firebaseflutterproject/Screens/settingsscreen.dart';
import 'package:flutter/material.dart';

class CustomGameDrawer extends StatelessWidget {
  const CustomGameDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey[900],
            ),
            child: const Text(
              'Game Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.play_arrow),
            title: const Text('Play'),
            onTap: () {
              // Navigate to Play Screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.leaderboard),
            title: const Text('Leaderboard'),
            onTap: () {
              // Navigate to Leaderboard Screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingsScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Exit'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
            },
          ),
        ],
      ),
    );
  }
}
