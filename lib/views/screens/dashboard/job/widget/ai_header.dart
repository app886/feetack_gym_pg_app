import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:vlr/views/base/custom_image.dart';

class AiHeader extends StatelessWidget {
  const AiHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --------------------------------------------------
        // GREETING
        // --------------------------------------------------
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello, Sharat 👋",
                style: TextStyle(
                  fontSize: 27.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                "AI-powered job discovery",
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withValues(alpha: 0.65),
                ),
              ),
            ],
          ),
        ),

        SizedBox(width: 10.w),

        // --------------------------------------------------
        // NOTIFICATION
        // --------------------------------------------------
        SizedBox(
          width: 42.w,
          height: 42.w,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Center(
                child: Icon(
                  Icons.notifications_none_rounded,
                  size: 29.sp,
                  color: Colors.white,
                ),
              ),
              Positioned(
                top: 3.h,
                right: 4.w,
                child: Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: const BoxDecoration(
                    color: Colors.greenAccent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(width: 8.w),

        // --------------------------------------------------
        // PROFILE
        // --------------------------------------------------
        Container(
          width: 58.w,
          height: 58.w,
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFF3298FF),
              width: 2.w,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF3298FF).withValues(alpha: 0.40),
                blurRadius: 12.r,
                spreadRadius: 1.r,
              ),
            ],
          ),
          child: const ClipOval(
            child: CustomImage(
              path: Assets.imagesTrainer1,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              isProfile: true,
            ),
          ),
        ),
      ],
    );
  }
}
