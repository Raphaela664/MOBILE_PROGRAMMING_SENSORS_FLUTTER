import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sensors/pages/compass.dart';
import 'package:sensors/pages/gps_tracker.dart';
import 'package:sensors/pages/light_sensor.dart';
import 'package:sensors/pages/step_counter.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;
  Uint8List? _image;
  File? selectedImage;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final List<Widget> _pages = [
    StepsCounter(),
    CompassApp(),
    GPStracker(),
    LightSensor(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Sensors',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          color: Colors.white,
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            gap: 8,
            padding: EdgeInsets.all(16),
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Steps Counter',
              ),
              GButton(
                icon: Icons.calculate,
                text: 'Compass App',
              ),
              GButton(
                icon: Icons.inbox,
                text: 'Gps tracker',
              ),
              GButton(
                icon: Icons.notifications,
                text: 'Light Sensor',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.of(context).pop();
  }

  
}

