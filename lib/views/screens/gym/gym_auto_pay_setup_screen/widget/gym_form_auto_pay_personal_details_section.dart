import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:vlr/controllers/kyc_controller.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/widget/text_box/app_text_box.dart';

class GYMFormAutoPayPersonalDetailsSection extends StatelessWidget {
  const GYMFormAutoPayPersonalDetailsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<KycController>(builder: (kycController) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Personal Details",
            style: Helper(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                  color: primaryText1,
                ),
          ),
          sizedBoxHeight(height: 16),
          AppTextFieldWithHeading(
            controller: kycController.customerNameController,
            headingWidget: Text(
              "Customer Name",
              style: Helper(context).textTheme.bodyMedium?.copyWith(
                    color: greyText3,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            hindText: "Customer Name",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter  customer name";
              }
              return null;
            },
          ),
          sizedBoxHeight(height: 16),
          AppTextFieldWithHeading(
            controller: kycController.mobileNumberController,
            headingWidget: Text(
              "Mobile Number",
              style: Helper(context).textTheme.bodyMedium?.copyWith(
                    color: greyText3,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            prefixText: "+91 ",
            prefixStyle: Helper(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: greyText3,
                ),
            hindText: "9191XXXXXX",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter your mobile number";
              }
              if (value.length != 10) {
                return "Enter a valid mobile number";
              }
              return null;
            },
          ),
          sizedBoxHeight(height: 16),
          AppTextFieldWithHeading(
            controller: kycController.customerNameController,
            headingWidget: Text(
              "Email (Optional)",
              style: Helper(context).textTheme.bodyMedium?.copyWith(
                    color: greyText3,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            hindText: "adb@gmail.com",
          ),
          sizedBoxHeight(height: 32),
        ],
      );
    });
  }
}
