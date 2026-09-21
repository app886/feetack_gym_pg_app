import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/common_controller.dart';
import 'package:vlr/generated/assets.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';

class TermAndConditionTopSection extends StatelessWidget {
  const TermAndConditionTopSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              // color: red,
              color: primaryColor.withValues(alpha: 0.10),
            ),
            child: SvgPicture.asset(
              Assets.svgsLaws,
              fit: BoxFit.cover,
              height: 28.5,
              width: 27,
            ),
          ),
          sizedBoxHeight(height: 16),
          Text(
            "Residential Agreements",
            style: Helper(context).textTheme.titleMedium?.copyWith(
                  fontSize: 24,
                  color: blackText3,
                ),
          ),
          sizedBoxHeight(height: 8),
          GetBuilder<CommonController>(builder: (commonController) {
            return Text(
              textAlign: TextAlign.center,
              "Please review the terms and conditions for your stay at Feetrack ${commonController.currentSelectService.name.toUpperCase()}.",
              style: Helper(context).textTheme.bodySmall?.copyWith(
                    fontSize: 14,
                    color: greyDart2,
                  ),
            );
          }),
        ],
      ),
    );
  }
}
