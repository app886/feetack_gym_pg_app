import 'package:get/get_connect/http/src/response/response.dart';
import 'package:vlr/data/api/api_client.dart';

class JobRepo {
  final ApiClient apiClient;

  JobRepo({required this.apiClient});

  Future<Response> getJobList() async {
    return await apiClient.getData("job-posts", "getJobList");
  }

  Future<Response> getJobDetails(int id) async {
    return await apiClient.getData("job-posts/$id", "getJobDetails");
  }

  Future<Response> shareReferral(Map<String, dynamic> data) async {
    return await apiClient.postData("shared-referrals", "shareReferral", data);
  }

  Future<Response> getJobDetailsByReferral(String referralCode) async {
    Response response = await apiClient.getData("hrms/shared-referrals/$referralCode", "getJobDetailsByReferral");
    if (response.statusCode != 200 && response.statusCode != 201) {
      response = await apiClient.getData("shared-referrals/$referralCode", "getJobDetailsByReferral");
    }
    return response;
  }

  Future<Response> applyJob(Map<String, dynamic> data) async {
    Response response = await apiClient.postData("hrms/job-applications", "applyJob", data);
    if (response.statusCode != 200 && response.statusCode != 201) {
      response = await apiClient.postData("job-applications", "applyJob", data);
    }
    return response;
  }
}
