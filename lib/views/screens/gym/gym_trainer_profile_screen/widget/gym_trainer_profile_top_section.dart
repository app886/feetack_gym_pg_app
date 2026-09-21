import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/home_controller.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/base/custom_image.dart';

class GYMTrainerProfileTopSection extends StatelessWidget {
  const GYMTrainerProfileTopSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (homeController) {
      final staff = homeController.selectedStaffProfile;
      return Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8E8FF),
              Color(0xFFF3F3FF),
            ],
          ),
        ),
        child: Column(
          children: [
            sizedBoxHeight(height: 40),
            // Trainer Image
            SizedBox(
              height: 300,
              child: CustomImage(
                path: staff?.photoUrl ?? "",
                fit: BoxFit.contain,
              ),
            ),
            sizedBoxHeight(height: 10),
            // White Card Section
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: black.withValues(alpha: 0.05),
                    blurRadius: 15,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  children: [
                    Text(
                      staff?.name ?? "",
                      textAlign: TextAlign.center,
                      style: Helper(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w900,
                            fontSize: 26,
                            color: blackText1,
                          ),
                    ),
                    sizedBoxHeight(height: 4),
                    // Text(
                    //   staff?.designation ?? "Fitness Coach",
                    //   textAlign: TextAlign.center,
                    //   style: Helper(context).textTheme.bodyMedium?.copyWith(
                    //         fontWeight: FontWeight.w500,
                    //         fontSize: 16,
                    //         color: greyText3,
                    //       ),
                    // ),
                    sizedBoxHeight(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStatItem(
                          context,
                          "${staff?.experienceYears ?? "0"}",
                          "Work\nExperience",
                        ),
                        _buildStatItem(
                          context,
                          "32", // Hardcoded or from API if available
                          "Completed\nWorkouts",
                        ),
                        _buildStatItem(
                          context,
                          "21", // Hardcoded or from API if available
                          "Active\nClients",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildStatItem(BuildContext context, String value, String label) {
    return Container(
      width: (MediaQuery.of(context).size.width - 80) / 3,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: Helper(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                  color: blackText1,
                ),
          ),
          sizedBoxHeight(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: Helper(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  color: greyText3,
                  height: 1.2,
                ),
          ),
        ],
      ),
    );
  }
}
