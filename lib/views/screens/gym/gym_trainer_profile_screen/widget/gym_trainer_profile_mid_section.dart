import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/home_controller.dart';
import 'package:vlr/data/models/gym_trainer_core_specialties_model.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/base/custom_image.dart';
import 'package:vlr/views/screens/gym/gym_trainer_profile_screen/widget/core_specialties_widget.dart';
import 'board_certificaton_widget.dart';

class GYMTrainerProfileMidSection extends StatelessWidget {
  const GYMTrainerProfileMidSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (homeController) {
      final staff = homeController.selectedStaffProfile;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // sizedBoxHeight(height: 8),
          // _buildSectionTitle(context, "In-Session Performance"),
          // sizedBoxHeight(height: 16),
          // SizedBox(
          //   height: 240,
          //   child: ListView.separated(
          //     itemBuilder: (context, index) {
          //       final _image = sessionImage[index];
          //       return CustomImage(
          //         path: _image,
          //         fit: BoxFit.cover,
          //         radius: 24,
          //         width: 180,
          //       );
          //     },
          //     separatorBuilder: (_, __) => sizedBoxWidth(width: 16),
          //     itemCount: sessionImage.length,
          //     shrinkWrap: true,
          //     scrollDirection: Axis.horizontal,
          //   ),
          // ),
          sizedBoxHeight(height: 40),
          _buildSectionTitle(context, "Training Philosophy"),
          sizedBoxHeight(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: primaryText1.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: primaryText1.withValues(alpha: 0.05)),
            ),
            child: Text(
              staff?.description ??
                  "I specialize in biomechanical optimization and metabolic conditioning. My approach combines elite-level athletic training with data-driven recovery protocols to ensure sustainable, high-performance results for executives and athletes alike.",
              style: Helper(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: greyText2,
                    height: 1.6,
                  ),
            ),
          ),
          sizedBoxHeight(height: 40),
          _buildSectionTitle(context, "Board Certifications"),
          sizedBoxHeight(height: 16),
          ListView.separated(
            itemBuilder: (context, index) {
              final _boardModel = boardCertificationsList[index];
              return BoardCertificationWidget(
                title: _boardModel,
              );
            },
            separatorBuilder: (_, __) => sizedBoxHeight(height: 12),
            itemCount: boardCertificationsList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ),
          sizedBoxHeight(height: 40),
          _buildSectionTitle(context, "Core Specialties"),
          sizedBoxHeight(height: 16),
          GridView.builder(
              shrinkWrap: true,
              itemCount: gymTrainerCoreSpecialtiesModelList.length,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.35,
              ),
              itemBuilder: (_, index) {
                final _specialty = gymTrainerCoreSpecialtiesModelList[index];
                return CoreSpecialtiesWidget(
                    gymTrainerCoreSpecialtiesModel: _specialty);
              })
        ],
      );
    });
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Helper(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w900,
            fontSize: 20,
            color: blackText1,
            letterSpacing: 0.5,
          ),
    );
  }
}

List<String> sessionImage = [
  Assets.imagesTrainer1,
  Assets.imagesTrainer2,
  Assets.imagesTrainer3,
];

List<String> boardCertificationsList = [
  "NASM Certified Personal Trainer",
  "Precision Nutrition Level 1",
  "CrossFit L2",
];
