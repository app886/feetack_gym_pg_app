import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vlr/services/constants.dart';

class ResumeWidget extends StatelessWidget {
  const ResumeWidget({super.key});

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
              "Resume",
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF101828),
              ),
            ),
            InkWell(
              onTap: () {
                showToast(message: "Update Resume clicked", toastType: ToastType.info);
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

        SizedBox(height: 6.h),

        // Resume Card
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: const Color(0xFFEAECF0)),
          ),
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEE2E2),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(Icons.picture_as_pdf_rounded, color: const Color(0xFFDC2626), size: 24.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "MohdZaid_Resume.pdf",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF101828),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      "Last updated 21st Aug 2024",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF667085),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  showToast(message: "Resume options clicked", toastType: ToastType.info);
                },
                icon: Icon(Icons.more_vert_rounded, color: const Color(0xFF667085), size: 20.sp),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
