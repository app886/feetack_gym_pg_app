import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:vlr/controllers/home_controller.dart';
import 'package:vlr/data/models/category_model/staff_model.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/base/shimmer.dart';
import 'package:vlr/views/screens/gym/gym_profile/widget/gym_profile_trainer_section/gym_profile_trainer_profile_widget.dart';

class GYMProfileTrainerSection extends StatelessWidget {
  const GYMProfileTrainerSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        sizedBoxHeight(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "Expert Trainers",
              style: Helper(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: blackText1,
                  ),
            ),
            Text(
              "View All",
              style: Helper(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: primaryText1,
                  ),
            ),
          ],
        ),
        sizedBoxHeight(height: 16),
        GetBuilder<HomeController>(builder: (homeController) {
          if (!homeController.isStaffLoading && homeController.staffList.isEmpty) {
            return SizedBox(
              height: 100,
              child: Center(
                child: Text(
                  "No Expert Trainers Available",
                  style: Helper(context).textTheme.bodySmall,
                ),
              ),
            );
          }
          return SizedBox(
            height: 235,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              // physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final _staffModel = homeController.isStaffLoading
                    ? StaffModel()
                    : homeController.staffList[index];
                return CustomShimmer(
                  isLoading: homeController.isStaffLoading,
                  child: GYmProfileTrainerProfileWidget(
                    staffModel: _staffModel,
                  ),
                );
              },
              separatorBuilder: (_, __) => sizedBoxWidth(width: 16),
              itemCount: homeController.isStaffLoading
                  ? 4
                  : homeController.staffList.length,
            ),
          );
        })
      ],
    );
  }
}
