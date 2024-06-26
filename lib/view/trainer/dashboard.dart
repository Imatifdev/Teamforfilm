
import 'package:navin_project/View/resource/resource.dart';
import 'package:navin_project/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navin_project/view/user/settings/settings.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class TrainerDashboard extends StatefulWidget {
  static final title = 'salomon_bottom_bar';

  @override
  _TrainerDashboardState createState() => _TrainerDashboardState();
}

class _TrainerDashboardState extends State<TrainerDashboard> {
  var _currentIndex = 0;
  List<Widget> _page = <Widget>[
    HomePage(),
    Resource(),
    Resource(),
    Resource(),
    UserSettings()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
            selectedColor: Colors.purple,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: Icon(Icons.library_books_outlined),
            title: Text("Resource"),
            selectedColor: Colors.pink,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: Icon(CupertinoIcons.calendar),
            title: Text("Booking"),
            selectedColor: Colors.orange,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: Icon(CupertinoIcons.chat_bubble_text),
            title: Text("Messages"),
            selectedColor: Colors.teal,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: Icon(CupertinoIcons.settings_solid),
            title: Text("Profile"),
            selectedColor: Colors.teal,
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
