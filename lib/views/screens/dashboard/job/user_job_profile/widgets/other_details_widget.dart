import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vlr/data/models/user_model.dart';
import 'package:vlr/services/constants.dart';

class OtherDetailsWidget extends StatelessWidget {
  final UserModel? userModel;

  const OtherDetailsWidget({
    super.key,
    this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    final email = userModel?.email ?? "a@gmail.com";
    final mobile = userModel?.mobile ?? "8926600736";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Text(
          "Other details",
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF101828),
          ),
        ),

        SizedBox(height: 8.h),

        // Preferred Job Title / Role
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: const Color(0xFFEAECF0)),
          ),
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Preferred job title/role",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF101828),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                "Add your preferred job title/role to get recommendations",
                style: TextStyle(fontSize: 12.sp, color: const Color(0xFF667085)),
              ),
              SizedBox(height: 12.h),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 44.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                  side: const BorderSide(color: Color(0xFFD0D5DD)),
                ),
                onPressed: () {
                  showToast(message: "Add preferred title clicked", toastType: ToastType.info);
                },
                icon: Icon(Icons.add, size: 16.sp, color: const Color(0xFF0D8A48)),
                label: Text(
                  "Add preferred title/role",
                  style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700, color: const Color(0xFF0D8A48)),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 10.h),

        // Other Detail Rows Card
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: const Color(0xFFEAECF0)),
          ),
          child: Column(
            children: [
              _buildDetailRow(
                title: "Location",
                subtitle: "Kaisarbagh, Lucknow • 2 preferred locations",
                onTap: () {},
              ),
              const Divider(height: 1, color: Color(0xFFF2F4F7)),
              _buildDetailRow(
                title: "Job preference",
                subtitle: "Full Time • Work from Office • Day Shift • ₹ 35,000 / month",
                onTap: () {},
              ),
              const Divider(height: 1, color: Color(0xFFF2F4F7)),
              _buildDetailRow(
                title: "Documents & assets",
                subtitle: "PAN Card • Aadhaar Card • Android Phone • Laptop",
                onTap: () {},
              ),
              const Divider(height: 1, color: Color(0xFFF2F4F7)),
              _buildDetailRow(
                title: "Basic details",
                subtitle: "Male • $email • $mobile",
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF101828),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF667085),
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, size: 20.sp, color: const Color(0xFF98A2B3)),
          ],
        ),
      ),
    );
  }
}
