import 'dart:developer';
import 'package:get/get.dart';
import 'package:vlr/data/models/job_post_model.dart';
import 'package:vlr/data/models/job_detail_model.dart';
import 'package:vlr/data/repositories/job_repo.dart';

class JobController extends GetxController implements GetxService {
  final JobRepo jobRepo;
  JobController({required this.jobRepo});

  bool isLoading = false;
  List<JobPostModel> jobList = [];
  JobDetailData? selectedJob;

  Future<void> getJobList() async {
    isLoading = true;
    update();
    try {
      Response response = await jobRepo.getJobList();
      if (response.statusCode == 200 && response.body != null) {
        if (response.body['success'] == true) {
          var rawData = response.body['data'];
          List items = [];
          if (rawData is List) {
            items = rawData;
          } else if (rawData is Map && rawData['data'] is List) {
            items = rawData['data'];
          }
          jobList = items.map((e) => JobPostModel.fromJson(e)).toList();
        }
      }
    } catch (e) {
      log("Error fetching jobs in JobController: $e");
    }
    isLoading = false;
    update();
  }

  Future<void> getJobDetails(int id) async {
    selectedJob = null;
    isLoading = true;
    update();
    try {
      Response response = await jobRepo.getJobDetails(id);
      if (response.statusCode == 200 && response.body != null) {
        if (response.body['success'] == true) {
          selectedJob = JobDetailData.fromJson(response.body['data']);
        }
      }
    } catch (e) {
      log("Error fetching job details in JobController: $e");
    }
    isLoading = false;
    update();
  }

  Future<bool> shareReferral({required int postId, required String referralCode}) async {
    try {
      Map<String, dynamic> data = {
        "post_id": postId,
        "referral_code": referralCode,
      };

      Response response = await jobRepo.shareReferral(data);
      if ((response.statusCode == 200 || response.statusCode == 201) && response.body != null) {
        if (response.body['success'] == true || response.body['status'] == "success") {
          return true;
        }
      }
    } catch (e) {
      log("Error sharing referral in JobController: $e");
    }
    return false;
  }
}
