// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:navin_project/View/auth/login.dart';
import 'package:navin_project/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class DetailSettings extends StatefulWidget {
  final bool? isUser;

  const DetailSettings({Key? key, this.isUser}) : super(key: key);

  @override
  State<DetailSettings> createState() => _DetailSettingsState();
}

class _DetailSettingsState extends State<DetailSettings> {
  bool _isDarkMode = false;

  void _toggleTheme(bool isDarkMode) {
    setState(() {
      _isDarkMode = isDarkMode;
    });
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  Future logout() async {
    await _auth.signOut().then((value) => Navigator.of(context)
        .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Login()),
            (route) => false));
  }

  @override
  Widget build(BuildContext context) {
    print(widget.isUser);
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text('Settings'),
          backgroundColor: theme.appBarTheme.backgroundColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Theme",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                title: Text('Dark Mode'),
                trailing: AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return ScaleTransition(
                      scale: animation,
                      child: child,
                    );
                  },
                  child: themeProvider.themeMode == ThemeMode.dark
                      ? Icon(Icons.nightlight_round,
                          color: Colors.white, key: UniqueKey())
                      : Icon(Icons.wb_sunny,
                          color: Colors.yellow, key: UniqueKey()),
                ),
                onTap: () {
                  themeProvider
                      .toggleTheme(themeProvider.themeMode != ThemeMode.dark);
                },
              ),
              Divider(),
              MyTile(
                subtitle: "Edit your personal Information",
                onTap: () {
                  logout();
                },
                title: "Logout",
                icon: Icons.logout,
              ),
            ],
          ),
        ));
  }
}

class MyTile extends StatelessWidget {
  const MyTile({
    super.key,
    required this.title,
    this.onTap,
    this.subtitle,
    required this.icon,
  });

  final String title;
  final VoidCallback? onTap;

  final String? subtitle;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(title),
      leading: Icon(icon),
    );
  }
}
