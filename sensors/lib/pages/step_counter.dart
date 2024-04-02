import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pedometer/pedometer.dart';
import 'package:decimal/decimal.dart';
import 'package:permission_handler/permission_handler.dart';

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
    requestPermission();
    setUpPedometer();
  }


  late StreamSubscription<StepCount> _subscription;
   Future<void> requestPermission() async {
    final PermissionStatus status = await Permission.activityRecognition.request();
    if (status.isGranted) {
      // Permission granted, you can now fetch step count data
    } else {
      // Permission denied, handle accordingly
    }
  }

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
            animation: true,
            center: Image.asset(
              'images/footprint.gif', 
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