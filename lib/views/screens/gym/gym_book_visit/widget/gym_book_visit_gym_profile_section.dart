import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/home_controller.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/lanch_helper.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/base/common_button.dart';
import 'package:vlr/views/base/custom_image.dart';

class GYMBookingVisitGYMProfile extends StatelessWidget {
  const GYMBookingVisitGYMProfile({super.key});

  String _formatTime(String? timeStr) {
    if (timeStr == null || timeStr.isEmpty) return '';
    try {
      final parts = timeStr.split(':');
      if (parts.length >= 2) {
        final hour = int.parse(parts[0]);
        final minute = int.parse(parts[1]);
        final ampm = hour >= 12 ? 'PM' : 'AM';
        final formattedHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
        final formattedMinute = minute.toString().padLeft(2, '0');
        return '$formattedHour:$formattedMinute $ampm';
      }
    } catch (_) {}
    return timeStr;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (homeController) {
      final listing = homeController.selectListingModel;
      final category = listing?.category;
      
      final gymImage = listing?.images?.isNotEmpty == true 
          ? listing!.images![0].imagePath ?? ""

          : Assets.imagesGymBanner;

      final opening = _formatTime(listing?.openingTime);

      final closing = _formatTime(listing?.closingTime);

      final timings = (opening.isNotEmpty && closing.isNotEmpty)
          ? "$opening – $closing"
          : "Not Available";

      final rating = listing?.rating?.average ?? 0.0;

      final count = listing?.rating?.count ?? 0;

      return Container(
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: black.withValues(alpha: 0.06),
              blurRadius: 24,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section with Image and Basic Info
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImage(
                    path: gymImage,
                    height: 90,
                    width: 90,
                    radius: 16,
                    fit: BoxFit.cover,
                  ),
                  sizedBoxWidth(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category Badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F5E9),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            category?.name ?? "Gym",
                            style: const TextStyle(
                              color: Color(0xFF2E7D32),
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        sizedBoxHeight(height: 8),
                        Text(
                          listing?.title ?? "Iron Haven Elite",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Helper(context).textTheme.titleLarge?.copyWith(
                                color: const Color(0xFF1A1A2E),
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                              ),
                        ),
                        sizedBoxHeight(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.star_rounded, color: Colors.orange, size: 18),
                            sizedBoxWidth(width: 4),
                            Text(
                              rating > 0 ? rating.toStringAsFixed(1) : "New",
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF1A1A2E),
                                fontSize: 14,
                              ),
                            ),
                            sizedBoxWidth(width: 8),
                            Text(
                              "($count Reviews)",
                              style: TextStyle(
                                color: greyText2,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1, color: Color(0xFFF0F2F5)),

            // Details Section (Timings & Location)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _InfoRow(
                    icon: Icons.access_time_rounded,
                    iconColor: const Color(0xFF00897B),
                    text: timings,
                    textStyle: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF424242),
                    ),
                  ),
                  sizedBoxHeight(height: 12),
                  _InfoRow(
                    icon: Icons.location_on_outlined,
                    iconColor: const Color(0xFF757575),
                    text: listing?.address ?? "Premium Fitness Studio, Lucknow",
                    textStyle: TextStyle(
                      fontSize: 12,
                      color: greyText2,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // Action Buttons
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFB),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
                border: Border.all(color: const Color(0xFFF0F2F5)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onTap: () {
                        LaunchHelper.callUs(number: listing?.phone?.toString() ?? "7972391849");
                      },
                      height: 44,
                      radius: 10,
                      type: ButtonType.secondary,
                      borderColor: primaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.call_rounded, color: primaryColor, size: 18),
                          sizedBoxWidth(width: 4),
                          Text(
                            "Call",
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  sizedBoxWidth(width: 8),
                  Expanded(
                    child: CustomButton(
                      onTap: () {
                        if (listing?.lat != null && listing?.lng != null) {
                          LaunchHelper.openGoogleMap(
                            lat: listing!.lat!.toString(),
                            lng: listing!.lng!.toString(),
                          );
                        } else {
                          showToast(message: "Location not available");
                        }
                      },
                      height: 44,
                      radius: 10,
                      type: ButtonType.secondary,
                      borderColor: Colors.blue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.map_outlined, color: Colors.blue, size: 18),
                          sizedBoxWidth(width: 4),
                          const Text(
                            "Map",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  sizedBoxWidth(width: 8),
                  Expanded(
                    child: CustomButton(
                      onTap: () {
                        LaunchHelper.launchWhatsApp(phone: listing?.phone?.toString() ?? "7972391849");
                      },
                      height: 44,
                      radius: 10,
                      color: greenDark,
                      borderColor: greenDark,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.chat_bubble_rounded, color: white, size: 18),
                          sizedBoxWidth(width: 4),
                          Text(
                            "Help",
                            style: TextStyle(
                              color: white,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String text;
  final TextStyle textStyle;

  const _InfoRow({
    required this.icon,
    required this.iconColor,
    required this.text,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor, size: 16),
        sizedBoxWidth(width: 8),
        Expanded(
          child: Text(
            text,
            style: textStyle,
          ),
        ),
      ],
    );
  }
}
