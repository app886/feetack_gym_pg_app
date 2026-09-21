import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/room_controller.dart';
import 'package:vlr/data/models/rooom/pg_room_model.dart';
import 'package:vlr/data/models/category_model/package_model.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/lanch_helper.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/base/common_button.dart';

import '../../../../../../controllers/home_controller.dart';
import '../../../../../../controllers/subscription_controller.dart';
import '../../../../../../generated/assets.dart';
import '../../../../gym/gym_select_plan_screen.dart/gym_select_plan_screen.dart';
import '../../../../room_section/Pg/select_room_bed/widget/room_widget.dart';

class RoomProfileMedSection extends StatelessWidget {
  const RoomProfileMedSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoomController>(builder: (roomController) {
      final room = roomController.selectedRoomDetails;
      final partner = room?.partner;
      final listing = room?.listing;
      final packages = room?.packages ?? [];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── Included Facilities (Quick View) ────────────────────────────────
          if (packages.isNotEmpty && (packages.first.features?.isNotEmpty ?? false)) ...[
            sizedBoxHeight(height: 32),
            Text(
              "Included Facilities",
              style: Helper(context).textTheme.titleMedium?.copyWith(
                    fontSize: 16,
                    color: blackText3,
                  ),
            ),
            sizedBoxHeight(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: List.generate(
                (packages.first.features!.length > 4) ? 4 : packages.first.features!.length,
                (index) {
                  final feature = packages.first.features![index];
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: greyLight5,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.check_circle_outline, size: 14, color: primaryColor),
                        sizedBoxWidth(width: 6),
                        Text(
                          feature,
                          style: Helper(context).textTheme.titleMedium?.copyWith(
                                fontSize: 11,
                                color: greyDart2,
                              ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],

          // ─── Available Packages (Detailed Section) ─────────────────────────
          // if (packages.isNotEmpty) ...[
          //   sizedBoxHeight(height: 32),
          //   Text(
          //     "Available Packages",
          //     style: Helper(context).textTheme.titleMedium?.copyWith(
          //           fontSize: 16,
          //           color: blackText3,
          //         ),
          //   ),
          //   sizedBoxHeight(height: 16),
          //   ...packages.map((pkg) => _PackageCard(package: pkg)),
          // ],

          // ─── Property Manager ──────────────────────────────────────────────
          sizedBoxHeight(height: 32),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                width: 1,
                color: greyLight1.withValues(alpha: 0.30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "PROPERTY MANAGED BY",
                  style: Helper(context).textTheme.titleMedium?.copyWith(
                        fontSize: 16,
                        color: greyDart2,
                      ),
                ),
                sizedBoxHeight(height: 16),
                Row(
                  children: [
                    Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: greyLight5),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: (partner?.profilePhotoUrl != null)
                              ? NetworkImage(partner!.profilePhotoUrl!)
                              : const AssetImage(Assets.imagesReview1) as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    sizedBoxWidth(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            partner?.name ?? "Rajesh Khanna",
                            style:
                                Helper(context).textTheme.displayMedium?.copyWith(
                                      fontSize: 16,
                                      color: blackText3,
                                    ),
                          ),
                          Text(
                            "Verified Partner",
                            style: Helper(context).textTheme.bodyMedium?.copyWith(
                                  fontSize: 12,
                                  color: greyDart2,
                                ),
                          ),
                        ],
                      ),
                    ),
                    sizedBoxWidth(width: 16),
                    if (partner?.mobile != null) ...[
                      SizedBox(
                        height: 44,
                        width: 44,
                        child: CustomButton(
                          color: blueLight4,
                          borderColor: blueLight4,
                          radius: 999,
                          onTap: () => LaunchHelper.callUs(number: partner!.mobile!),
                          child: SvgPicture.asset(
                            Assets.svgsCall,
                            fit: BoxFit.cover,
                            colorFilter:
                                const ColorFilter.mode(greenDark, BlendMode.srcIn),
                          ),
                        ),
                      ),
                      sizedBoxWidth(width: 8),
                      SizedBox(
                        height: 44,
                        width: 44,
                        child: CustomButton(
                          color: blueLight3,
                          borderColor: blueLight3,
                          radius: 999,
                          onTap: () => LaunchHelper.launchWhatsApp(phone: partner!.mobile!),
                          child: SvgPicture.asset(
                            Assets.svgsMessage,
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(white, BlendMode.srcIn),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          // ─── About Property ────────────────────────────────────────────────
          if (listing?.about != null) ...[
            sizedBoxHeight(height: 24),
            Text(
              "About Property",
              style: Helper(context).textTheme.titleMedium?.copyWith(
                    fontSize: 16,
                    color: blackText3,
                  ),
            ),
            sizedBoxHeight(height: 12),
            Text(
              listing!.about!,
              style: Helper(context).textTheme.bodySmall?.copyWith(
                    fontSize: 14,
                    color: greyDart2,
                  ),
            ),
          ],
          sizedBoxHeight(height: 12),
        ],
      );
    });
  }
}

class _PackageCard extends StatelessWidget {
  final RoomPackage package;
  const _PackageCard({required this.package});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: greyLight1.withValues(alpha: 0.30)),
        boxShadow: [
          BoxShadow(
            color: black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          onExpansionChanged: (isExpanded) {
            if (isExpanded && package.occupancyType == 'per_bed') {
              final subController = Get.find<SubscriptionController>();
              final homeController = Get.find<HomeController>();
              final roomController = Get.find<RoomController>();
              
              final listingId = homeController.selectListingModel?.id ?? "";
              final roomId = roomController.selectedRoomDetails?.id;
              
              // Pre-fetch rooms for this specific package to show in the list
              subController.fetchPlanListingById(
                id: listingId,
                roomId: roomId,
                packageId: package.id,
              );
            }
          },
          tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          childrenPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      package.name ?? "Plan",
                      style: Helper(context).textTheme.titleMedium?.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: blackText3,
                          ),
                    ),
                    if (package.roomType != null)
                      Text(
                        package.roomType!,
                        style: Helper(context).textTheme.bodySmall?.copyWith(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: blueLight4,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  package.durationLabel ?? package.type ?? "",
                  style: const TextStyle(color: primaryColor, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Icon(Icons.person_outline, size: 14, color: greyDart2),
                const SizedBox(width: 4),
                Text(
                  "Occupancy: ${package.occupancyType?.replaceAll('_', ' ').capitalizeFirst ?? ''}",
                  style: Helper(context).textTheme.bodySmall?.copyWith(color: greyDart2, fontSize: 12),
                ),
              ],
            ),
          ),
          children: [
            const Divider(),
            sizedBoxHeight(height: 12),
            
            // Details Grid
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _DetailItem(label: "Price", value: "₹${package.price}"),
                _DetailItem(label: "Duration", value: "${package.durationDays ?? '--'} Days"),
              ],
            ),
            
            sizedBoxHeight(height: 16),
            
            // Features Section
            if (package.features != null && package.features!.isNotEmpty) ...[
              Text(
                "Features & Inclusions",
                style: Helper(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              sizedBoxHeight(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: package.features!.map((f) => _FeatureChip(label: f)).toList(),
              ),
              sizedBoxHeight(height: 16),
            ],

            // Meal Plan Section
            if (package.mealPlans != null) ...[
              Text(
                "Meal Plan Details",
                style: Helper(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              sizedBoxHeight(height: 8),
              Row(
                children: [
                  if (package.mealPlans!.hasBreakfast ?? false) const _MealTag(label: "Breakfast"),
                  if (package.mealPlans!.hasLunch ?? false) const _MealTag(label: "Lunch"),
                  if (package.mealPlans!.hasDinner ?? false) const _MealTag(label: "Dinner"),
                ],
              ),
              sizedBoxHeight(height: 4),
              Text(
                "Meal Type: ${package.mealPlans!.mealType?.capitalizeFirst ?? 'Standard'}",
                style: Helper(context).textTheme.bodySmall?.copyWith(fontSize: 12),
              ),
              sizedBoxHeight(height: 16),
            ],

            // ─── Available Rooms Section (if per_bed) ──────────────────────
            if (package.occupancyType == 'per_bed') ...[
              const Divider(),
              sizedBoxHeight(height: 16),
              Text(
                "Select Number of Beds",
                style: Helper(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              sizedBoxHeight(height: 12),
              GetBuilder<RoomController>(builder: (roomController) {
                final availableBeds = roomController.selectedRoomDetails?.availableBeds ?? 0;
                
                if (availableBeds == 0) {
                  return const Text("No beds available in this room", style: TextStyle(fontSize: 12, color: Colors.red));
                }

                return GetBuilder<SubscriptionController>(builder: (subController) {
                  return SizedBox(
                    height: 50,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: availableBeds,
                      separatorBuilder: (_, __) => sizedBoxWidth(width: 12),
                      itemBuilder: (context, index) {
                        final bedCount = index + 1;
                        final isSelected = subController.selectedBedsCount == bedCount;
                        
                        return GestureDetector(
                          onTap: () {
                            subController.updateSelectBedsCount(bedCount);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor : white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected ? primaryColor : greyLight1,
                                width: 1.5,
                              ),
                              boxShadow: isSelected ? [
                                BoxShadow(
                                  color: primaryColor.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                )
                              ] : [],
                            ),
                            child: Text(
                              "$bedCount",
                              style: TextStyle(
                                color: isSelected ? white : blackText3,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                });
              }),
              sizedBoxHeight(height: 20),
            ],

            // Select Button
            CustomButton(
              height: 48,
              minWidth: double.infinity,
              radius: 12,
              onTap: () {
                final subController = Get.find<SubscriptionController>();
                final homeController = Get.find<HomeController>();
                final roomController = Get.find<RoomController>();
                
                final listingId = homeController.selectListingModel?.id ?? "";
                final roomId = roomController.selectedRoomDetails?.id;
                
                // Update selection in controller
                subController.updateSelectPackageModel(value: PackageModel(
                  id: package.id,
                  name: package.name,
                  price: package.price?.toString(),
                  type: package.type,
                ));

                // Fetch plans filtered by this specific package and room
                subController.fetchPlanListingById(
                  id: listingId,
                  roomId: roomId,
                  packageId: package.id,
                  bedsBooked: package.occupancyType == 'per_bed' ? subController.selectedBedsCount : 1,
                );
                
                navigate(context: context, page: const GymSelectPlanScreen());
              },
              child:  Text("Select This Plan", style: TextStyle(color: white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailItem extends StatelessWidget {
  final String label;
  final String value;
  const _DetailItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style:  TextStyle(fontSize: 11, color: greyText2)),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: primaryColor)),
      ],
    );
  }
}

class _FeatureChip extends StatelessWidget {
  final String label;
  const _FeatureChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: greyLight5,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: greyLight1.withValues(alpha: 0.2)),
      ),
      child: Text(label, style:  TextStyle(fontSize: 11, color: greyDart2)),
    );
  }
}

class _MealTag extends StatelessWidget {
  final String label;
  const _MealTag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8, top: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: greenDark.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.restaurant_menu, size: 10, color: greenDark),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(color: greenDark, fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
