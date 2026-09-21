import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/home_controller.dart';
import 'package:vlr/controllers/permission_controller.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/views/screens/dashboard/home_screen/All_home/gym_home/widget/gym_home_nearby_section.dart';
import 'package:vlr/views/screens/dashboard/home_screen/All_home/gym_home/widget/home_banner_section.dart';
import 'package:vlr/views/screens/dashboard/home_screen/All_home/room_home/widget/room_home_search_section.dart';
import 'package:vlr/views/screens/dashboard/home_screen/service_appbar/service_appbar.dart';
import 'package:vlr/views/screens/room_section/search_room/search_room_screen.dart';

import '../../../../../../controllers/common_controller.dart';
import '../../../../../../services/theme.dart';

class GymHomeScreen extends StatefulWidget {
  const GymHomeScreen({
    super.key,
  });

  @override
  State<GymHomeScreen> createState() => _GymHomeScreenState();
}

class _GymHomeScreenState extends State<GymHomeScreen> {
  Future<void> _fetchLocationAndData() async {
    final homeController = Get.find<HomeController>();
    final permissionController = Get.find<PermissionController>();

    await permissionController.requestLocationPermissionAndFetch(context);
    
    Get.find<CommonController>().fetchBanner();
    homeController.fetchBannerCategoriesListingById();
    
    await homeController.fetchCategoriesListing(
      latitude: permissionController.latitude,
      longitude: permissionController.longitude,
      categoryId: homeController.selectCategoryModel?.id?.toString(),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchLocationAndData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: GetBuilder<HomeController>(
          builder: (homeController) => ServiceAppbar(
            title: "Feetrack ${homeController.selectCategoryModel?.name ?? ''}",
          ),
        ),
      ),
      body: GetBuilder<HomeController>(
        builder: (homeController) {
          if (homeController.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            padding: AppConstants.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                
                // Location Selector (Similar to AllCategoryHomeScreen)
                GetBuilder<PermissionController>(builder: (permissionController) {
                  return InkWell(
                    onTap: _fetchLocationAndData,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            color: primaryColor,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              permissionController.address ??
                                  (permissionController.locationFetched
                                      ? "Location Found"
                                      : "Select Location"),
                              style: Helper(context).textTheme.bodyLarge?.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: blackText1,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: greyText3,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 16),
                const HomeBanner(),
                const SizedBox(height: 32),
                GetBuilder<HomeController>(
                  builder: (homeController) {
                    return RoomHomeSearchBar(
                      hindText:
                          "Search by ${homeController.selectCategoryModel?.name ?? ""}...",
                      onTap: () {
                        // homeController.updateSelectedServiceType(
                        //   value: SelectTypeService.gym,
                        // );
                        navigate(
                          context: context,
                          page: const SearchRoomScreen(),
                        );
                      },
                    );
                  },
                ),
                const GymHomeNearbySection(),
              ],
            ),
          );
        },
      ),
    );
  }
}
