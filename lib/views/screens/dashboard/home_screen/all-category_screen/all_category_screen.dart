import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:vlr/controllers/auth_controller.dart';
import 'package:vlr/controllers/home_controller.dart';
import 'package:vlr/controllers/permission_controller.dart';
import 'package:vlr/data/models/category_model/category_model.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/views/base/shimmer.dart';
import 'package:vlr/views/screens/dashboard/home_screen/All_home/gym_home/gym_home_screen.dart';
import 'package:vlr/views/screens/dashboard/home_screen/all_category_home/widget/category_widget_all_home.dart';
import 'package:vlr/views/screens/dashboard/home_screen/service_appbar/service_appbar.dart';

class AllCategoryScreen extends StatefulWidget {
  const AllCategoryScreen({super.key});

  @override
  State<AllCategoryScreen> createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends State<AllCategoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final authController = Get.find<AuthController>();
      final permissionController = Get.find<PermissionController>();

      authController.fetchProfile();

      Get.find<HomeController>().fetchCategories();
      await fetchLocation(permissionController);
    });
  }

  Future<void> fetchLocation(PermissionController permissionController) async {
    if (!permissionController.locationFetched) {
      await permissionController.requestLocationPermissionAndFetch(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ServiceAppbar(
        title: "Feetrack all service",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppConstants.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizedBoxHeight(height: 12),
              GetBuilder<PermissionController>(builder: (permissionController) {
                return GetBuilder<HomeController>(
                  builder: (homeController) {
                    if (!homeController.isLoading &&
                        homeController.categoryModelList.isEmpty) {
                      return const Center(
                        child: Text("No Categories Found"),
                      );
                    }

                    return GridView.builder(
                      itemCount: homeController.isLoading
                          ? 4
                          : homeController.categoryModelList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 8,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        final CategoryModel categoryModel =
                            homeController.isLoading
                                ? CategoryModel()
                                : homeController.categoryModelList[index];

                        return CustomShimmer(
                          isLoading: homeController.isLoading,
                          child: GestureDetector(
                            onTap: () async {
                              if (homeController.isLoading) {
                                return;
                              }
                              homeController
                                  .updateSelectCategoryModel(categoryModel);

                              await fetchLocation(permissionController);

                              navigate(
                                  context: context,
                                  page: const GymHomeScreen());
                            },
                            child: homeController.isLoading
                                ? Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  )
                                : CategoryWidgetHome(
                                    categoryModel: categoryModel,
                                  ),
                          ),
                        );
                      },
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
