import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:vlr/controllers/home_controller.dart';
import 'package:vlr/data/models/category_model/listing_model.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/base/common_button.dart';
import 'package:vlr/views/base/custom_image.dart';
import 'package:vlr/views/screens/dashboard/home_screen/All_home/gym_home/widget/gym_home_screen_gym_wight.dart';
import 'package:vlr/views/screens/gym/gym_profile/gym_profile_screen.dart';
import 'package:vlr/views/screens/room_section/search_room/search_room_screen.dart';

class GymHomeNearbySection extends StatelessWidget {
  const GymHomeNearbySection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sizedBoxHeight(height: 32),
        GetBuilder<HomeController>(builder: (homeController) {
          return Text(
            "Nearby ${capitalize(homeController.selectCategoryModel?.name ?? "")}",
            style: Helper(context).textTheme.titleMedium?.copyWith(
                  fontSize: 20,
                  color: blackText1,
                ),
          );
        }),
        sizedBoxHeight(height: 24),
        GetBuilder<HomeController>(builder: (homeController) {
          final bool isListLoading = homeController.isLoading;
          final int itemCount = isListLoading ? 4 : homeController.listingModelList.length;

          if (!isListLoading && homeController.listingModelList.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40.h),
                child: Text(
                  "No ${homeController.selectCategoryModel?.name ?? 'results'} found nearby",
                  style: TextStyle(color: greyText3, fontSize: 14.sp),
                ),
              ),
            );
          }

          return GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: itemCount,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16.h,
              crossAxisSpacing: 16.w,
              mainAxisExtent: 220.h, // Fixed height for consistency
            ),
            itemBuilder: (context, index) {
              ListingModel listingModel = isListLoading
                  ? ListingModel()
                  : homeController.listingModelList[index];

              return GestureDetector(
                onTap: () {
                  if (isListLoading) return;

                  homeController.updateSelectListingModel(
                    value: listingModel,
                  );

                  if (homeController.selectListingModel != null) {
                    navigate(
                      context: context,
                      page: const GYMProfileScreen(),
                    );
                  }
                },
                child: _buildNearbyGridCard(
                  listingModel: listingModel,
                  isLoading: isListLoading,
                  index: index,
                ),
              );
            },
          );
        })
      ],
    );
  }

  Widget _buildNearbyGridCard({
    required ListingModel listingModel,
    required bool isLoading,
    required int index,
  }) {
    if (isLoading) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    final String imagePath = (listingModel.images?.isNotEmpty ?? false)
        ? listingModel.images!.first.imagePath ?? listingModel.image ?? ""
        : listingModel.image ?? "";

    final hasStartingPrice =
        listingModel.startingPrice != null && listingModel.startingPrice! > 0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          )
        ],
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.06),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Graphic visual container
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: CustomImage(
                  path: imagePath,
                  width: double.infinity,
                  height: 120.h,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8.h,
                right: 8.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star_rounded, color: Colors.orange, size: 12),
                      SizedBox(width: 2.w),
                      Text(
                        listingModel.rating?.average?.toStringAsFixed(1) ?? "0.0",
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.bold,
                          color: blackText1,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              if (hasStartingPrice)
                Positioned(
                  bottom: 8.h,
                  left: 8.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "₹${listingModel.startingPrice}",
                      style: TextStyle(
                        fontSize: 9.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          // Title & Detail info text
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        listingModel.title ?? 'Elite Location',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w800,
                          color: blackText1,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(Icons.location_on_rounded, size: 11.sp, color: greyText3),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              listingModel.address ?? listingModel.landmark ?? 'Active Street',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: greyText3,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (listingModel.effectiveDistanceKm != null) ...[
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Icon(Icons.directions_walk_rounded,
                                size: 11.sp, color: primaryColor),
                            SizedBox(width: 4.w),
                            Text(
                              "${listingModel.effectiveDistanceKm?.toStringAsFixed(1)} km away",
                              style: TextStyle(
                                fontSize: 9.sp,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.access_time_rounded,
                              size: 11.sp, color: primaryColor),
                          SizedBox(width: 4.w),
                          Text(
                            "Open Now",
                            style: TextStyle(
                              fontSize: 9.sp,
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 14.sp,
                        color: primaryColor,
                      )
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
