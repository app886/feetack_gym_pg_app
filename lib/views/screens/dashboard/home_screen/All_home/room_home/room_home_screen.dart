import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/common_controller.dart';
import 'package:vlr/controllers/home_controller.dart';
import 'package:vlr/controllers/permission_controller.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/views/screens/dashboard/home_screen/All_home/gym_home/widget/home_banner_section.dart';
import 'package:vlr/views/screens/dashboard/home_screen/All_home/room_home/widget/recommmended_for_you_row_widget.dart';
import 'package:vlr/views/screens/dashboard/home_screen/All_home/room_home/widget/room_home_search_section.dart';
import 'package:vlr/views/screens/dashboard/home_screen/All_home/room_home/widget/room_recommended_section.dart';
import 'package:vlr/views/screens/dashboard/home_screen/All_home/room_home/widget/setup_auto_pay_container.dart';
import 'package:vlr/views/screens/dashboard/home_screen/All_home/room_home/widget/why_choose_feetrack.dart';
import 'package:vlr/views/screens/dashboard/home_screen/service_appbar/service_appbar.dart';
import 'package:vlr/views/screens/room_section/search_room/search_room_screen.dart';

class RoomHomeScreen extends StatefulWidget {
  const RoomHomeScreen({
    super.key,
  });

  @override
  State<RoomHomeScreen> createState() => _RoomHomeScreenState();
}

class _RoomHomeScreenState extends State<RoomHomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final homeController = Get.find<HomeController>();
      final permissionController = Get.find<PermissionController>();

      await permissionController.requestLocationPermissionAndFetch(context);

      await homeController.fetchCategoriesListing(
        latitude: permissionController.latitude,
        longitude: permissionController.longitude,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ServiceAppbar(
        title: "Feetrack Room",
      ),
      body: SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child: Column(
          children: [
            const SizedBox(height: 12),
            const HomeBanner(),
            const SizedBox(height: 16),
            GetBuilder<CommonController>(builder: (commonController) {
              return RoomHomeSearchBar(
                  hindText: "Search by location, property name...",
                  onTap: () {
                    commonController.updateSelectedServiceType(
                        value: SelectTypeService.room);
                    navigate(context: context, page: const SearchRoomScreen());
                  });
            }),
            sizedBoxHeight(height: 32),
            const RecommendedForYouRow(
              isRoom: true,
            ),
            const RoomRecommendedSection(
              isRoom: true,
            ),
            const RecommendedForYouRow(
              isRoom: false,
            ),
            const RoomRecommendedSection(
              isRoom: false,
            ),
            const WhyChooseFeetrack(),
            sizedBoxHeight(height: 32),
            const SetUpAskContainer()
          ],
        ),
      ),
    );
  }
}
