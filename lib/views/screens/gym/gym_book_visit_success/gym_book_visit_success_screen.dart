import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/dashboard_controller.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/screens/dashboard/dashboard_screen.dart';
import 'package:vlr/views/screens/gym/gym_book_visit_success/widget/gym_book_visit_button_section.dart';

import 'package:vlr/views/screens/gym/gym_book_visit_success/widget/gym_booki_visit_success_top_section.dart';

class GymBookVisitSuccessScreen extends StatelessWidget {
  const GymBookVisitSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: black.withValues(alpha: 0.05),
        centerTitle: true,
        title: Text(
          "Visit Booking successful",
          style: Helper(context).textTheme.bodyMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: primaryText1,
              ),
        ),
      ),
      body: SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const VisitBookingSuccessTopSection(),
              // sizedBoxHeight(height: 40),
              // const GymVisitSuccessGymProfile(),
              // sizedBoxHeight(height: 24),
              // const GYMVisitDetailsSection(),
              // sizedBoxHeight(height: 40),
              GetBuilder<DashBoardController>(builder: (dashBoardController) {
                return GymVisitBookSuccessButtonsSection(
                  onTapBackButton: () {
                    dashBoardController.dashPage = 0;
                    navigate(
                        context: context,
                        isRemoveUntil: true,
                        page: const DashboardScreen());
                  },
                  onTapAddToCalendarButton: () {},
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
