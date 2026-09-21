import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobDetailBottomBar extends StatefulWidget {
  const JobDetailBottomBar({super.key});

  @override
  State<JobDetailBottomBar> createState() => _JobDetailBottomBarState();
}

class _JobDetailBottomBarState extends State<JobDetailBottomBar> {
  bool _isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 24.w,
        right: 24.w,
        top: 16.h,
        bottom: 24.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10.r,
            offset: Offset(0, -5.h),
          ),
        ],
      ),
      child: Row(
        children: [
          // Bookmark Button
          GestureDetector(
            onTap: () {
              setState(() {
                _isBookmarked = !_isBookmarked;
              });
            },
            child: Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: const Color(0xFFEAECF0),
                  width: 1.5.w,
                ),
              ),
              child: Icon(
                _isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                color: _isBookmarked ? const Color(0xFFFA6A48) : const Color(0xFF475467),
                size: 24.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          // Apply Now Button
          Expanded(
            child: GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Application Submitted Successfully!'),
                    backgroundColor: Color(0xFFFA6A48),
                  ),
                );
              },
              child: Container(
                height: 56.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFFA6A48), // Coral Orange
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFA6A48).withValues(alpha: 0.2),
                      blurRadius: 8.r,
                      offset: Offset(0, 4.h),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  "APPLY NOW",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
