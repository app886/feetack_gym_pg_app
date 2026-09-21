import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/base/common_button.dart';
import 'package:vlr/views/base/custom_image.dart';

class SelectShareTypeWidget extends StatelessWidget {
  const SelectShareTypeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: greyLight6),
        color: white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
            color: black.withValues(alpha: 0.05),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: blueLight5,
            ),
            child: SvgPicture.asset(
              Assets.svgsSinglePerson,
              fit: BoxFit.cover,
            ),
          ),
          sizedBoxWidth(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Double Sharing",
                  style: Helper(context).textTheme.titleMedium?.copyWith(
                        fontSize: 16,
                        color: primaryColor,
                      ),
                ),
                Text(
                  "Selected Stay Type",
                  style: Helper(context).textTheme.bodySmall?.copyWith(
                        fontSize: 14,
                        color: greyDart2,
                      ),
                ),
              ],
            ),
          ),
          CustomButton(
            type: ButtonType.tertiary,
            onTap: () {
              pop(context);
            },
            child: Text(
              "Edit",
              style: Helper(context).textTheme.bodySmall?.copyWith(
                    fontSize: 16,
                    color: blueLight3,
                    decoration: TextDecoration.underline,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
