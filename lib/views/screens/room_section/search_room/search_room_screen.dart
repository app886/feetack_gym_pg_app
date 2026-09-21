import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/home_controller.dart';
import 'package:vlr/controllers/permission_controller.dart';
import 'package:vlr/data/models/category_model/listing_model.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/screens/dashboard/home_screen/All_home/gym_home/widget/gym_home_screen_gym_wight.dart';
import 'package:vlr/views/widget/text_box/app_text_box.dart';

class SearchRoomScreen extends StatefulWidget {
  const SearchRoomScreen({super.key});

  @override
  State<SearchRoomScreen> createState() => _SearchRoomScreenState();
}

class _SearchRoomScreenState extends State<SearchRoomScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final homeController = Get.find<HomeController>();
      final permissionController = Get.find<PermissionController>();

      await permissionController.requestLocationPermissionAndFetch(context);

      await homeController.searchFetchCategoriesListingPagination(
        latitude: permissionController.latitude,
        longitude: permissionController.longitude,
        refresh: true,
      );
    });
  }

  void _onScroll() {
    final homeController = Get.find<HomeController>();

    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !homeController.listingStateSearch.isMoreLoading &&
        homeController.listingStateSearch.canLoadMore) {
      final permissionController = Get.find<PermissionController>();

      homeController.searchFetchCategoriesListingPagination(
        latitude: permissionController.latitude,
        longitude: permissionController.longitude,
        loadMore: true,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    timer?.cancel();
    super.dispose();
  }

  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GetBuilder<HomeController>(
          builder: (homeController) {
            return GetBuilder<PermissionController>(
              builder: (permissionController) {
                return AppTextFieldWithHeading(
                  borderRadius: 99,
                  controller: homeController.searchController,
                  hindText:
                      "Search ${capitalize(homeController.selectCategoryModel?.name ?? "")}",
                  readOnly: false,
                  preFixWidget: Icon(
                    Icons.search,
                    color: grey,
                  ),
                  // If your AppTextFieldWithHeading supports it, call search on submit:
                  onFieldSubmitted: (value) async {
                    final homeController = Get.find<HomeController>();

                    await homeController.searchFetchCategoriesListingPagination(
                      latitude: permissionController.latitude,
                      longitude: permissionController.longitude,
                      refresh: true,
                    );
                  },
                  onChanged: (value) {
                    // Cancel the previous timer only if it exists
                    if (timer?.isActive ?? false) {
                      timer!.cancel();
                    }

                    // Start a new debounce timer
                    timer = Timer(const Duration(milliseconds: 500), () {
                      if (value.isNotEmpty) {
                        homeController.searchFetchCategoriesListingPagination(
                          latitude: permissionController.latitude,
                          longitude: permissionController.longitude,
                          refresh: true,
                        );
                      }
                    });
                  },
                );
              },
            );
          },
        ),
      ),
      body: GetBuilder<HomeController>(
        builder: (homeController) {
          if (homeController.listingStateSearch.isInitialLoading &&
              homeController.listingSearchList.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (homeController.listingSearchList.isEmpty) {
            return const Center(
              child: Text("No listings found"),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              final permissionController = Get.find<PermissionController>();

              await homeController.searchFetchCategoriesListingPagination(
                latitude: permissionController.latitude,
                longitude: permissionController.longitude,
                refresh: true,
              );
            },
            child: ListView.separated(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: homeController.listingSearchList.length +
                  (homeController.listingStateSearch.isMoreLoading ? 1 : 0),
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                if (index == homeController.listingSearchList.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                ListingModel _listModel = homeController.isLoading
                    ? ListingModel()
                    : homeController.listingSearchList[index];
                return GestureDetector(
                  onTap: () {
                    if (homeController.isLoading) return;

                    homeController.updateSelectListingModel(
                      value: _listModel,
                    );

                    // if (homeController.selectListingModel != null) {
                    //   navigate(
                    //     context: context,
                    //     page: const NewGymProfileScreen(),
                    //   );
                    // }
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.82,
                    child: GymHomeScreenGymWight(
                      listingModel: _listModel,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
