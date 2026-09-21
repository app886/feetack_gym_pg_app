import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vlr/data/models/job_post_model.dart';
import 'package:vlr/data/models/job_detail_model.dart';

class JobDetailContent extends StatelessWidget {
  final int selectedIndex;
  final JobPostModel job;
  final JobDetailData? detailData;

  const JobDetailContent({
    super.key,
    required this.selectedIndex,
    required this.job,
    this.detailData,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedIndex == 1) {
      return _buildCompanyTab();
    }
    return _buildJobDetailTab();
  }

  Widget _buildJobDetailTab() {
    // Map data from detailData if available, else from job (from list)
    final overview = detailData?.jobDetail?.overview;
    final salary = overview?.salary ?? job.salary ?? "N/A";
    final type = overview?.type ?? job.employmentType ?? "Full Time";
    final workMode = overview?.workMode ?? job.creator?.workingMode ?? "Office";
    final level = overview?.level ?? job.experience ?? "N/A";
    final descriptions = detailData?.jobDetail?.descriptions ?? job.jobDescription ?? "No description available.";

    List<String> skillList = detailData?.jobDetail?.skills ?? [];
    if (skillList.isEmpty && job.skills != null && job.skills!.isNotEmpty) {
      skillList = job.skills!.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    }
    if (skillList.isEmpty) skillList = ["General Skill"];

    List<String> responsibilityList = detailData?.jobDetail?.responsibilities ?? [];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Job Overview Card
          _sectionTitle("Job Overview"),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4)),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    _buildOverviewItem(Icons.payments_outlined, "Salary", salary, const Color(0xFF16803C)),
                    SizedBox(width: 20.w),
                    _buildOverviewItem(Icons.work_outline_rounded, "Type", type, const Color(0xFFFA6A48)),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    _buildOverviewItem(Icons.home_work_outlined, "Work Mode", workMode, const Color(0xFF3B82F6)),
                    SizedBox(width: 20.w),
                    _buildOverviewItem(Icons.history_toggle_off_rounded, "Experience", level, const Color(0xFF6366F1)),
                  ],
                ),
              ],
            ),
          ),
          
          SizedBox(height: 24.h),

          // 2. Descriptions Card
          _sectionTitle("Descriptions"),
          SizedBox(height: 12.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4)),
              ],
            ),
            child: Text(
              descriptions,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF475467),
                height: 1.6,
              ),
            ),
          ),

          SizedBox(height: 24.h),

          // 3. Skills Required
          _sectionTitle("Skills Required"),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: skillList.map((skill) => _buildSkillChip(skill)).toList(),
          ),

          if (responsibilityList.isNotEmpty) ...[
            SizedBox(height: 24.h),
            _sectionTitle("Responsibilities"),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                children: responsibilityList.map((res) => Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: _buildBulletPoint(res),
                )).toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w800,
        color: const Color(0xFF101828),
      ),
    );
  }

  Widget _buildJobDetailTabOriginal() {
    // Keeping a copy of the original just in case, but replaced by the card-based layout above.
    return Container(); 
  }

  Widget _buildCompanyTab() {
    final companyName = detailData?.companyDetail?.companyName ?? job.department?.name ?? "Company";
    final website = detailData?.companyDetail?.details?.website ?? "www.company.com";
    final headquarters = detailData?.companyDetail?.details?.headquarters ?? job.branch?.name ?? "Lucknow";
    final bannerUrl = detailData?.bannerUrl ?? job.bannerUrl;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Company Card
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 56.w,
                      height: 56.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1554C0),
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: bannerUrl != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(14.r),
                              child: Image.network(bannerUrl, fit: BoxFit.cover),
                            )
                          : Icon(Icons.business_rounded, color: Colors.white, size: 30.sp),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            companyName,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF101828),
                            ),
                          ),
                          Text(
                            "Industry: Recruitment",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: const Color(0xFF667085),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const Divider(height: 32, color: Color(0xFFF2F4F7)),

                _sectionTitle("About Company"),
                SizedBox(height: 10.h),
                Text(
                  "Detailed company profile and culture overview for $companyName. Providing top-tier services in their field.",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF475467),
                    height: 1.6,
                  ),
                ),

                SizedBox(height: 24.h),

                _sectionTitle("Details"),
                SizedBox(height: 16.h),
                _buildCompanyDetailRow("Website", website),
                _buildCompanyDetailRow("Headquarters", headquarters),
                _buildCompanyDetailRow("Job Code", job.jobCode ?? "N/A"),
                _buildCompanyDetailRow("Status", "Active"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewItem(IconData icon, String label, String value, Color color) {
    return Expanded(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: color, size: 22.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600, color: const Color(0xFF98A2B3)),
                ),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700, color: const Color(0xFF344054)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFEAECF0)),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700, color: const Color(0xFF475467)),
      ),
    );
  }

  Widget _buildCompanyDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 14.sp, color: const Color(0xFF667085))),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: const Color(0xFF101828)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 6.h, right: 10.w),
          child: Container(
            width: 5.w,
            height: 5.w,
            decoration: const BoxDecoration(
              color: Color(0xFF475467),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF475467),
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
