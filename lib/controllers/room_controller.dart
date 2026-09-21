import 'package:get/get.dart';
import 'package:vlr/data/models/rooom/pg_floor_model.dart';
import 'package:vlr/data/models/rooom/pg_room_model.dart';
import 'package:vlr/data/repositories/room_repo.dart';

import 'package:vlr/controllers/home_controller.dart';

class RoomController extends GetxController implements GetxService {
  final RoomRepo roomRepo;

  RoomController({required this.roomRepo});

  bool isLoading = false;
  bool isAddFavorite = false;
  List<PgFloorModel> pgFloorModelList = [];
  List<PgRoomModel> pgRoomModelList = [];
  PgRoomModel? selectedRoomDetails;

  Future<void> fetchFloors(String listingId) async {
    print("RoomController: fetchFloors called for $listingId");
    isLoading = true;
    update();
    Response response = await roomRepo.getFloors(listingId);
    print("RoomController: fetchFloors response status: ${response.statusCode}");
    if (response.statusCode == 200 && response.body['status'] == 'success') {
      pgFloorModelList = [];
      response.body['data'].forEach((v) {
        pgFloorModelList.add(PgFloorModel.fromJson(v));
      });

      if (pgFloorModelList.isNotEmpty) {
        print("RoomController: Floors found, selecting first floor");
        pgFloorModelList[0].isSelect = true;
        fetchRooms(listingId, pgFloorModelList[0].id);
      } else {
        print("RoomController: No floors found in response");
      }
    } else {
      print("RoomController: fetchFloors failed or status not success");
    }
    isLoading = false;
    update();
  }

  Future<void> fetchRooms(String listingId, dynamic floorId) async {
    print("RoomController: fetchRooms called for floor $floorId");
    isLoading = true;
    update();
    Response response = await roomRepo.getRooms(listingId, floorId);
    print("RoomController: fetchRooms response status: ${response.statusCode}");
    if (response.statusCode == 200 && response.body['status'] == 'success') {
      pgRoomModelList = [];
      response.body['data'].forEach((v) {
        pgRoomModelList.add(PgRoomModel.fromJson(v));
      });
      print("RoomController: Fetched ${pgRoomModelList.length} rooms");
    }
    isLoading = false;
    update();
  }

  Future<void> fetchRoomDetails(String listingId, String roomId) async {
    isLoading = true;
    update();
    Response response = await roomRepo.getRoomDetails(listingId, roomId);
    print('API URL (fetchRoomDetails): ${response.request?.url}');
    print('API Response (fetchRoomDetails): ${response.body}');
    if (response.statusCode == 200 && response.body['status'] == 'success') {
      selectedRoomDetails = PgRoomModel.fromJson(response.body['data']);
    }
    isLoading = false;
    update();
  }

  void updateSelectPgFloor(PgFloorModel value, [String? listingId]) {
    for (var e in pgFloorModelList) {
      e.isSelect = e.id == value.id;
    }
    String? id = listingId ?? Get.find<HomeController>().selectListingModel?.id;
    if (id != null) {
      fetchRooms(id, value.id);
    }
    update();
  }

  void updateSelectPgRoomModel(PgRoomModel value) {
    for (var e in pgRoomModelList) {
      e.isSelect = e.id == value.id;
    }
    update();
  }
}
