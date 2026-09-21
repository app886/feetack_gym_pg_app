import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/screens/dashboard/job/widget/ai_top_section.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/controllers/job_controller.dart';
import 'package:vlr/data/models/job_post_model.dart';
import 'job_detail_screen.dart';

class JobScreen extends StatelessWidget {
  const JobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initiate API fetching via Controller when screen is built
    final JobController jobController = Get.find<JobController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      jobController.getJobList();
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // AI top section
              const AiTopSection(),

              SizedBox(height: 20.h),

              // Job content starts here
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      "Top AI Matches",
                    ),

                    SizedBox(height: 12.h),

                    // GetBuilder binds live data updates from the newly integrated api
                    GetBuilder<JobController>(
                      builder: (controller) {
                        if (controller.isLoading) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 40),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        if (controller.jobList.isEmpty) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 40),
                              child: Text(
                                "No active job listings found",
                                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
                              ),
                            ),
                          );
                        }

                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.jobList.length,
                          separatorBuilder: (context, index) => SizedBox(height: 12.h),
                          itemBuilder: (context, index) {
                            JobPostModel job = controller.jobList[index];
                            return _jobCard(
                              context: context,
                              job: job,
                            );
                          },
                        );
                      },
                    ),

                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _jobCard({
    required BuildContext context,
    required JobPostModel job,
  }) {
    return GestureDetector(
      onTap: () {
        navigate(
          context: context,
          page: JobDetailScreen(job: job),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0xFFE5E7EB),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10.r,
              offset: Offset(0, 3.h),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 52.w,
              height: 52.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFF1554C0),
                borderRadius: BorderRadius.circular(14.r),
                image: job.bannerUrl != null
                    ? DecorationImage(
                        image: NetworkImage(job.bannerUrl!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: job.bannerUrl == null
                  ? Text(
                      job.jobTitle != null && job.jobTitle!.isNotEmpty ? job.jobTitle![0] : "J",
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    )
                  : null,
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.jobTitle ?? "N/A",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF101828),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    job.department?.name ?? "Main Org",
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: const Color(0xFF667085),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 15.sp,
                        color: const Color(0xFF98A2B3),
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Text(
                          job.branch?.name ?? "Lucknow",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xFF667085),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  job.salary ?? "N/A",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF16803C),
                  ),
                ),
                SizedBox(height: 6.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 5.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F7EE),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    job.status?.toUpperCase() ?? "ACTIVE",
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF16803C),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
