import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pedometer/pedometer.dart';
import 'package:decimal/decimal.dart';

class StepsCounter extends StatefulWidget {
  @override
  _StepsCounterState createState() => _StepsCounterState();
}

class _StepsCounterState extends State<StepsCounter> {
  String stepsDisplayed = "";
  String distanceInKm = "0";
  String caloriesBurned = "0";

  String _stepCountValue = '0';
  // late StreamSubscription<int> _subscription;

  late double _steps; //step count
  late double _convert;
  late double _distanceInKm=0.0;
  late double _burnedCalories;
  late double _percentage;

  @override
  void initState() {
    super.initState();
    setUpPedometer();
  }

  late StreamSubscription<StepCount> _subscription;

void setUpPedometer() {
  _subscription = Pedometer.stepCountStream.listen(_onStepCountData,
      onError: _onError, onDone: _onDone, cancelOnError: true);
}


void _onStepCountData(StepCount event) {
  int stepCountValue = event.steps;
  _onData(stepCountValue);
}

void _onData(int stepCountValue) async {
  setState(() {
    _stepCountValue = "$stepCountValue";
  });

  var dist = stepCountValue;
  double y = (dist + .0);

  setState(() {
    _steps = y;
  });

  var long3 = (_steps);
  long3 = double.parse(y.toStringAsFixed(2));
  var long4 = (long3 / 10000);

  int decimals = 1;
  int fac = pow(10, decimals) as int;
  double d = long4;
  d = (d * fac).round() / fac;

  getDistanceRun(_steps);

  setState(() {
    _convert = d;
  });
}


  void reset() {
    setState(() {
      int stepCountValue = 0;
      stepCountValue = 0;
      _stepCountValue = "$stepCountValue";
    });
  }

  void _onDone() {}

  void _onError(error) {
    print("Flutter Pedometer Error: $error");
  }

  void getDistanceRun(double _steps) {
    var distance = ((_steps * 78) / 100000);
    distance = double.parse(distance.toStringAsFixed(2));
    var distanceInKmx = distance * 34;
    distanceInKmx = double.parse(distanceInKmx.toStringAsFixed(2));
    setState(() {
      distanceInKm = "$distance";
    });
    setState(() {
      _distanceInKm = double.parse(distanceInKmx.toStringAsFixed(2));
    });
  }

  void getBurnedRun() {
    setState(() {
      var calories = _distanceInKm;
      caloriesBurned = "$calories";
    });
  }

  @override
  Widget build(BuildContext context) {
  getBurnedRun();
  return Scaffold(
    body: Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularPercentIndicator(
            radius: 100.0,
            lineWidth: 13.0,
            // animation: true,
            // center: Icon(
            //   FontAwesomeIcons.personWalking,
            //   size: 50.0,
            //   color: Colors.black,
            // ),
            animation: true,
  center: Image.asset(
    'images/footprint.gif', // Replace this URL with the URL of your GIF
    width: 90.0,
    height: 90.0,
  ),
            percent: 0.217,
            footer: Text(
              "Steps: $_stepCountValue",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.purple,
              ),
            ),
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: Colors.purpleAccent,
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildCard("Distance", "$distanceInKm Km", Colors.purple),
              _buildCard("Calories", "$caloriesBurned kCal", Colors.red),
              _buildCard("Steps", "$_stepCountValue Steps", Colors.black),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildCard(String title, String value, Color color) {
  return Card(
    elevation: 5.0,
    child: Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              color: color,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black,
            ),
          ),
        ],
      ),
    ),
  );
}
}
//   Widget build(BuildContext context) {
//     getBurnedRun();
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Step Counter app'),
//         backgroundColor: Colors.black54,
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(5.0),
//         children: <Widget>[
//           Container(
//             padding: EdgeInsets.only(top: 10.0),
//             width: 250,
//             height: 250,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.bottomCenter,
//                 end: Alignment.topCenter,
//                 colors: [Color(0xFFA9F5F2), Color(0xFF01DFD7)],
//               ),
//               borderRadius: BorderRadius.circular(27.0),
//             ),
//             child: CircularPercentIndicator(
//               radius: 200.0,
//               lineWidth: 13.0,
//               animation: true,
//               center: Container(
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     Container(
//                       height: 50,
//                       width: 50,
//                       padding: EdgeInsets.only(left: 20.0),
//                       child: Icon(
//                         FontAwesomeIcons.walking,
//                         size: 30.0,
//                         color: Colors.white,
//                       ),
//                     ),
//                     Container(
//                       child: Text(
//                         '$_stepCountValue',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20.0,
//                             color: Colors.purpleAccent),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               percent: 0.217,
//               footer: Text(
//                 "Steps:  $_stepCountValue",
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 12.0,
//                     color: Colors.purple),
//               ),
//               circularStrokeCap: CircularStrokeCap.round,
//               progressColor: Colors.purpleAccent,
//             ),
//           ),
//           Divider(
//             height: 5.0,
//           ),
//           Container(
//             width: 80,
//             height: 100,
//             padding: EdgeInsets.only(left: 25.0, top: 10.0, bottom: 10.0),
//             color: Colors.transparent,
//             child: Row(
//               children: <Widget>[
//                 Container(
//                   child: Card(
//                     child: Container(
//                       height: 80.0,
//                       width: 80.0,
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                           image: AssetImage("assets/images/distance.png"),
//                           fit: BoxFit.fitWidth,
//                           alignment: Alignment.topCenter,
//                         ),
//                       ),
//                       child: Text(
//                         "$distanceInKm Km",
//                         textAlign: TextAlign.right,
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 14.0),
//                       ),
//                     ),
//                     color: Colors.white54,
//                   ),
//                 ),
//                 VerticalDivider(
//                   width: 20.0,
//                 ),
//                 Container(
//                   child: Card(
//                     child: Container(
//                       height: 80.0,
//                       width: 80.0,
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                           image: AssetImage("assets/images/burned.png"),
//                           fit: BoxFit.fitWidth,
//                           alignment: Alignment.topCenter,
//                         ),
//                       ),
//                     ),
//                     color: Colors.transparent,
//                   ),
//                 ),
//                 VerticalDivider(
//                   width: 20.0,
//                 ),
//                 Container(
//                   child: Card(
//                     child: Container(
//                       height: 80.0,
//                       width: 80.0,
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                           image: AssetImage("assets/images/step.png"),
//                           fit: BoxFit.fitWidth,
//                           alignment: Alignment.topCenter,
//                         ),
//                       ),
//                     ),
//                     color: Colors.transparent,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Divider(
//             height: 2,
//           ),
//           Container(
//             padding: EdgeInsets.only(top: 2.0),
//             width: 150,
//             height: 30,
//             color: Colors.transparent,
//             child: Row(
//               children: <Widget>[
//                 Container(
//                   padding: EdgeInsets.only(left: 40.0),
//                   child: Card(
//                     child: Container(
//                       child: Text(
//                         "$distanceInKm Km",
//                         textAlign: TextAlign.right,
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 14.0,
//                             color: Colors.white),
//                       ),
//                     ),
//                     color: Colors.purple,
//                   ),
//                 ),
//                 VerticalDivider(
//                   width: 20.0,
//                 ),
//                 Container(
//                   padding: EdgeInsets.only(left: 10.0),
//                   child: Card(
//                     child: Container(
//                       child: Text(
//                         "$caloriesBurned kCal",
//                         textAlign: TextAlign.right,
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 14.0,
//                             color: Colors.white),
//                       ),
//                     ),
//                     color: Colors.red,
//                   ),
//                 ),
//                 VerticalDivider(
//                   width: 5.0,
//                 ),
//                 Container(
//                   padding: EdgeInsets.only(left: 10.0),
//                   child: Card(
//                     child: Container(
//                       child: Text(
//                         "$_stepCountValue Steps",
//                         textAlign: TextAlign.right,
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 14.0,
//                             color: Colors.white),
//                       ),
//                     ),
//                     color: Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
