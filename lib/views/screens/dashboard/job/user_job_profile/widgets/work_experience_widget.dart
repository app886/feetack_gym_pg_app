import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vlr/services/constants.dart';

class WorkExperienceWidget extends StatelessWidget {
  const WorkExperienceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Work Experience",
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF101828),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                showToast(message: "Add Experience clicked", toastType: ToastType.info);
              },
              icon: Icon(Icons.add, size: 16.sp, color: const Color(0xFF0D8A48)),
              label: Text(
                "Add",
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0D8A48),
                ),
              ),
            ),
          ],
        ),

        // Main Experience Card
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F4F7),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(Icons.business_rounded, color: const Color(0xFF475467), size: 20.sp),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Flutter Developer",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF101828),
                          ),
                        ),
                        Text(
                          "Zaleem",
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF667085),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showToast(message: "Edit Experience clicked", toastType: ToastType.info);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.edit_outlined, size: 14.sp, color: const Color(0xFF0D8A48)),
                        SizedBox(width: 2.w),
                        Text(
                          "Edit",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0D8A48),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 12.h),

              _buildFieldLabelValue("Job Role", "Software Development"),
              SizedBox(height: 6.h),
              _buildFieldLabelValue("Industry", "Ecommerce"),
              SizedBox(height: 6.h),
              _buildFieldLabelValue("Skills", "Smart Contract Development"),

              SizedBox(height: 12.h),

              Wrap(
                spacing: 8.w,
                runSpacing: 6.h,
                children: [
                  _buildStatusChip("Currently Working"),
                  _buildStatusChip("Full Time"),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 10.h),

        // Summary Rows Card
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: const Color(0xFFEAECF0)),
          ),
          child: Column(
            children: [
              _buildSummaryRow(
                title: "Total Years of Experience",
                value: "0 years, 0 months",
                onTap: () {},
              ),
              const Divider(height: 1, color: Color(0xFFF2F4F7)),
              _buildSummaryRow(
                title: "Current Monthly Salary",
                value: "₹ 35,000",
                onTap: () {},
              ),
              const Divider(height: 1, color: Color(0xFFF2F4F7)),
              _buildSummaryRow(
                title: "Internships",
                value: "+ Add",
                valueColor: const Color(0xFF0D8A48),
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFieldLabelValue(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 11.sp, color: const Color(0xFF98A2B3)),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: const Color(0xFF344054)),
        ),
      ],
    );
  }

  Widget _buildStatusChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF475467),
        ),
      ),
    );
  }

  Widget _buildSummaryRow({
    required String title,
    required String value,
    Color? valueColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF667085),
              ),
            ),
            Row(
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: valueColor ?? const Color(0xFF101828),
                  ),
                ),
                SizedBox(width: 4.w),
                Icon(Icons.chevron_right_rounded, size: 18.sp, color: const Color(0xFF98A2B3)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
