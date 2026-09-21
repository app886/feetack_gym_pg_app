import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../controllers/attendance_controller.dart';
import '../../../../services/theme.dart';

class AttendanceHistoryScreen extends StatefulWidget {
  final String? listingId;
  const AttendanceHistoryScreen({super.key, this.listingId});

  @override
  State<AttendanceHistoryScreen> createState() => _AttendanceHistoryScreenState();
}

class _AttendanceHistoryScreenState extends State<AttendanceHistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<AttendanceController>().getAttendanceHistory(listingId: widget.listingId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      appBar: AppBar(
        title: const Text("Attendance History"),
        centerTitle: true,
      ),
      body: GetBuilder<AttendanceController>(builder: (controller) {
        if (controller.isLoading && controller.attendanceHistoryList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.attendanceHistoryList.isEmpty) {
          return const Center(child: Text("No history found"));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: controller.attendanceHistoryList.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final attendance = controller.attendanceHistoryList[index];
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 40,
                    decoration: BoxDecoration(
                      color: attendance.status == 'completed' ? greenDark : Colors.blue,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          attendance.listing ?? "Gym Session",
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          attendance.date ?? "",
                          style: TextStyle(color: greyText3, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${attendance.punchInAt ?? ''} - ${attendance.punchOutAt ?? ''}",
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                      ),
                      if (attendance.durationMinutes != null)
                        Text(
                          "${attendance.durationMinutes} mins",
                          style: const TextStyle(color: primaryColor, fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
