import 'dart:developer';

import 'package:get/get.dart';
import 'package:vlr/data/models/response/response_model.dart';
import 'package:vlr/data/models/visit_model.dart';
import 'package:vlr/data/repositories/visit_repo.dart';

class VisitController extends GetxController implements GetxService {
  final VisitRepo visitRepo;

  VisitController({required this.visitRepo});

  bool isLoading = false;

  List<VisitModel> visitList = [];
  int currentPage = 1;
  int lastPage = 1;
  bool isPaginating = false;

  VisitModel? selectedVisit;

  Future<ResponseModel> createVisit({
    required String listingId,
    required String visitDate,
    required String visitTime,
    String? note,
  }) async {
    log('-----------  createVisit ----------');

    ResponseModel responseModel;
    isLoading = true;
    selectedVisit = null;
    update();

    try {
      final Map<String, dynamic> data = {
        "listing_id": listingId,
        "visit_date": visitDate,
        "visit_time": visitTime,
        if (note != null && note.isNotEmpty) "note": note,
      };

      Response response = await visitRepo.createVisit(data: data);

      if (response.body['status'] == "success") {
        responseModel = ResponseModel(
            true, response.body['message'] ?? "Visit booked successfully");
      } else {
        responseModel = ResponseModel(false,
            response.body['message'] ?? "Error while booking visit");
      }
    } catch (e) {
      log('ERROR AT createVisit(): $e');
      responseModel = ResponseModel(false, "Error while booking visit $e");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> fetchVisits({bool isLoadMore = false}) async {
    log('-----------  fetchVisits ----------');

    if (isLoadMore) {
      if (currentPage >= lastPage) {
        return ResponseModel(false, "No more visits");
      }
      isPaginating = true;
      currentPage++;
      update();
    } else {
      isLoading = true;
      currentPage = 1;
      visitList.clear();
      update();
    }

    ResponseModel responseModel;

    try {
      Response response = await visitRepo.fetchVisits(page: currentPage);

      if (response.body['status'] == "success") {
        final data = response.body['data'];
        final List visitsJson = data['data'] ?? [];
        
        if (isLoadMore) {
          visitList.addAll(visitsJson.map((e) => VisitModel.fromJson(e)).toList());
        } else {
          visitList = visitsJson.map((e) => VisitModel.fromJson(e)).toList();
        }
        
        lastPage = data['last_page'] ?? 1;

        responseModel = ResponseModel(
            true, response.body['message'] ?? "Fetched visits successfully");
      } else {
        if (isLoadMore) currentPage--;
        responseModel = ResponseModel(false,
            response.body['message'] ?? "Error while fetching visits");
      }
    } catch (e) {
      log('ERROR AT fetchVisits(): $e');
      if (isLoadMore) currentPage--;
      responseModel = ResponseModel(false, "Error while fetching visits $e");
    }

    isLoading = false;
    isPaginating = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> fetchVisitDetail({required String id}) async {
    log('-----------  fetchVisitDetail ----------');

    ResponseModel responseModel;
    isLoading = true;
    selectedVisit = null;
    update();

    try {
      Response response = await visitRepo.fetchVisitDetail(id: id);

      if (response.body['status'] == "success") {
        selectedVisit = VisitModel.fromJson(response.body['data']);
        responseModel = ResponseModel(
            true, response.body['message'] ?? "Fetched visit detail successfully");
      } else {
        responseModel = ResponseModel(false,
            response.body['message'] ?? "Error while fetching visit detail");
      }
    } catch (e) {
      log('ERROR AT fetchVisitDetail(): $e');
      responseModel = ResponseModel(false, "Error while fetching visit detail $e");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> cancelVisit({required String id}) async {
    log('-----------  cancelVisit ----------');

    ResponseModel responseModel;
    isLoading = true;
    selectedVisit = null;
    update();

    try {
      Response response = await visitRepo.cancelVisit(id: id);

      if (response.body['status'] == "success") {
        responseModel = ResponseModel(
            true, response.body['message'] ?? "Visit cancelled successfully");
            
        // Remove from list if exists
        visitList.removeWhere((element) => element.id == id);
      } else {
        responseModel = ResponseModel(false,
            response.body['message'] ?? "Error while cancelling visit");
      }
    } catch (e) {
      log('ERROR AT cancelVisit(): $e');
      responseModel = ResponseModel(false, "Error while cancelling visit $e");
    }

    isLoading = false;
    update();
    return responseModel;
  }
}
