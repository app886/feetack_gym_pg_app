import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/coupons_controller.dart';
import 'package:vlr/controllers/home_controller.dart';
import 'package:vlr/controllers/subscription_controller.dart';
import 'package:vlr/data/models/coupons_model.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/date_formatters_and_converters.dart';
import 'package:vlr/services/theme.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:vlr/views/base/common_button.dart';

class CouponsWidget extends StatelessWidget {
  final CouponsCodeModel? couponsModel;
  const CouponsWidget({
    super.key,
    this.couponsModel,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPercent = couponsModel?.type == "percent";

    return Container(
      height: MediaQuery.of(context).size.height / 4,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 6,
            spreadRadius: -4,
            color: black.withValues(alpha: 0.10),
          ),
          BoxShadow(
            offset: const Offset(0, 10),
            blurRadius: 15,
            spreadRadius: -3,
            color: black.withValues(alpha: 0.10),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: ColoredBox(
              color: primaryColor.withValues(alpha: 0.10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isPercent
                        ? "${couponsModel?.value ?? 0}%"
                        : "₹${couponsModel?.value ?? 0}",
                    style: Helper(context).textTheme.titleMedium?.copyWith(
                          fontSize: 24,
                          color: blueLight3,
                        ),
                  ),
                  Text(
                    isPercent ? "OFF" : "SAVE",
                    style: Helper(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: blueLight3,
                        ),
                  ),
                ],
              ),
            ),
          ),
          Stack(
            children: [
              const SizedBox(
                width: 42,
                child: Center(
                  child: DottedLine(
                    direction: Axis.vertical,
                    alignment: WrapAlignment.center,
                    lineLength: double.infinity,
                    lineThickness: 1.0,
                    dashLength: 4.0,
                    dashColor: Colors.black,
                    dashRadius: 0.0,
                    dashGapLength: 4.0,
                    dashGapColor: Colors.transparent,
                    dashGapRadius: 0.0,
                    addRepaintBoundary: true,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                child: Container(
                  color: primaryColor.withValues(alpha: 0.10),
                  width: 21,
                ),
              ),
              Positioned(
                top: -21,
                left: 0,
                child: CircleAvatar(
                  radius: 21,
                  backgroundColor: backgroundLight,
                ),
              ),
              Positioned(
                bottom: -21,
                left: 0,
                child: CircleAvatar(
                  radius: 21,
                  backgroundColor: backgroundLight,
                ),
              )
            ],
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 20,
                right: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      color: primaryColor,
                    ),
                    child: Text(
                      couponsModel?.code ?? "",
                      style: Helper(context).textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: blueLight6,
                          ),
                    ),
                  ),
                  Text(
                    "T&C Apply",
                    style: Helper(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: blueLight3,
                        ),
                  ),
                  sizedBoxHeight(height: 12),
                  Row(
                    children: [
                      Text(
                        couponsModel?.title ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: Helper(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: blackText3,
                            ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  /// DESCRIPTION
                  Expanded(
                    child: Text(
                      couponsModel?.description ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Helper(context).textTheme.bodySmall?.copyWith(
                            fontSize: 13,
                            color: greyDart2,
                          ),
                    ),
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Valid till ${couponsModel!.expiresAt ?? getDateTime()}",
                          maxLines: 2,
                          style: Helper(context).textTheme.bodyMedium?.copyWith(
                                fontSize: 12,
                                color: greyText5,
                              ),
                        ),
                      ),
                      GetBuilder<SubscriptionController>(
                          builder: (subscriptionController) {
                        return Expanded(
                          child: CustomButton(
                            onTap: () {
                              final homeController = Get.find<HomeController>();
                              subscriptionController.fetchBillingSummary(
                                listingId: homeController.selectListingModel?.id,
                                packageId: subscriptionController.selectedPlan?.id,
                                couponCode: couponsModel?.code,
                                roomId: subscriptionController.selectedRoomDetail?.id,
                                bedsBooked: subscriptionController.selectedBedsCount,
                                shiftId: subscriptionController.selectedBatch?.id?.toString(),
                              ).then((value) {
                                if (value.isSuccess) {
                                  Navigator.pop(context);
                                  showToast(
                                      message: "Coupon Applied Successfully",
                                      toastType: ToastType.success);
                                } else {
                                  showToast(
                                      message: value.message,
                                      toastType: ToastType.error);
                                }
                              });
                            },
                            child: Text(
                              "Apply",
                              style: Helper(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: white,
                                  ),
                            ),
                          ),
                        );
                      })
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
