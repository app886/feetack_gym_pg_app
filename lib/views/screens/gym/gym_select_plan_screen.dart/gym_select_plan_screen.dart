import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/subscription_controller.dart';
import 'package:vlr/controllers/home_controller.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/base/common_button.dart';
import 'package:vlr/views/screens/gym/gym_billing_screen/gym_billing_screen.dart';
import 'package:vlr/views/screens/gym/gym_select_trainer_screen/gym_select_trainer_screen.dart';
import 'package:vlr/views/screens/gym/gym_select_plan_screen.dart/widget/select_duration_section.dart';
import 'package:vlr/views/screens/gym/gym_select_plan_screen.dart/widget/select_membership_section.dart';
import 'package:vlr/views/screens/gym/gym_select_plan_screen.dart/widget/gym_select_batch_section/gym_select_batch_section.dart';
import 'package:vlr/views/screens/gym/gym_select_plan_screen.dart/widget/select_room_section.dart';
import '../../../../controllers/room_controller.dart';

class GymSelectPlanScreen extends StatefulWidget {
  const GymSelectPlanScreen({super.key});

  @override
  State<GymSelectPlanScreen> createState() => _GymSelectPlanScreenState();
}

class _GymSelectPlanScreenState extends State<GymSelectPlanScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final homeController = Get.find<HomeController>();
      final subscriptionController = Get.find<SubscriptionController>();
      final roomController = Get.find<RoomController>();

      final listingId = homeController.selectListingModel?.id ?? "";
      final roomId = roomController.selectedRoomDetails?.id;
      final floorId = roomController.selectedRoomDetails?.floorId;
      
      print('GymSelectPlanScreen: listingId=$listingId, roomId=$roomId, floorId=$floorId');

      await subscriptionController.fetchDuringListingById(id: listingId);
      subscriptionController.fetchPlanListingById(
        id: listingId,
        roomId: roomId,
        floorId: floorId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: black.withValues(alpha: 0.05),
        title: Text(
          "Choose your plan",
          style: Helper(context).textTheme.bodyMedium?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: primaryText1,
          ),
        ),
      ),
      body: GetBuilder<SubscriptionController>(builder: (subscriptionController) {
        return SingleChildScrollView(
          padding: AppConstants.screenPadding,
          child: Column(
            children: [
              const SelectDurationSection(),
              const SelectMemberShipSection(),
              // const SelectRoomSection(),
              const SelectBatchTimingSelection(),
              sizedBoxHeight(height: 30),
              CustomButton(
                height: 54,
                radius: 100,
                color: const Color(0xFF002060),
                borderColor: const Color(0xFF002060),
                isLoading: subscriptionController.isLoading,
                onTap: () {
                  if (subscriptionController.selectedPlan == null) {
                    showToast(message: "Please select a membership plan");
                    return;
                  }

                  if (subscriptionController.hasShifts &&
                      subscriptionController.selectedBatch == null) {
                    showToast(message: "Please select a batch timing");
                    return;
                  }

                  if (subscriptionController.hasRooms) {
                    final roomId = Get.find<RoomController>().selectedRoomDetails?.id;
                    navigate(
                      context: context,
                      page: GymBillingScreen(roomId: roomId),
                    );
                  } else {
                    final homeController = Get.find<HomeController>();
                    final hasTrainers = homeController
                            .selectListingModel?.category?.hasTrainers ??
                        false;

                    if (hasTrainers) {
                      navigate(
                          context: context,
                          page: const GymSelectTrainerScreen());
                    } else {
                      navigate(
                          context: context, page: const GymBillingScreen());
                    }
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "CONTINUE",
                      style: Helper(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: white,
                          ),
                    ),
                    sizedBoxWidth(width: 8),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: white,
                      size: 16,
                    ),
                  ],
                ),
              ),
              sizedBoxHeight(height: 20),
            ],
          ),
        );
      }),
    );
  }
}
