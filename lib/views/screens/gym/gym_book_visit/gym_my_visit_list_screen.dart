import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/visit_controller.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/lanch_helper.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/base/custom_image.dart';
import 'package:vlr/views/screens/gym/gym_book_visit/gym_my_visit_detail_screen.dart';

class GymMyVisitListScreen extends StatefulWidget {
  const GymMyVisitListScreen({super.key});

  @override
  State<GymMyVisitListScreen> createState() => _GymMyVisitListScreenState();
}

class _GymMyVisitListScreenState extends State<GymMyVisitListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<VisitController>().fetchVisits();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Visits",
          style: Helper(context).textTheme.bodyMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: primaryText1,
              ),
        ),
      ),
      body: GetBuilder<VisitController>(builder: (visitController) {
        if (visitController.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (visitController.visitList.isEmpty) {
          return const Center(child: Text("No visits found."));
        }

        return ListView.separated(
          padding: AppConstants.screenPadding,
          itemCount: visitController.visitList.length,
          separatorBuilder: (context, index) => sizedBoxHeight(height: 16),
          itemBuilder: (context, index) {
            final visit = visitController.visitList[index];
            return GestureDetector(
              onTap: () {
                navigate(context: context, page: GymMyVisitDetailScreen(visitId: visit.id ?? ""));
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: greyLight2.withValues(alpha: 0.2)),
                  boxShadow: [
                    BoxShadow(
                      color: black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // CustomImage(
                        //   path: "assets/images/placeholder.png", // Fallback or Listing image
                        //   height: 60,
                        //   width: 60,
                        //   radius: 8,
                        //   fit: BoxFit.cover,
                        // ),
                        sizedBoxWidth(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                visit.listing?.title ?? "Unknown Gym",
                                style: Helper(context).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                              ),
                              sizedBoxHeight(height: 8),
                              Text(
                                "Date: ${visit.visitDate} | Time: ${visit.visitTime}",
                                style: Helper(context).textTheme.bodyMedium?.copyWith(
                                      color: greyText2,
                                      fontSize: 14,
                                    ),
                              ),
                              sizedBoxHeight(height: 8),
                              Text(
                                "Status: ${capitalize(visit.status)}",
                                style: Helper(context).textTheme.bodyMedium?.copyWith(
                                      color: visit.status == 'pending' ? Colors.orange : Colors.green,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    sizedBoxHeight(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildActionButton(
                            context: context,
                            label: "Call",
                            icon: Icons.phone_outlined,
                            color: Colors.green,
                            onTap: () {
                              if (visit.listing?.phone != null) {
                                LaunchHelper.callUs(number: visit.listing!.phone!.toString());
                              } else {
                                showToast(message: "Phone number not available");
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildActionButton(
                            context: context,
                            label: "Map",
                            icon: Icons.map_outlined,
                            color: Colors.blue,
                            onTap: () {
                              if (visit.listing?.lat != null && visit.listing?.lng != null) {
                                LaunchHelper.openGoogleMap(
                                  lat: visit.listing!.lat!.toString(),
                                  lng: visit.listing!.lng!.toString(),
                                );
                              } else {
                                showToast(message: "Location not available");
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildActionButton(
                            context: context,
                            label: "Help",
                            icon: Icons.help_outline,
                            color: Colors.orange,
                            onTap: () {
                              LaunchHelper.launchInBrowser(Uri.parse("https://app.feetrack.in/about-us"));
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 16),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
