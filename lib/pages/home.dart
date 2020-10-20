import 'package:boysbrigade/pages/attendance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './half_year.dart';
import './day.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedTab = 0;

  final List<Widget> _tabs = [
    HalfYear(),
    Day(),
  ];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final bool isAuthenticated = user != null;

    return Scaffold(
      body:
          Center(child: isAuthenticated ? _tabs.elementAt(_selectedTab) : null),
      // body: _tabs.elementAt(_selectedTab),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) {
          setState(() {
            _selectedTab = index;
          });
        },
        backgroundColor: Colors.white,
        selectedItemColor: Colors.indigo[900],
        unselectedItemColor: Colors.grey[400],
        iconSize: 45,
        selectedFontSize: 15,
        unselectedFontSize: 12,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.date_range),
            title: new Text('半年'), //half-year
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            title: new Text('當天'), //day-to-day
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 75.0,
        width: 75.0,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Attendance()));
          },
          child: Icon(
            Icons.add,
            size: 35,
          ),
          backgroundColor: Colors.indigo[900],
          elevation: 5,
        ),
      ),
    );
  }
}
