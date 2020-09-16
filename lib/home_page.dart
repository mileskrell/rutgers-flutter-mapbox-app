import 'package:flutter/material.dart';
import 'package:location/location.dart';

import 'my_dashboard/my_dashboard.dart';
import 'my_day/my_day.dart';
import 'my_map/my_map.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  static final String title = 'Rutgers';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    MyDay(),
    MyDashboard(),
    MyMap(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(HomePage.title),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) async {
          final location = Location();
          final hasPermissions = await location.hasPermission();
          final result = hasPermissions == PermissionStatus.granted
              ? hasPermissions
              : await location.requestPermission();
          if (result == PermissionStatus.granted) {
            setState(() => _currentIndex = index);
          }
        },
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text('myDay'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('myDashboard'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text('myMap'),
          ),
        ],
      ),
    );
  }
}
