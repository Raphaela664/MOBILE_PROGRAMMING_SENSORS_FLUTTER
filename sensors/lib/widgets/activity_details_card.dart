import 'package:light_sensor/light_sensor.dart';
import 'package:sensors/data/health_details.dart';
import 'package:sensors/motion_detector.dart';
import 'package:sensors/pages/step_counter.dart';
import 'package:sensors/util/responsive.dart';
import 'package:sensors/widgets/custom_card_widget.dart';
import 'package:flutter/material.dart';

// class ActivityDetailsCard extends StatelessWidget {
//   const ActivityDetailsCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final healthDetails = HealthDetails();
//     final MotionDetails= MotionDetector();
//     final StepsDetails= StepsCounterPage();
//     final lightDetails= LightSensor();
//     final MotionDetector motionDetector = MotionDetector();

//     return GridView.builder(
//       itemCount: 2,
//       shrinkWrap: true,
//       physics: const ScrollPhysics(),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: Responsive.isMobile(context) ? 2 : 4,
//         crossAxisSpacing: Responsive.isMobile(context) ? 12 : 15,
//         mainAxisSpacing: 12.0,
//       ),
//       itemBuilder: (context, index) => CustomCard(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // Image.asset(
//             //   healthDetails.healthData[index].icon,
//             //   width: 30,
//             //   height: 30,
//             // ),
//             Icon(
//               Icons.directions_run,
//               size: 30,
//               color: Colors.white,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 15, bottom: 4),
//               child: Text(
//                 'Magnitude: ${motionDetector.lastMagnitude ?? 0}',
//                 style: const TextStyle(
//                   fontSize: 18,
//                   color: Colors.white,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//             Text(
//               'Motion Detector',
//               style: const TextStyle(
//                 fontSize: 13,
//                 color: Colors.grey,
//                 fontWeight: FontWeight.normal,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class ActivityDetailsCard extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    final healthDetails = HealthDetails();
    final MotionDetails = MotionDetector();
    final lightDetails = LightSensor();
    final MotionDetector motionDetector = MotionDetector();

    return GridView.builder(
      itemCount: 1,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: Responsive.isMobile(context) ? 2 : 4,
        crossAxisSpacing: Responsive.isMobile(context) ? 12 : 15,
        mainAxisSpacing: 12.0,
      ),
      itemBuilder: (context, index) {
        if (index == 0) {
          return CustomCard(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.directions_run,
                  size: 30,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 4),
                  child: Text(
                    'Magnitude: ${motionDetector.lastMagnitude ?? 0}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  'Motion Detector',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
 
        }
        return Container(); // Return an empty container for other indices
      },
    );
  }
}
