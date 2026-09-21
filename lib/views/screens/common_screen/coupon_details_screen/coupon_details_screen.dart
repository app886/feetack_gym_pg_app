import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/base/common_button.dart';
import 'package:vlr/views/base/custom_image.dart';
import 'package:vlr/views/screens/common_screen/coupon_details_screen/widget/coupon_detail_top_widget.dart';
import 'package:vlr/views/screens/common_screen/coupon_details_screen/widget/coupon_term_and_condition_section.dart';
import 'package:vlr/views/screens/common_screen/coupon_details_screen/widget/coupon_validate_max_widget.dart';
import 'package:vlr/views/screens/gym/gym_billing_screen/gym_billing_screen.dart';

class CouponDetailsScreen extends StatelessWidget {
  const CouponDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(
          "Coupon Details",
          style: Helper(context).textTheme.titleMedium?.copyWith(
                fontSize: 16,
                color: blackText3,
              ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: white.withValues(alpha: 0.95),
          border: Border.all(width: 1, color: greyLight),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: AppConstants.screenPadding,
              child: CustomButton(
                height: 56,
                radius: 999,
                color: primaryText1,
                borderColor: primaryText1,
                onTap: () {
                  navigate(
                      context: context,
                      isReplace: true,
                      page: const GymBillingScreen());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Apply Coupon",
                      style: Helper(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: white,
                            letterSpacing: 1.4,
                          ),
                    ),
                    sizedBoxWidth(width: 6),
                    SvgPicture.asset(
                      Assets.svgsMagic,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CouponDetailTapWidget(),
            sizedBoxHeight(height: 32),
            const CouponValidateMaxWidget(),
            sizedBoxHeight(height: 32),
            const CouponTermAndConditionSection()
          ],
        ),
      ),
    );
  }
}
