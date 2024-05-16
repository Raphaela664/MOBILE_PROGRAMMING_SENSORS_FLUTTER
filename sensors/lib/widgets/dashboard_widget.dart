import 'package:sensors/pages/step_counter.dart';
import 'package:sensors/util/responsive.dart';
import 'package:sensors/widgets/activity_details_card.dart';
import 'package:sensors/widgets/line_chart_card.dart';
import 'package:sensors/widgets/summary_widget.dart';
import 'package:flutter/material.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
          
            const SizedBox(height: 18),
            ActivityDetailsCard(),
            const SizedBox(height: 18),
             LineChartCard(),
            const SizedBox(height: 18),
            if (Responsive.isTablet(context)) const SummaryWidget(),
          ],
        ),
      ),
    );
  }
}
