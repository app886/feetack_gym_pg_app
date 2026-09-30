import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vlr/services/constants.dart';

class EducationWidget extends StatelessWidget {
  const EducationWidget({super.key});

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
              "Education",
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF101828),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                showToast(message: "Add Education clicked", toastType: ToastType.info);
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

        // Education Summary Rows
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: const Color(0xFFEAECF0)),
          ),
          child: Column(
            children: [
              _buildRow("Highest education", "Graduate"),
              const Divider(height: 1, color: Color(0xFFF2F4F7)),
              _buildRow("Doctorate / PhD", "Explore", textColor: const Color(0xFF0D8A48)),
            ],
          ),
        ),

        SizedBox(height: 10.h),

        // Detailed Degree Card
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
                    child: Icon(Icons.school_rounded, color: const Color(0xFF475467), size: 20.sp),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "B.Sc. , IT Mobile Application and Information Security",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF101828),
                            height: 1.2,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "Lucknow University • Graduate",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF667085),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showToast(message: "Edit Education clicked", toastType: ToastType.info);
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

              Wrap(
                spacing: 8.w,
                runSpacing: 6.h,
                children: [
                  _buildTagChip("English Medium"),
                  _buildTagChip("Full Time"),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRow(String title, String value, {Color? textColor}) {
    return Padding(
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
                  color: textColor ?? const Color(0xFF101828),
                ),
              ),
              SizedBox(width: 4.w),
              Icon(Icons.chevron_right_rounded, size: 18.sp, color: const Color(0xFF98A2B3)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTagChip(String label) {
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
}
