import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:vlr/controllers/dashboard_controller.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/screens/dashboard/dashboard_screen.dart';
import 'package:vlr/views/screens/gym/gym_book_visit_success/widget/gym_book_visit_button_section.dart';
import 'package:vlr/views/screens/room_section/room_book_visit/widget/room_visit_you_host_widget.dart';
import 'package:vlr/views/screens/room_section/room_booking_confirmed/widget/room_visit_schedule_widget.dart';
import 'package:vlr/views/screens/room_section/room_booking_confirmed/widget/visit_scheduled_room_profile_section.dart';
import 'package:vlr/views/screens/room_section/room_booking_confirmed/widget/visit_scheduled_room_section.dart';

class RoomBookingConfirmedScreen extends StatelessWidget {
  const RoomBookingConfirmedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Booking Confirmed",
          style: Helper(context).textTheme.titleMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: blackText3,
              ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child: Column(
          children: [
            const VisitScheduledRoomSection(),
            sizedBoxHeight(height: 48),
            const VisitScheduleRoomProfile(),
            sizedBoxHeight(height: 24),
            const RoomVisitDetailsWidget(),
            sizedBoxHeight(height: 24),
            const RoomVisitYouHostWidget(),
            sizedBoxHeight(height: 24),
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
    );
  }
}
