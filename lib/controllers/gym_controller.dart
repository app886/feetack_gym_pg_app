import 'dart:developer';

import 'package:get/get.dart';
import 'package:vlr/data/models/category_model/staff_model.dart';
import 'package:vlr/data/models/gym_profile_banner_model.dart';
import 'package:vlr/data/models/response/response_model.dart';
import 'package:vlr/data/repositories/gym_repo.dart';
import 'package:vlr/generated/assets.dart';
import 'package:vlr/services/constants.dart';

class GymController extends GetxController implements GetxService {
  final GymRepo gymRepo;

  GymController({required this.gymRepo});

  bool isLoading = false;

  List<BannerModel> gymProfileImageSliders = [
    BannerModel(
      image: Assets.imagesGymBanner,
    ),
    BannerModel(
      image: Assets.imagesGymBanner,
    ),
    BannerModel(
      image: Assets.imagesGymBanner,
    ),
  ];

  bool isGYMSubscription = false;

  List<StaffModel> gymTrainerModelList = [];
  StaffModel? selectGymTrainerModel;

  Future<ResponseModel> fetchGymTrainers({required String listingId}) async {
    log('-----------  fetchGymTrainers ----------');
    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Response response = await gymRepo.fetchGymTrainers(id: listingId);

      if (response.body != null && response.body['status'] == "success") {
        var data = response.body['data'];
        if (data is List) {
          gymTrainerModelList = data.map((e) => StaffModel.fromJson(e)).toList();
        } else if (data is Map && data['data'] is List) {
          gymTrainerModelList = (data['data'] as List)
              .map((e) => StaffModel.fromJson(e))
              .toList();
        } else {
          gymTrainerModelList = [];
        }

        responseModel = ResponseModel(
            true, response.body['message'] ?? "success fetchGymTrainers");
      } else {
        gymTrainerModelList = [];
        responseModel = ResponseModel(false,
            response.body?['message'] ?? "Error while fetchGymTrainers");
      }
    } catch (e) {
      gymTrainerModelList = [];
      log('ERROR AT fetchGymTrainers(): $e');
      responseModel = ResponseModel(false, "Error while fetchGymTrainers $e");
    }

    isLoading = false;
    update();
    return responseModel;
  }
}
