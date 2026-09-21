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
}
