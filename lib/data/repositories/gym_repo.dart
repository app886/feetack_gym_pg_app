import 'package:get/get.dart';
import 'package:vlr/data/api/api_client.dart';
import 'package:vlr/services/constants.dart';

class GymRepo {
  final ApiClient apiClient;

  GymRepo({required this.apiClient});

  Future<Response> fetchGymTrainers({required String id}) async =>
      await apiClient.getData(
        AppConstants.gymStaff(id: id),
        "fetchGymTrainers",
      );
}
