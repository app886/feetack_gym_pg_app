import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:vlr/controllers/kyc_controller.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/base/common_button.dart';
import 'package:vlr/views/custom_dropdown.dart';
import 'package:vlr/views/screens/common_screen/auto_pay_setup_successfully/auto_pay_setup_successfully_screen.dart';
import 'package:vlr/views/widget/text_box/app_text_box.dart';

class GYMFormAutoPayMandateDetailsSection extends StatelessWidget {
  const GYMFormAutoPayMandateDetailsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<KycController>(
      builder: (kycController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Mandate Details",
              style: Helper(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    color: primaryText1,
                  ),
            ),
            sizedBoxHeight(height: 16),
            AppTextFieldWithHeading(
              controller: kycController.upiIdController,
              headingWidget: Text(
                "UPI ID",
                style: Helper(context).textTheme.bodyMedium?.copyWith(
                      color: greyText3,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              hindText: "Enter your upi id",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter upi id";
                }
                return null;
              },
            ),
            sizedBoxHeight(height: 16),
            Row(
              children: [
                Expanded(
                  child: AppTextFieldWithHeading(
                    controller: kycController.mandateAmountController,
                    headingWidget: Text(
                      "Mandate Amount",
                      style: Helper(context).textTheme.bodyMedium?.copyWith(
                            color: greyText3,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    prefixText: "₹ ",
                    prefixStyle: Helper(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: greyText3,
                        ),
                    hindText: "0.00",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter mandate amount";
                      }
                      return null;
                    },
                  ),
                ),
                sizedBoxWidth(width: 16),
                Expanded(
                  child: AppTextFieldWithHeading(
                    controller: kycController.maxAmountController,
                    headingWidget: Text(
                      "Max Amount",
                      style: Helper(context).textTheme.bodyMedium?.copyWith(
                            color: greyText3,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    prefixText: "₹ ",
                    prefixStyle: Helper(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: greyText3,
                        ),
                    hindText: "50,000.00",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter max amount";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            sizedBoxHeight(height: 16),
            CustomDropDownList(
              headingWidget: Text(
                "Frequency",
                style: Helper(context).textTheme.bodyMedium?.copyWith(
                      color: greyText3,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              value: kycController.frequent,
              hintText: "Payment per",
              items: kycController.frequentList,
              onChanged: (value) {
                kycController.frequent = value;
                kycController.update();
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Select a frequency of payment";
                }
                return null;
              },
            ),
            sizedBoxHeight(height: 16),
            Row(
              children: [
                Expanded(
                  child: AppTextFieldWithHeading(
                    controller: kycController.startDateController,
                    headingWidget: Text(
                      "Start Date",
                      style: Helper(context).textTheme.bodyMedium?.copyWith(
                            color: greyText3,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    hindText: "DD/MM/YYYY",
                    suffix: const Icon(Icons.calendar_month_outlined),
                    readOnly: true,
                    onTap: () async {
                      FocusScope.of(context).unfocus(); // Close keyboard

                      final DateTime? picked = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                        initialDate: DateTime.now(),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: primaryColor,
                                onPrimary: Colors.white,
                                onSurface: black,
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );

                      if (picked != null) {
                        final formatted =
                            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";

                        kycController.startDateController.text = formatted;
                        kycController.update();
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter start date";
                      }
                      return null;
                    },
                  ),
                ),
                sizedBoxWidth(width: 16),
                Expanded(
                  child: AppTextFieldWithHeading(
                    controller: kycController.endDateController,
                    headingWidget: Text(
                      "End Date(Optional)",
                      style: Helper(context).textTheme.bodyMedium?.copyWith(
                            color: greyText3,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    hindText: "DD/MM/YYYY",
                    suffix: const Icon(Icons.calendar_month_outlined),
                    readOnly: true,
                    onTap: () async {
                      FocusScope.of(context).unfocus(); // Close keyboard

                      final DateTime? picked = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                        initialDate: DateTime.now(),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: primaryColor,
                                onPrimary: Colors.white,
                                onSurface: black,
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );

                      if (picked != null) {
                        final formatted =
                            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";

                        kycController.endDateController.text = formatted;
                        kycController.update();
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter end date";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            sizedBoxHeight(height: 16),
            CustomDropDownList(
              headingWidget: Text(
                "Purpose",
                style: Helper(context).textTheme.bodyMedium?.copyWith(
                      color: greyText3,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              value: kycController.purpose,
              hintText: "Select purpose",
              items: kycController.purposeList,
              onChanged: (value) {
                kycController.purpose = value;
                kycController.update();
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Select a purpose for payment";
                }
                return null;
              },
            ),
            sizedBoxHeight(height: 32),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: const Color(0xFFE5E2E166).withValues(alpha: 0.40),
                border: Border.all(
                  width: 1,
                  color: greyLight2.withValues(alpha: 0.20),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: primaryText1,
                      ),
                      sizedBoxWidth(width: 4),
                      Text(
                        "Important Information",
                        style: Helper(context).textTheme.bodyMedium?.copyWith(
                              color: greyText2,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                  sizedBoxHeight(height: 12),
                  Text(
                    "By setting up this autopay, you authorize feetrack to debit the specified amount from your UPI account. You can revoke this mandate at any time through your bank's app.",
                    style: Helper(context).textTheme.bodyMedium?.copyWith(
                          color: greyText2,
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
            ),
            sizedBoxHeight(height: 32),
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 6,
                  spreadRadius: -4,
                  color: primaryText1.withValues(alpha: 0.20),
                ),
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 15,
                  spreadRadius: -3,
                  color: primaryText1.withValues(alpha: 0.20),
                )
              ]),
              child: CustomButton(
                onTap: () {
                  navigate(
                      context: context, page: AutoPaySetupSuccessfullyScreen());
                },
                height: 68,
                radius: 999,
                color: primaryText1,
                borderColor: primaryText1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Set Up Auto-Pay",
                      style: Helper(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: white,
                          ),
                    ),
                    sizedBoxWidth(width: 12),
                    Icon(
                      Icons.arrow_forward,
                      color: white,
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
