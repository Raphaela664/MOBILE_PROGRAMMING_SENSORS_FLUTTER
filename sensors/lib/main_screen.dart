
import 'package:flutter/material.dart';
import 'package:sensors/util/responsive.dart';
import 'package:sensors/widgets/dashboard_widget.dart';
import 'package:sensors/widgets/summary_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      
      endDrawer: Responsive.isMobile(context)
          ? SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: const SummaryWidget(),
            )
          : null,
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: DashboardWidget(),
            ),
            if (isDesktop)
              Expanded(
                flex: 3,
                child: SummaryWidget(),
              ),
          ],
        ),
      ),
    );
  }
}
