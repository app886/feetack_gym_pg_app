import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/home_controller.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/screens/gym/gym_trainer_profile_screen/widget/gym_trainer_profile_mid_section.dart';
import 'package:vlr/views/screens/gym/gym_trainer_profile_screen/widget/gym_trainer_profile_top_section.dart';

class GymTrainerProfileScreen extends StatefulWidget {
  final String? staffId;
  const GymTrainerProfileScreen({super.key, this.staffId});

  @override
  State<GymTrainerProfileScreen> createState() =>
      _GymTrainerProfileScreenState();
}

class _GymTrainerProfileScreenState extends State<GymTrainerProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final homeController = Get.find<HomeController>();
      homeController.fetchStaffProfileById(
        id: homeController.selectListingModel?.id,
        staffId: widget.staffId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: black.withValues(alpha: 0.05),
        title: Text(
          "Trainer Profile",
          style: Helper(context).textTheme.bodyMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: primaryText1,
                letterSpacing: 1.4,
              ),
        ),
      ),
      body: GetBuilder<HomeController>(builder: (homeController) {
        if (homeController.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (homeController.selectedStaffProfile == null) {
          return const Center(child: Text("Trainer details not found"));
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              const GYMTrainerProfileTopSection(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const GYMTrainerProfileMidSection(),
                    sizedBoxHeight(height: 30),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
