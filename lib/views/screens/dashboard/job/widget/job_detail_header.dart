import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vlr/controllers/job_controller.dart';
import 'package:vlr/data/models/job_post_model.dart';
import 'package:vlr/data/models/job_detail_model.dart';
import 'package:vlr/services/appsflyer_service.dart';

class JobDetailHeader extends StatelessWidget {
  final JobPostModel job;
  final JobDetailData? detailData;

  const JobDetailHeader({
    super.key,
    required this.job,
    this.detailData,
  });

  void _shareJob(BuildContext context) async {
    final jobId = detailData?.id ?? job.id;
    final jobTitle = detailData?.header?.jobTitle ?? job.jobTitle ?? "Job";
    final companyName = detailData?.header?.companyName ?? job.department?.name;

    if (jobId == null) return;

    final jobController = Get.find<JobController>();

    // Generate Feetrack + 9 random digits (e.g., Feetrack145874526)
    final random = Random();
    final digits = List.generate(9, (_) => random.nextInt(10)).join();
    final referralCode = 'Feetrack$digits';

    // Show loading indicator while generating link
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Generating share link...'),
        duration: Duration(seconds: 1),
      ),
    );

    // Hit the referral API
    bool success = await jobController.shareReferral(
      postId: jobId,
      referralCode: referralCode,
    );

    if (success) {
      // Generate AppsFlyer OneLink for this job
      final shareUrl = await AppsFlyerService.generateJobShareLink(
        jobId: jobId,
        jobTitle: jobTitle,
        companyName: companyName,
        referralCode: referralCode,
      );

      if (shareUrl != null) {
        Share.share(
          "Check out this job: $jobTitle\nCompany: $companyName\n\nUse my referral code: $referralCode\n\nApply here: $shareUrl",
          subject: "Job Opportunity: $jobTitle",
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to generate referral link. Please try again.')),
      );
    }
  }

  void _showFullImage(BuildContext context, String url) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(12.w),
        child: Stack(
          alignment: Alignment.center,
          children: [
            InteractiveViewer(
              panEnabled: true,
              minScale: 0.5,
              maxScale: 4.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Image.network(
                  url,
                  fit: BoxFit.contain,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator(color: Colors.white));
                  },
                ),
              ),
            ),
            Positioned(
              top: 10.h,
              right: 10.w,
              child: CircleAvatar(
                backgroundColor: Colors.black.withValues(alpha: 0.5),
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Determine which data to show
    final title = detailData?.header?.jobTitle ?? job.jobTitle ?? "N/A";
    final company = detailData?.header?.companyName ?? job.department?.name ?? "Company";
    final type = detailData?.header?.employmentType ?? job.employmentType ?? "Full Time";
    final location = detailData?.header?.location ?? job.branch?.name ?? "Lucknow";
    final applicants = detailData?.header?.applicantsCount ?? 0;
    final bannerUrl = detailData?.bannerUrl ?? job.bannerUrl;

    return Stack(
      children: [
        // 1. Dark Gradient Top Background (Matching App Design)
        Container(
          height: 240.h,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF061A49),
                Color(0xFF03143A),
                Color(0xFF02112F),
              ],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35.r),
              bottomRight: Radius.circular(35.r),
            ),
          ),
        ),

        // 2. Navigation & Title Section
        Column(
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top + 5.h),
            
            // Back & Share/Actions Row
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => _shareJob(context),
                        icon: Icon(
                          Icons.share_outlined,
                          color: Colors.white,
                          size: 22.sp,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.more_vert_rounded,
                          color: Colors.white,
                          size: 24.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 10.h),

            // Logo & Main Title inside a Card to create depth
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  )
                ],
              ),
              child: Column(
                children: [
                  // Company Logo
                  GestureDetector(
                    onTap: () {
                      if (bannerUrl != null && bannerUrl.isNotEmpty) {
                        _showFullImage(context, bannerUrl);
                      }
                    },
                    child: Container(
                      width: 70.w,
                      height: 70.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F4F7),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: const Color(0xFFEAECF0), width: 1.w),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: bannerUrl != null
                            ? Image.network(bannerUrl, fit: BoxFit.cover)
                            : Center(
                                child: Text(
                                  title.isNotEmpty ? title[0] : "J",
                                  style: TextStyle(
                                    fontSize: 28.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF1554C0),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Job Title
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF101828),
                      height: 1.2,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  // Company & Job Type
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        company,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF667085),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Icon(Icons.circle, size: 4.sp, color: const Color(0xFFD0D5DD)),
                      ),
                      Text(
                        type,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFFA6A48),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  // Location & Applicants Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildMiniBadge(Icons.location_on_outlined, location, const Color(0xFF10B981)),
                      SizedBox(width: 12.w),
                      _buildMiniBadge(Icons.people_alt_outlined, "$applicants Applicants", const Color(0xFF3B82F6)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMiniBadge(IconData icon, String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: color),
          SizedBox(width: 6.w),
          Flexible(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

