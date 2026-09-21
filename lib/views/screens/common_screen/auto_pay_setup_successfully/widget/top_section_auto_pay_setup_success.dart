import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:vlr/controllers/common_controller.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/base/custom_image.dart';

class AutoPaySetupSuccessTopSection extends StatelessWidget {
  const AutoPaySetupSuccessTopSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomImage(
          path: Assets.imagesVisitSuccess,
          width: 144,
          height: 144,
          fit: BoxFit.cover,
        ),
        Text(
          "Auto-pay Activated Successfully",
          textAlign: TextAlign.center,
          style: Helper(context).textTheme.titleMedium?.copyWith(
                fontSize: 36,
                color: primaryText1,
              ),
        ),
        sizedBoxHeight(height: 12),
        GetBuilder<CommonController>(builder: (commonController) {
          String _isPayFor = commonController.currentSelectService ==
                  SelectTypeService.gym
              ? "GYM Fee"
              : commonController.currentSelectService == SelectTypeService.pg
                  ? "Pg rent"
                  : "Room rent";

          return Text(
            "Your autopay for $_isPayFor has been scheduled and verified.",
            textAlign: TextAlign.center,
            style: Helper(context).textTheme.bodySmall?.copyWith(
                  fontSize: 18,
                  color: greyText2,
                ),
          );
        }),
      ],
    );
  }
}
