import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vlr/controllers/visit_controller.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/lanch_helper.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/base/common_button.dart';
import 'package:vlr/views/base/custom_image.dart';

class GymMyVisitDetailScreen extends StatefulWidget {
  final String visitId;

  const GymMyVisitDetailScreen({super.key, required this.visitId});

  @override
  State<GymMyVisitDetailScreen> createState() => _GymMyVisitDetailScreenState();
}

class _GymMyVisitDetailScreenState extends State<GymMyVisitDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<VisitController>().fetchVisitDetail(id: widget.visitId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Visit Details",
          style: Helper(context).textTheme.bodyMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: primaryText1,
              ),
        ),
        actions: [
          GetBuilder<VisitController>(builder: (visitController) {
            final visit = visitController.selectedVisit;
            if (visit == null) return const SizedBox.shrink();
            return IconButton(
              onPressed: () {
                String shareText = "Visit Details:\n\n"
                    "Gym: ${visit.listing?.title ?? ''}\n"
                    "Address: ${visit.listing?.address ?? ''}\n"
                    "Date: ${visit.visitDate ?? ''}\n"
                    "Time: ${visit.visitTime ?? ''}\n"
                    "Status: ${capitalize(visit.status)}\n\n"
                    "Shared via ${AppConstants.appName}";
                Share.share(shareText);
              },
              icon: Icon(Icons.share_outlined, color: primaryColor),
            );
          }),
          const SizedBox(width: 8),
        ],
      ),
      body: GetBuilder<VisitController>(builder: (visitController) {
        if (visitController.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final visit = visitController.selectedVisit;
        if (visit == null) {
          return const Center(child: Text("Visit not found."));
        }

        return SingleChildScrollView(
          padding: AppConstants.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (visit.listing?.images != null && visit.listing!.images!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: CustomImage(
                    path: visit.listing?.images?.first.imagePath ?? "",
                    height: 200,
                    width: double.infinity,
                    radius: 12,
                    fit: BoxFit.cover,
                    viewFullScreen: true,
                  ),
                ),
              Container(
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
                child: Row(
                  children: [
                    CustomImage(
                      path: (visit.listing?.images?.isNotEmpty ?? false)
                          ? visit.listing!.images!.first.imagePath ?? ""
                          : "",
                      height: 80,
                      width: 80,
                      radius: 8,
                      fit: BoxFit.cover,
                    ),
                    sizedBoxWidth(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            visit.listing?.title ?? "Unknown Gym",
                            style: Helper(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                          ),
                          sizedBoxHeight(height: 8),
                          Text(
                            visit.listing?.address ?? "No Address",
                            style: Helper(context).textTheme.bodyMedium?.copyWith(
                                  color: greyText2,
                                  fontSize: 14,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              sizedBoxHeight(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _buildActionButton(
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
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildActionButton(
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
                          showToast(message: "Location coordinates not available");
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildActionButton(
                      label: "Help",
                      icon: Icons.help_outline,
                      color: Colors.orange,
                      onTap: () {
                        LaunchHelper.launchInBrowser(Uri.parse("https://app.feetrack.in/contact-us"));
                      },
                    ),
                  ),
                ],
              ),
              if (visit.listing?.description != null) ...[
                sizedBoxHeight(height: 24),
                Text(
                  "About",
                  style: Helper(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                ),
                sizedBoxHeight(height: 8),
                Text(
                  visit.listing!.description!,
                  style: Helper(context).textTheme.bodyMedium?.copyWith(
                        color: greyText2,
                        fontSize: 14,
                      ),
                ),
              ],
              sizedBoxHeight(height: 24),
              Text(
                "Booking Information",
                style: Helper(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
              ),
              sizedBoxHeight(height: 16),
              _buildInfoRow(context, "Visit Date", visit.visitDate ?? ""),
              _buildInfoRow(context, "Visit Time", visit.visitTime ?? ""),
              _buildInfoRow(context, "Status", capitalize(visit.status)),
              _buildInfoRow(context, "Note", visit.note ?? "N/A"),
              sizedBoxHeight(height: 32),
              CustomButton(
                onTap: () {
                  visitController.cancelVisit(id: visit.id ?? "").then((value) {
                    if (value.isSuccess) {
                      showToast(message: value.message, typeCheck: true);
                      pop(context);
                    } else {
                      showToast(message: value.message, toastType: ToastType.error);
                    }
                  });
                },
                color: Colors.red.withValues(alpha: 0.1),
                borderColor: Colors.red,
                child: Text(
                  "Cancel Visit",
                  style: Helper(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Helper(context).textTheme.bodyMedium?.copyWith(
                  color: greyText2,
                  fontSize: 14,
                ),
          ),
          Text(
            value,
            style: Helper(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
