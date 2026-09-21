import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:vlr/controllers/common_controller.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';

class TermConditionIAgreeWidget extends StatelessWidget {
  const TermConditionIAgreeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: white,
        border: Border.all(
          width: 1,
          color: greyDart2.withValues(alpha: 0.50),
        ),
      ),
      child: Row(
        children: [
          GetBuilder<CommonController>(builder: (commonController) {
            return Checkbox(
              value: commonController.isTermAndConditions,
              onChanged: (value) {
                commonController.updateIsTermAndCondition();
              },
              splashRadius: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              side: const BorderSide(
                color: Colors.grey,
                width: 1.5,
              ),
            );
          }),
          sizedBoxWidth(width: 16),
          Expanded(
            child: Text(
              "I agree to all the Terms & Conditions and residency rules mentioned above.",
              style: Helper(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: blackText3,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
