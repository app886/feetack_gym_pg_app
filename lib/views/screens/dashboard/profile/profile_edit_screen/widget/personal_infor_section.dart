import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/auth_controller.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/widget/text_box/app_text_box.dart';

class PersonalInforSection extends StatelessWidget {
  const PersonalInforSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sizedBoxHeight(height: 16),
          Center(
            child: Column(
              children: [
                Text(
                  authController.userModel?.name ?? "",
                  style: Helper(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: primaryText1,
                      ),
                ),
                sizedBoxHeight(height: 40),
              ],
            ),
          ),
          Text(
            "PERSONAL INFORMATION",
            style: Helper(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2.4,
                  color: primaryColor.withValues(alpha: 0.60),
                ),
          ),
          sizedBoxHeight(height: 12),
          AppTextFieldWithHeading(
            controller: authController.fullNameController,
            hindText: "Enter your name",
            heading: "Full Name",
            borderRadius: 999,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your full name";
              }
              return null;
            },
          ),
          sizedBoxHeight(height: 12),
          AppTextFieldWithHeading(
            controller: authController.emailController,
            hindText: "Enter your email address",
            heading: "Email Address",
            borderRadius: 999,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your email address";
              }
              return null;
            },
          ),
          sizedBoxHeight(height: 12),
          AppTextFieldWithHeading(
            controller: authController.mobileNoController,
            hindText: "Enter your mobile number",
            heading: "Mobile Number",
            borderRadius: 999,
            keyboardType: TextInputType.phone,
            prefixText: "+91 ",
            prefixStyle: Helper(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: primaryText1,
                ),
            // inputFormatters: [
            //   FilteringTextInputFormatter.digitsOnly,
            //   LengthLimitingTextInputFormatter(10),
            // ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your mobile number";
              }
              if (value.length != 10) {
                return "Please enter a valid 10-digit mobile number";
              }
              return null;
            },
          ),
          sizedBoxHeight(height: 16),
        ],
      );
    });
  }
}
