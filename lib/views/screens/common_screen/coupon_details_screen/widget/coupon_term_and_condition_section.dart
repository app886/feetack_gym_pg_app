import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/base/custom_image.dart';
import 'package:vlr/views/screens/common_screen/coupon_details_screen/widget/coupon_term_condition_row.dart';

class CouponTermAndConditionSection extends StatelessWidget {
  const CouponTermAndConditionSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: white,
        border: Border.all(
          width: 1,
          color: greyLight6,
        ),
      ),
      child: Column(
        children: [
          sizedBoxHeight(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                SvgPicture.asset(
                  Assets.svgsLaws,
                  height: 19,
                  width: 18,
                ),
                sizedBoxWidth(width: 6),
                Text(
                  "Terms & Conditions",
                  style: Helper(context).textTheme.titleLarge?.copyWith(
                        fontSize: 20,
                        color: blackText3,
                      ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 24),
            child: Divider(
              color: greyLight6,
            ),
          ),
          ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemBuilder: (context, index) {
              return const CouponTermConditionRow(
                title:
                    "Discount is applicable only on residential maintenance service categories.",
              );
            },
            separatorBuilder: (_, __) => sizedBoxHeight(height: 16),
            itemCount: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ),
          sizedBoxHeight(height: 24),
        ],
      ),
    );
  }
}
