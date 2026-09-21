
import 'package:flutter/material.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/screens/room_section/Pg/select_building/select_building_screen.dart';
import 'package:vlr/views/screens/room_section/Pg/select_sharing_type/widget/share_type_pg_widget.dart';

class SelectSharingTypeScreen extends StatelessWidget {
  const SelectSharingTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select Sharing Type",
          style: Helper(context).textTheme.titleMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: blackText3,
              ),
        ),
      ),
      body: SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child: Column(
          children: [
            ListView.separated(
              itemCount: pgShareDetailsList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (_, __) => sizedBoxHeight(height: 20),
              itemBuilder: (context, index) {
                return ShareTypeOfPg(
                  pgShareDetailsModel: pgShareDetailsList[index],
                  onTap: () {
                    navigate(context: context, page: SelectBuildingScreen());
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
