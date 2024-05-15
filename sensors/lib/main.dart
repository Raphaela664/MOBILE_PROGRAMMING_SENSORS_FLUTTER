import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sensors/Homepage.dart';

void main() {
  runApp(MyApp());
  // checkPermissions();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sensors',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Homepage(),  // Your primary widget after permissions are granted
    );
  }
}

// Future<void> checkPermissions() async {
//   var status = await Permission.locationWhenInUse.status;
//   if (!status.isGranted) {
//     await Permission.locationWhenInUse.request();
//   }
// }
