import 'package:vlr/data/api/api_client.dart';
import 'package:vlr/services/constants.dart';
import 'package:get/get.dart';

class RoomRepo {
  final ApiClient apiClient;

  RoomRepo({required this.apiClient});

  Future<Response> getFloors(String listingId) async {
    print("RoomRepo: getFloors called for $listingId");
    Response response = await apiClient.getData(AppConstants.getFloors(id: listingId), "getFloors");
    print("RoomRepo: getFloors URL: ${AppConstants.baseUrl}${AppConstants.getFloors(id: listingId)}");
    print("RoomRepo: getFloors Response status: ${response.statusCode}");
    return response;
  }

  Future<Response> getRooms(String listingId, dynamic floorId) async {
    print("RoomRepo: getRooms called for listing $listingId and floor $floorId");
    Response response = await apiClient.getData(AppConstants.getRooms(id: listingId, floorId: floorId), "getRooms");
    print("RoomRepo: getRooms URL: ${AppConstants.baseUrl}${AppConstants.getRooms(id: listingId, floorId: floorId)}");
    print("RoomRepo: getRooms Response status: ${response.statusCode}");
    return response;
  }

  Future<Response> getRoomDetails(String listingId, String roomId) async {
    print("RoomRepo: getRoomDetails called for listing $listingId and room $roomId");
    Response response = await apiClient.getData(AppConstants.getRoomDetails(id: listingId, roomId: roomId), "getRoomDetails");
    print("RoomRepo: getRoomDetails URL: ${AppConstants.baseUrl}${AppConstants.getRoomDetails(id: listingId, roomId: roomId)}");
    print("RoomRepo: getRoomDetails Response status: ${response.statusCode}");
    return response;
  }
}
