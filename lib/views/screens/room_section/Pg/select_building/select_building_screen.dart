import 'package:flutter/material.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/screens/gym/gym_select_plan_screen.dart/widget/gym_select_batch_button_section.dart';
import 'package:vlr/views/screens/room_section/Pg/select_building/widget/select_build_pg_widget.dart';
import 'package:vlr/views/screens/room_section/Pg/select_building/widget/select_share_type_widge.dart';
import 'package:vlr/views/screens/room_section/Pg/select_room_bed/select_room_bed_screen.dart';

class SelectBuildingScreen extends StatelessWidget {
  const SelectBuildingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select Building",
          style: Helper(context).textTheme.titleMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: blackText3,
              ),
        ),
      ),
      bottomNavigationBar: GymSelectPackageButtonSection(
        title: "Continue to Room Selection",
        onTap: () {
          navigate(context: context, page: const SelectRoomAndBedScreen());
        },
      ),
      body: SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child: Column(
          children: [
            SelectShareTypeWidget(),
            sizedBoxHeight(height: 32),
            SelectBuildPgWidget(),
          ],
        ),
      ),
    );
  }
}
