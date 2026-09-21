import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/book_appoint_controller.dart';
import 'package:vlr/controllers/common_controller.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/screens/gym/gym_select_plan_screen.dart/widget/gym_select_batch_button_section.dart';
import 'package:vlr/views/screens/room_section/room_book_visit/widget/instructionc_widget.dart';
import 'package:vlr/views/screens/room_section/room_book_visit/widget/room_book_visit_select_share_type_section.dart';
import 'package:vlr/views/screens/room_section/room_book_visit/widget/room_visit_select_date_section.dart';
import 'package:vlr/views/screens/room_section/room_book_visit/widget/room_visit_you_host_widget.dart';
import 'package:vlr/views/screens/room_section/room_book_visit/widget/select_room_profile_widget.dart';
import 'package:vlr/views/screens/room_section/room_book_visit/widget/select_visit_select_time_section.dart';
import 'package:vlr/views/screens/room_section/room_booking_confirmed/room_booking_confirmed_screen.dart';

class RoomBookVisitScreen extends StatefulWidget {
  const RoomBookVisitScreen({super.key});

  @override
  State<RoomBookVisitScreen> createState() => _RoomBookVisitScreenState();
}

class _RoomBookVisitScreenState extends State<RoomBookVisitScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<BookAppointController>().generateTimeSlots();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Schedule a Visit",
          style: Helper(context).textTheme.titleMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: blackText3,
              ),
        ),
      ),
      bottomNavigationBar: GymSelectPackageButtonSection(
        title: "BOOK VISIT",
        onTap: () {
          navigate(context: context, page: const RoomBookingConfirmedScreen());
        },
      ),
      body: SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SelectRoomProfileWidget(),
            sizedBoxHeight(height: 32),
            GetBuilder<CommonController>(builder: (commonController) {
              return commonController.currentSelectService ==
                      SelectTypeService.pg
                  ? Column(
                      children: [
                        const RoomBookVisitSelectShareType(),
                        sizedBoxHeight(height: 32),
                      ],
                    )
                  : const SizedBox();
            }),
            const RoomVisitSelectDateSection(),
            sizedBoxHeight(height: 32),
            const RoomVisitSelectTimeSection(),
            sizedBoxHeight(height: 32),
            const RoomVisitYouHostWidget(),
            sizedBoxHeight(height: 32),
            const InstructionWidget(),
          ],
        ),
      ),
    );
  }
}
