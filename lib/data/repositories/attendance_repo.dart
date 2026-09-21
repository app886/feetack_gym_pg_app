import 'package:get/get_connect/http/src/response/response.dart';
import 'package:vlr/data/api/api_client.dart';
import 'package:vlr/services/constants.dart';

class AttendanceRepo {
  final ApiClient apiClient;

  AttendanceRepo({required this.apiClient});

  Future<Response> punchIn(Map<String, dynamic> data) async {
    return await apiClient.postData(AppConstants.punchInUri, "punchIn", data);
  }

  Future<Response> punchOut(Map<String, dynamic> data) async {
    return await apiClient.postData(AppConstants.punchOutUri, "punchOut", data);
  }

  Future<Response> getTodayAttendance() async {
    return await apiClient.getData(AppConstants.todayAttendanceUri, "getTodayAttendance");
  }

  Future<Response> getAttendanceHistory(Map<String, dynamic> data) async {
    return await apiClient.getData(AppConstants.attendanceHistoryUri, "getAttendanceHistory", query: data);
  }

  Future<Response> getBookings() async {
    return await apiClient.getData("bookings", "getBookings");
  }
}
