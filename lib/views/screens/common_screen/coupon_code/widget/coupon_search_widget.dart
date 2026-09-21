import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/common_controller.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/base/common_button.dart';
import 'package:vlr/views/widget/text_box/app_text_box.dart';

class CouponSearchWidget extends StatelessWidget {
  const CouponSearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommonController>(builder: (commonController) {
      return AppTextFieldWithHeading(
          controller: commonController.searchCouponsController,
          preFixWidget: Icon(
            Icons.search,
            color: greyDart2,
          ),
          suffix: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 3.5,
              child: CustomButton(
                borderColor: primaryText1,
                color: primaryText1,
                radius: 99,
                onTap: () {},
                child: Text(
                  "Apply",
                  style: Helper(context).textTheme.titleMedium?.copyWith(
                        fontSize: 16,
                        color: white,
                      ),
                ),
              ),
            ),
          ),
          borderColor: greyLight6,
          hintStyle: Helper(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: greyDart2, fontSize: 16),
          bgColor: white,
          hindText: "Enter coupon code");
    });
  }
}
