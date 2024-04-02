import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class CompassApp extends StatefulWidget {
  const CompassApp({super.key});

  @override
  State<CompassApp> createState() => _CompassAppState();
}

class _CompassAppState extends State<CompassApp> {
  
  MagnetometerEvent _magneticEvent = MagnetometerEvent(0, 0, 0);
  StreamSubscription? subscription;
  @override
  void initState() {
    super.initState();
    subscription = magnetometerEvents.listen((event) {
      setState(() {
        _magneticEvent = event;
      });
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  double calculateDegrees(double x, double y) {
    double heading = atan2(x, y);
    // Convert from radians to degrees
    heading = heading * 180 / pi;
    // Ensure that the heading is between 0 and 360 degrees

    if (heading > 0) {
      heading -= 360;
    }
    return heading * -1;
  }
  

  @override
  Widget build(BuildContext context) {
    final degrees = calculateDegrees(_magneticEvent.x, _magneticEvent.y);
    final angle = -1 * pi / 180 * degrees;

    return Scaffold(
      backgroundColor: Colors.white,

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${degrees.toStringAsFixed(0)} °', 
                style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.purple,
              )),
            Expanded(
              child: Center(
                child: Transform.rotate(
                  angle: angle,
                  child: Image.asset(
                    'images/compass.png',
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}