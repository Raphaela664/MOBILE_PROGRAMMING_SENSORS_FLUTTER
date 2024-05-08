// import 'dart:async';
// import 'package:sensors_plus/sensors_plus.dart';
// import 'package:flutter/material.dart';
// import 'dart:math';

// class CompassApp extends StatefulWidget {
//   const CompassApp({super.key});

//   @override
//   State<CompassApp> createState() => _CompassAppState();
// }

// class _CompassAppState extends State<CompassApp> {
  
//   MagnetometerEvent _magneticEvent = MagnetometerEvent(0, 0, 0);
//   StreamSubscription? subscription;
//   @override
//   void initState() {
//     super.initState();
//     subscription = magnetometerEvents.listen((event) {
//       setState(() {
//         _magneticEvent = event;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     subscription?.cancel();
//     super.dispose();
//   }

//   double calculateDegrees(double x, double y) {
//     double heading = atan2(x, y);
//     // Convert from radians to degrees
//     heading = heading * 180 / pi;
//     // Ensure that the heading is between 0 and 360 degrees

//     if (heading > 0) {
//       heading -= 360;
//     }
//     return heading * -1;
//   }
  

//   @override
//   Widget build(BuildContext context) {
//     final degrees = calculateDegrees(_magneticEvent.x, _magneticEvent.y);
//     final angle = -1 * pi / 180 * degrees;

//     return Scaffold(
//       backgroundColor: Colors.white,

//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               '${degrees.toStringAsFixed(0)} °', 
//                 style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16.0,
//                 color: Colors.purple,
//               )),
//             Expanded(
//               child: Center(
//                 child: Transform.rotate(
//                   angle: angle,
//                   child: Image.asset(
//                     'images/compass.png',
//                     height: MediaQuery.of(context).size.height * 0.2,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'neu_circle.dart';

class CompassPage extends StatefulWidget {
  @override
  _CompassPageState createState() => _CompassPageState();
}

class _CompassPageState extends State<CompassPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[600],
      body: _buildCompass(),
    );
  }

  Widget _buildCompass() {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error reading heading: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        double? direction = snapshot.data!.heading;

        // if direction is null, then device does not support this sensor
        // show error message
        if (direction == null) {
          return const Center(
            child: Text("Device does not have sensors !"),
          );
        }

        return NeuCircle(
          child: Transform.rotate(
            angle: (direction * (math.pi / 180) * -1),
            child: Image.asset(
              'images/compass.png',
              color: Colors.white,
              fit: BoxFit.fill,
            ),
          ),
        );
      },
    );
  }
}
