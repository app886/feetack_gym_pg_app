import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vlr/services/constants.dart';

class SkillsWidget extends StatelessWidget {
  const SkillsWidget({super.key});

  final List<String> skills = const [
    "React Native",
    "Flutter",
    "Android",
    "Firebase",
    "Dart",
    "REST API",
    "Git/GitHub",
    "Problem Solving",
    "Software Development",
    "Team Management",
    "Debugging",
    "UI/UX Design",
  ];

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
              "Skills",
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF101828),
              ),
            ),
            InkWell(
              onTap: () {
                showToast(message: "Edit Skills clicked", toastType: ToastType.info);
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

        // Skills Card
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: const Color(0xFFEAECF0)),
          ),
          padding: EdgeInsets.all(16.w),
          child: Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: skills
                .map((skill) => Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check_circle_rounded, size: 14.sp, color: const Color(0xFF0D8A48)),
                          SizedBox(width: 5.w),
                          Text(
                            skill,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF334155),
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
