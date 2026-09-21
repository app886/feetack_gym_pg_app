import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:vlr/controllers/auth_controller.dart';
import 'package:vlr/controllers/basic_controller.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/custom_dropdown.dart';
import 'package:vlr/views/widget/text_box/app_text_box.dart';

class ProfileBillingAddressSection extends StatelessWidget {
  const ProfileBillingAddressSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sizedBoxHeight(height: 20),
          Text(
            "BILLING ADDRESS",
            style: Helper(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2.4,
                  color: primaryColor.withValues(alpha: 0.60),
                ),
          ),
          sizedBoxHeight(height: 16),
          AppTextFieldWithHeading(
            controller: authController.address1Controller,
            borderRadius: 999,
            heading: "ADDRESS LINE 1",
            maxLines: 2,
            hindText: "House No, Building, Area",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your address";
              }
              return null;
            },
          ),
          sizedBoxHeight(height: 24),
          AppTextFieldWithHeading(
            controller: authController.address2Controller,
            borderRadius: 999,
            heading: "ADDRESS LINE 2",
            maxLines: 2,
            hindText: "Landmark, Locality",
          ),
          sizedBoxHeight(height: 16),
          GetBuilder<BasicController>(builder: (basicController) {
            return Row(
              children: [
                Expanded(
                  child: CustomDropDownList(
                    heading: "STATE",
                    hintText: "State",
                    borderRadius: 999,
                    items: basicController.stateList
                        .map((e) => e.toString())
                        .toList(),
                    value: authController.state,
                    onChanged: (value) {
                      value = authController.state;
                      authController.update();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Select a State";
                      }
                      return null;
                    },
                  ),
                ),
                sizedBoxWidth(width: 16),
                Expanded(
                  child: CustomDropDownList(
                    heading: "CITY",
                    hintText: "City",
                    borderRadius: 999,
                    items: basicController.cityList
                        .map((e) => e.toString())
                        .toList(),
                    value: authController.city,
                    onChanged: (value) {
                      value = authController.city;
                      authController.update();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Select a city";
                      }
                      return null;
                    },
                  ),
                )
              ],
            );
          }),
          sizedBoxHeight(height: 24),
          AppTextFieldWithHeading(
            controller: authController.pinCodeController,
            borderRadius: 999,
            heading: "PIN CODE",
            hindText: "111 111",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter a pin code";
              }
              if (value.length != 6) {
                return "Enter a valid pin code";
              }
              return null;
            },
          ),
        ],
      );
    });
  }
}
