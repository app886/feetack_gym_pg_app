import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/coupons_controller.dart';
import 'package:vlr/controllers/gym_controller.dart';
import 'package:vlr/controllers/home_controller.dart';
import 'package:vlr/controllers/subscription_controller.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/base/common_button.dart';
import 'package:vlr/views/base/custom_image.dart';
import 'package:vlr/views/screens/gym/gym_book_visit_success/gym_book_visit_success_screen.dart';
import 'package:vlr/views/screens/gym/gym_final_step_screen/widget/gym_final_mid_section/month_auth_pay_benefty_row.dart';

import '../../gym_final_step_screen.dart';

import '../../../../../../generated/assets.dart';

class GYMFinalCashPaymentSection extends StatelessWidget {
  const GYMFinalCashPaymentSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubscriptionController>(builder: (subscriptionController) {
      return ExpandablePaymentCard(
        title: "Cash Payment",
        subtitle: "Pay directly at the center for maximum flexibility.",
        imagePath: Assets.imagesCashCirlce,
        price: PriceConverter.convertRound(subscriptionController.billingPreviewModel?.total?.toString() ?? "0"),
        priceSuffix: "/total",
        benefits: gymCashPaymentList,
        actionButton: CustomButton(
          isLoading: subscriptionController.isLoading,
          onTap: () {
            final homeController = Get.find<HomeController>();
            final gymController = Get.find<GymController>();
            final couponsController = Get.find<CouponsController>();

            subscriptionController.createSubscription(
              listingId: homeController.selectListingModel?.id ?? "",
              planId: subscriptionController.selectedPlan?.id ?? "",
              durationId: subscriptionController.selectedDuration?.type ?? "",
              paymentMode: "cash",
              couponCode: couponsController.selectCouponsCodeModel?.code,
              staffId: gymController.selectGymTrainerModel?.id,
              roomId: subscriptionController.selectedRoomId,
              bedsBooked: subscriptionController.selectedBedsCount,
            ).then((value) {
              if (value.isSuccess) {
                final bookingData = value.data;
                final otp = bookingData != null ? bookingData['otp'] : null;
                
                if (otp != null) {
                  showToast(
                    message: "Booking Successful! OTP: $otp",
                    toastType: ToastType.success,
                    description: "Share this OTP with the partner at the center.",
                  );
                }

                navigate(context: context, page: const GymBookVisitSuccessScreen(), isRemoveUntil: true);
              } else {
                showToast(message: value.message, toastType: ToastType.error);
              }
            });
          },
          height: 54,
          radius: 12,
          color: primaryText1,
          borderColor: primaryText1,
          title: "Pay Cash",
          textStyle: Helper(context).textTheme.bodyMedium?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: white,
              ),
        ),
      );
    });
  }
}

List<MonthlyAuthPayModel> gymCashPaymentList = [
  MonthlyAuthPayModel(title: "In-person confirmation", subTitle: ""),
  MonthlyAuthPayModel(
    title: "Manual receipt generation",
    subTitle: "",
  ),
  MonthlyAuthPayModel(title: "Flexible installments available", subTitle: "")
];
