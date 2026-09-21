import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/coupons_controller.dart';
import 'package:vlr/controllers/home_controller.dart';
import 'package:vlr/data/models/coupons_model.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/base/shimmer.dart';
import 'package:vlr/views/screens/common_screen/coupon_code/widget/coupon_search_widget.dart';
import 'package:vlr/views/screens/common_screen/coupon_code/widget/coupon_widget.dart';
import 'package:vlr/views/screens/common_screen/coupon_code/widget/refer_widget_coupons_code.dart';
import 'package:vlr/views/screens/common_screen/coupon_details_screen/coupon_details_screen.dart';

class CouponCodeScreen extends StatefulWidget {
  const CouponCodeScreen({super.key});

  @override
  State<CouponCodeScreen> createState() => _CouponCodeScreenState();
}

class _CouponCodeScreenState extends State<CouponCodeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final homeController = Get.find<HomeController>();

      Get.find<CouponsController>()
          .fetchCouponsList(id: homeController.selectListingModel?.id ?? "");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(
          "Feetrack",
          style: Helper(context).textTheme.titleMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: blackText3,
              ),
        ),
      ),
      body: Padding(
        padding: AppConstants.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CouponSearchWidget(),
            sizedBoxHeight(height: 32),
            Text(
              "Available Coupons (12)",
              style: Helper(context).textTheme.bodySmall?.copyWith(
                    fontSize: 16,
                    color: blackText3,
                  ),
            ),
            GetBuilder<CouponsController>(builder: (couponsController) {
              if (!couponsController.isLoading &&
                  couponsController.couponsCodeModelList.isEmpty) {
                return const Expanded(
                  child: Center(
                    child: Text("No Coupons Available"),
                  ),
                );
              }

              return Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(top: 16),
                  itemBuilder: (context, index) {
                    final couponLength =
                        couponsController.couponsCodeModelList.length;

                    // Refer card position
                    final referIndex = couponLength >= 3 ? 3 : couponLength;

                    if (index == referIndex) {
                      return const ReferWidgetCouponsCode();
                    }

                    int couponIndex = index;

                    // Adjust index after refer widget
                    if (couponLength >= 3 && index > 3) {
                      couponIndex = index - 1;
                    }

                    final couponsModel = couponsController.isLoading
                        ? CouponsCodeModel()
                        : couponsController.couponsCodeModelList[couponIndex];

                    return CustomShimmer(
                      isLoading: couponsController.isLoading,
                      child: GestureDetector(
                        onTap: () {
                          couponsController.updateSelectCouponsCodeModel(
                            value: couponsModel,
                          );

                          navigate(
                            context: context,
                            page: const CouponDetailsScreen(),
                          );
                        },
                        child: CouponsWidget(
                          couponsModel: couponsModel,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => sizedBoxHeight(height: 16),
                  itemCount: couponsController.isLoading
                      ? 4
                      : couponsController.couponsCodeModelList.length + 1,
                  shrinkWrap: true,
                ),
              );
            })
            //
          ],
        ),
      ),
    );
  }
}
