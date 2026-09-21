import 'package:flutter/material.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/screens/gym/gym_select_plan_screen.dart/widget/gym_select_batch_button_section.dart';
import 'package:vlr/views/screens/room_section/room/room_configure_stay/widget/room_add_on_services_section.dart';
import 'package:vlr/views/screens/room_section/room/room_configure_stay/widget/configure_stay_top_section.dart';
import 'package:vlr/views/screens/room_section/term_and_condition/term_and_condition_screen.dart';

class RoomConfigureStayScreen extends StatelessWidget {
  const RoomConfigureStayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Configure Stay",
          style: Helper(context).textTheme.titleMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: blackText3,
              ),
        ),
      ),
      bottomNavigationBar: GymSelectPackageButtonSection(
        title: "CONTINUE TO TRAINER",
        onTap: () {
          navigate(context: context, page: const TermAndConditionScreen());
        },
      ),
      body: SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child: Column(
          children: [
            const ConfigureStayTopSection(),
            sizedBoxHeight(height: 32),
            const RoomAddServiceSection()
          ],
        ),
      ),
    );
  }
}
