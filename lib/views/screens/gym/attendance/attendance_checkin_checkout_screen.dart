import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vlr/controllers/attendance_controller.dart';
import 'package:vlr/controllers/permission_controller.dart';
import 'package:vlr/data/models/attendance_model.dart';
import 'package:vlr/data/models/booking_model.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/base/common_button.dart';
import 'package:vlr/views/base/custom_image.dart';

import 'attendance_history_screen.dart';

class AttendanceCheckinCheckoutScreen extends StatefulWidget {
  const AttendanceCheckinCheckoutScreen({super.key});

  @override
  State<AttendanceCheckinCheckoutScreen> createState() => _AttendanceCheckinCheckoutScreenState();
}

class _AttendanceCheckinCheckoutScreenState extends State<AttendanceCheckinCheckoutScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<AttendanceController>().getBookings();
      Get.find<AttendanceController>().getTodayAttendance();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      appBar: AppBar(
        title: const Text("Attendance Center"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          GetBuilder<AttendanceController>(builder: (controller) {
            return IconButton(
              onPressed: () {
                final listingId = controller.bookingList.isNotEmpty
                    ? controller.bookingList.first.listing?.id
                    : null;
                navigate(
                  context: context,
                  page: AttendanceHistoryScreen(listingId: listingId),
                );
              },
              icon: const Icon(Icons.history_rounded, color: primaryColor),
            );
          }),
        ],
      ),
      body: GetBuilder<AttendanceController>(builder: (controller) {
        if (controller.isLoading && controller.bookingList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: () async {
            await controller.getBookings();
            await controller.getTodayAttendance();
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Active Bookings",
                  style: Helper(context).textTheme.titleMedium?.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: blackText1,
                      ),
                ),
                const SizedBox(height: 16),
                if (controller.bookingList.isEmpty)
                  _buildEmptyState("No active bookings found")
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.bookingList.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final booking = controller.bookingList[index];
                      final todayAttendance = controller.todayAttendanceList.firstWhereOrNull(
                        (a) => a.listingId == booking.listing?.id,
                      );

                      return _buildBookingAttendanceCard(booking, todayAttendance);
                    },
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildBookingAttendanceCard(BookingModel booking, AttendanceModel? attendance) {
    bool isPunchedIn = attendance != null && attendance.status == 'open';
    bool isCompleted = attendance != null && attendance.status == 'completed';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CustomImage(
                  path: booking.listing?.image ?? "",
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking.listing?.title ?? "Unknown Listing",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    
                    Text(
                      booking.plan?.name ?? "",
                      style: TextStyle(color: greyText3, fontSize: 12),
                    ),
                    if (booking.createdAt != null)
                      Text(
                        "Booked on: ${DateFormat("dd MMM yyyy").format(booking.createdAt!)}",
                        style: TextStyle(color: greyText3, fontSize: 11),
                      ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  navigate(
                    context: context,
                    page: AttendanceHistoryScreen(listingId: booking.listing?.id),
                  );
                },
                icon: const Icon(Icons.history_rounded, color: primaryColor, size: 20),
              ),
              if (isCompleted)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: greenDark.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "Done Today",
                    style: TextStyle(color: greenDark, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildTimeInfo(
                  "PUNCH IN",
                  attendance?.punchInAt ?? "--:--",
                  Icons.login_rounded,
                  Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildTimeInfo(
                  "PUNCH OUT",
                  attendance?.punchOutAt ?? "--:--",
                  Icons.logout_rounded,
                  Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (!isCompleted)
            CustomButton(
              onTap: () async {
                final controller = Get.find<AttendanceController>();
                final permissionController = Get.find<PermissionController>();

                // Fetch location first
                bool locationSuccess = await permissionController.requestLocationPermissionAndFetch(context);
                if (!locationSuccess || permissionController.latitude == null || permissionController.longitude == null) {
                  showToast(message: "Location is required for attendance", toastType: ToastType.error);
                  return;
                }

                if (isPunchedIn) {
                  final result = await controller.punchOut(
                    booking.listing?.id ?? "",
                    permissionController.latitude!,
                    permissionController.longitude!,
                  );
                  showToast(message: result.message, toastType: result.isSuccess ? ToastType.success : ToastType.error);
                } else {
                  final result = await controller.punchIn(
                    booking.listing?.id ?? "",
                    permissionController.latitude!,
                    permissionController.longitude!,
                  );
                  showToast(message: result.message, toastType: result.isSuccess ? ToastType.success : ToastType.error);
                }
              },
              color: isPunchedIn ? Colors.orange : primaryColor,
              radius: 12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(isPunchedIn ? Icons.logout_rounded : Icons.login_rounded, color: white, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    isPunchedIn ? "Punch Out" : "Punch In",
                    style:  TextStyle(color: white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          else
             Text(
              "Session for today is completed",
              style: TextStyle(color: greyText3, fontSize: 13, fontStyle: FontStyle.italic),
            ),
          
          if (attendance != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: grey.withValues(alpha: 0.03),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: grey.withValues(alpha: 0.05)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildSummaryItem("Date", attendance.date ?? "--", Icons.calendar_today_rounded),
                  _buildSummaryItem(
                    "Duration", 
                    attendance.durationMinutes != null ? "${attendance.durationMinutes}m" : "--", 
                    Icons.timer_outlined
                  ),
                  _buildSummaryItem("ID", "#${attendance.id ?? '0'}", Icons.tag_rounded),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 10, color: greyText3),
            const SizedBox(width: 4),
            Text(label, style: TextStyle(fontSize: 9, color: greyText3, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
      ],
    );
  }

  Widget _buildTimeInfo(String label, String time, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_busy_rounded, size: 60, color: grey.withValues(alpha: 0.5)),
          const SizedBox(height: 16),
          Text(message, style: TextStyle(color: greyText3)),
        ],
      ),
    );
  }
}
