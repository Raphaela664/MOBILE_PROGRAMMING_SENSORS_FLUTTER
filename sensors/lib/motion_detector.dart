import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sensors/main.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:math';

class MotionDetector extends StatefulWidget {
  final double motionThreshold;
  final Function? onMotionDetected;

  const MotionDetector({
    Key? key,
    this.motionThreshold = 2.0,
    this.onMotionDetected,
  }) : super(key: key);

  @override
  _MotionDetectorState createState() => _MotionDetectorState();
}

class _MotionDetectorState extends State<MotionDetector> {
  double? lastMagnitude;

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      double magnitude = _calculateMagnitude(event.x, event.y, event.z);
      if (magnitude > widget.motionThreshold) {  // Assuming you want to detect when it's greater
        setState(() {
          lastMagnitude = magnitude;
          if (magnitude > 13){
            _triggerNotification();
          }
        });

        if (widget.onMotionDetected != null) {
          widget.onMotionDetected!();
        } else {
          _defaultMotionDetected();
        }
      }
    });
  }

  double _calculateMagnitude(double x, double y, double z) {
    return sqrt(x * x + y * y + z * z);
  }
  void _triggerNotification() async {
    
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'MotionDetection_channel',
        'Motion Detection Notifications',
        importance: Importance.max,
        priority: Priority.high,
      );
      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(
        0,
        'Motion Detected',
        'Phone motion',
        platformChannelSpecifics,
      );
      print('Motion detected! Alerting user...');
  }
  void _defaultMotionDetected() {
   // debugPrint('Default Motion Detected! Magnitude: $lastMagnitude');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(lastMagnitude != null ? 'Last Magnitude: $lastMagnitude' : 'Listening for motion...'),
    );
  }
}
