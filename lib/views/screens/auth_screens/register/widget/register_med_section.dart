import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/auth_controller.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/base/common_button.dart';
import 'package:vlr/views/base/custom_image.dart';
import 'package:vlr/views/screens/auth_screens/login/login_screen.dart';
import 'package:vlr/views/screens/auth_screens/opt_verification_screen.dart';

class RegisterMedSection extends StatefulWidget {
  final String? referralCode;
  const RegisterMedSection({
    super.key,
    this.referralCode,
  });

  @override
  State<RegisterMedSection> createState() => _RegisterMedSectionState();
}

class _RegisterMedSectionState extends State<RegisterMedSection> {
  final _formKey = GlobalKey<FormState>();

  String generateReferralCode() {
    final random = Random();
    final digits = List.generate(9, (_) => random.nextInt(10)).join();
    return 'Feetrack$digits';
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final auth = Get.find<AuthController>();
      // Use passed referral code if available, otherwise generate a random one
      auth.referralCodeController.text =
          (widget.referralCode != null && widget.referralCode!.isNotEmpty)
              ? widget.referralCode!
              : generateReferralCode();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.r),
        color: white,
        // color: white.withValues(alpha: 0.85),
        border: Border.all(width: 1, color: white.withValues(alpha: 0.60)),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 32),
            color: primaryColor.withValues(alpha: 0.06),
            blurRadius: 64.r,
            spreadRadius: 0,
          ),
        ],
      ),
      child: GetBuilder<AuthController>(builder: (authController) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "Create your account",
                textAlign: TextAlign.center,
                style: Helper(context).textTheme.titleMedium?.copyWith(
                      fontSize: 24.sp,
                    ),
              ),
              sizedBoxHeight(height: 8.h),
              Text(
                "Let's get you started with FeeTrack.",
                textAlign: TextAlign.center,
                style: Helper(context).textTheme.titleMedium?.copyWith(
                      fontSize: 14.sp,
                      color: greyDart,
                    ),
              ),
              sizedBoxHeight(height: 32.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Full Name ",
                      style: Helper(context).textTheme.titleSmall?.copyWith(
                            fontSize: 14.sp,
                            color: greyDart2,
                          ),
                      children: const [
                        TextSpan(
                          text: "*",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    height: 60.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(
                        color: const Color(0xFFE4E7EC),
                      ),
                    ),
                    child: TextFormField(
                      controller: authController.fullNameController,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        hintText: "Enter your full name",
                        hintStyle: TextStyle(
                          color: const Color(0xFF98A2B3),
                          fontSize: 16.sp,
                        ),
                        prefixIcon: const Icon(
                          Icons.person_outline,
                          color: Color(0xFF2563EB),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 18.h,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Full Name';
                        }

                        return null;
                      },
                    ),
                  ),
                  sizedBoxHeight(height: 24.h),
                  RichText(
                    text: TextSpan(
                      text: "Mobile Number ",
                      style: Helper(context).textTheme.titleSmall?.copyWith(
                            fontSize: 14.sp,
                            color: greyDart2,
                          ),
                      children: const [
                        TextSpan(
                          text: "*",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    height: 60.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: const Color(0xFFE5E7EB),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Color(0xFFE5E7EB),
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "+91",
                                style: Helper(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontSize: 16.sp,
                                      color: greyDart2,
                                    ),
                              ),
                              SizedBox(width: 8.w),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: const Color(0xFF2563EB),
                                size: 16.sp,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: "Enter your mobile number",
                              hintStyle: Helper(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      fontSize: 16.sp,
                                      color: const Color(0xFF98A2B3)),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                              ),
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: authController.mobileNoController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter your mobile number";
                              }
                              if (value.length != 10) {
                                return "Enter a valid mobile number";
                              }
                              if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
                                return "Enter a valid mobile number";
                              }

                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        CustomImage(
                          path: Assets.imagesProtection,
                          height: 10.h,
                          width: 10.w,
                        ),
                        sizedBoxWidth(width: 16.w),
                        Expanded(
                          child: Text(
                            "We will send OTP to your WhatsApp number",
                            style:
                                Helper(context).textTheme.bodyLarge?.copyWith(
                                      fontSize: 12.sp,
                                      color: greyDart2,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  sizedBoxHeight(height: 10.h),
                  RichText(
                    text: TextSpan(
                      text: "Email ID ",
                      style: Helper(context).textTheme.titleSmall?.copyWith(
                            fontSize: 14.sp,
                            color: greyDart2,
                          ),
                      children: const [
                        TextSpan(
                          text: "*",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    height: 60.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(
                        color: const Color(0xFFE4E7EC),
                      ),
                    ),
                    child: TextFormField(
                      controller: authController.emailController,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        hintText: "Enter your email ID",
                        hintStyle: TextStyle(
                          color: const Color(0xFF98A2B3),
                          fontSize: 16.sp,
                        ),
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: Color(0xFF2563EB),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 18.h,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter email address';
                        }

                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }

                        return null;
                      },
                    ),
                  ),
                  sizedBoxHeight(height: 24.h),

                  // ===== Referral Code Field =====
                  RichText(
                    text: TextSpan(
                      text: "Referral Code ",
                      style: Helper(context).textTheme.titleSmall?.copyWith(
                            fontSize: 14.sp,
                            color: greyDart2,
                          ),
                      children: [
                        if (authController.referralCodeController.text.isNotEmpty)
                          const TextSpan(
                            text: "(Applied)",
                            style: TextStyle(
                              color: Color(0xFF10B981),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    height: 60.h,
                    decoration: BoxDecoration(
                      color: authController.referralCodeController.text.isNotEmpty
                          ? const Color(0xFFF0FDF4)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(
                        color: authController.referralCodeController.text.isNotEmpty
                            ? const Color(0xFF10B981)
                            : const Color(0xFFE4E7EC),
                        width: authController.referralCodeController.text.isNotEmpty
                            ? 1.5
                            : 1,
                      ),
                    ),
                    child: TextFormField(
                      controller: authController.referralCodeController,
                      style: TextStyle(
                        color: authController.referralCodeController.text.isNotEmpty
                            ? const Color(0xFF065F46)
                            : Colors.black,
                        fontSize: 16.sp,
                        fontWeight: authController.referralCodeController.text.isNotEmpty
                            ? FontWeight.w700
                            : FontWeight.normal,
                        letterSpacing: 1.2,
                      ),
                      decoration: InputDecoration(
                        hintText: "Enter referral code (Optional)",
                        hintStyle: TextStyle(
                          color: const Color(0xFF98A2B3),
                          fontSize: 16.sp,
                        ),
                        prefixIcon: Icon(
                          Icons.card_giftcard_rounded,
                          color: authController.referralCodeController.text.isNotEmpty
                              ? const Color(0xFF10B981)
                              : const Color(0xFF2563EB),
                        ),
                        suffixIcon: authController.referralCodeController.text.isNotEmpty
                            ? const Icon(
                                Icons.check_circle,
                                color: Color(0xFF10B981),
                              )
                            : null,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 18.h,
                        ),
                      ),
                    ),
                  ),
                  sizedBoxHeight(height: 24.h),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  children: [
                    GetBuilder<AuthController>(builder: (authController) {
                      return CustomButton(
                        isLoading: authController.isLoading,
                        onTap: () {
                          if (authController.isLoading) {
                            return;
                          }

                          // navigate(
                          //   context: context,
                          //   page: OTPVerification(
                          //     phone: authController.mobileNoController.text,
                          //     gmail: authController.emailController.text,
                          //     isPhone: true,
                          //   ),
                          // );

                          if (_formKey.currentState?.validate() ?? false) {
                            authController.registerUser().then((value) {
                              if (value.isSuccess) {
                                showToast(
                                    message: value.message,
                                    typeCheck: value.isSuccess);

                                navigate(
                                  context: context,
                                  page: OTPVerification(
                                    phone:
                                        authController.mobileNoController.text,
                                    gmail: authController.emailController.text,
                                    isPhone: true,
                                  ),
                                );
                              } else {
                                showToast(
                                    message: value.message,
                                    toastType: ToastType.warning);
                              }
                            });
                          }
                        },
                        height: 50.h,
                        color: textBlue,
                        radius: 999,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Register",
                              style: Helper(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontSize: 14.sp,
                                    color: white,
                                  ),
                            ),
                            sizedBoxWidth(width: 8.w),
                            Icon(
                              Icons.arrow_forward,
                              color: white,
                              size: 18.sp,
                            ),
                          ],
                        ),
                      );
                    }),
                    sizedBoxHeight(height: 24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            "Already have an account?",
                            style:
                                Helper(context).textTheme.bodyMedium?.copyWith(
                                      fontSize: 16.sp,
                                      color: greyText2,
                                    ),
                          ),
                        ),
                        CustomButton(
                          type: ButtonType.tertiary,
                          onTap: () {
                            navigate(
                                context: context, page: const LoginScreen());
                          },
                          child: Text(
                            "Sign In",
                            style:
                                Helper(context).textTheme.titleMedium?.copyWith(
                                      fontSize: 16.sp,
                                      color: primaryText1,
                                    ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
