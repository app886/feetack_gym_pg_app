import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vlr/generated/assets.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';

class CouponValidateMaxWidget extends StatelessWidget {
  const CouponValidateMaxWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: white,
          border: Border.all(width: 1, color: greyLight6)),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: blueLight4,
                child: const Icon(
                  Icons.calendar_month_outlined,
                  color: greenDark,
                ),
              ),
              sizedBoxWidth(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Validity",
                    style: Helper(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: greyDart2,
                        ),
                  ),
                  Text(
                    "30 June 2024",
                    style: Helper(context).textTheme.titleMedium?.copyWith(
                          fontSize: 18,
                          color: blackText3,
                        ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: Divider(
              color: greyLight1,
            ),
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: purple,
                child: SvgPicture.asset(
                  Assets.svgsCash,
                  width: 22,
                  height: 16,
                  colorFilter: ColorFilter.mode(
                    greyLight6,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              sizedBoxWidth(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Maximum Benefit",
                    style: Helper(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: greyDart2,
                        ),
                  ),
                  Text(
                    "Up to ₹2,000",
                    style: Helper(context).textTheme.titleMedium?.copyWith(
                          fontSize: 18,
                          color: blackText3,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
