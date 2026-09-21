import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:vlr/controllers/subscription_controller.dart';
import 'package:vlr/data/models/category_model/batch_model.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/base/shimmer.dart';
import 'package:vlr/views/screens/gym/gym_select_plan_screen.dart/widget/gym_select_batch_section/gym_batch_widget.dart';



class SelectBatchTimingSelection extends StatelessWidget {
  const SelectBatchTimingSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubscriptionController>(
      builder: (subscriptionController) {
        if (subscriptionController.hasRooms || !subscriptionController.hasShifts) {
          return const SizedBox();
        }
        if (!subscriptionController.isLoading && subscriptionController.batchModelList.isEmpty) {
          return const SizedBox();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sizedBoxHeight(height: 20),
            Text(
              "BATCH TIMING",
              style: Helper(context).textTheme.titleSmall?.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: greyText3,
                letterSpacing: 1.2,
              ),
            ),
            sizedBoxHeight(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: subscriptionController.isLoading
                  ? 4
                  : subscriptionController.batchModelList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.15,
              ),
              itemBuilder: (context, index) {
                final batchModel = subscriptionController.isLoading
                    ? BatchModel()
                    : subscriptionController.batchModelList[index];

                return CustomShimmer(
                  isLoading: subscriptionController.isLoading,
                  child: GYMBatchWidget(
                    batchModel: batchModel,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

