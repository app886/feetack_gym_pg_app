import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/job_controller.dart';
import 'package:vlr/data/models/job_post_model.dart';
import 'widget/job_detail_header.dart';
import 'widget/job_detail_tabs.dart';
import 'widget/job_detail_content.dart';
import 'widget/job_detail_bottom_bar.dart';

class JobDetailScreen extends StatefulWidget {
  final JobPostModel job;

  const JobDetailScreen({
    super.key,
    required this.job,
  });

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> {
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    // Fetch fresh details from API using the job ID
    if (widget.job.id != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.find<JobController>().getJobDetails(widget.job.id!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FC), // High-end app background
      body: GetBuilder<JobController>(
        builder: (jobController) {
          return Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Top Header Section (Gradient + Logo + Basic info)
                          JobDetailHeader(
                            job: widget.job,
                            detailData: jobController.selectedJob,
                          ),
                          
                          // Tab Bar Selection - styled as a floating bar or pinned section
                          Container(
                            margin: EdgeInsets.only(top: 12.h),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: JobDetailTabs(
                              selectedIndex: _currentTabIndex,
                              onTabChanged: (index) {
                                setState(() {
                                  _currentTabIndex = index;
                                });
                              },
                            ),
                          ),
                          
                          // Show loader if fetching fresh details
                          if (jobController.isLoading && jobController.selectedJob == null)
                            Container(
                              height: 300.h,
                              alignment: Alignment.center,
                              child: const CircularProgressIndicator(),
                            )
                          else
                            JobDetailContent(
                              selectedIndex: _currentTabIndex,
                              job: widget.job,
                              detailData: jobController.selectedJob,
                            ),
                          
                          SizedBox(height: 100.h), // Spacing for sticky bottom bar
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
      // Sticky bottom section
      bottomNavigationBar: const JobDetailBottomBar(),
    );
  }
}
