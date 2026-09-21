import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/home_controller.dart';
import 'package:vlr/controllers/room_controller.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/screens/room_section/rooms_floor/widget/floor_sidebar_item.dart';
import 'package:vlr/views/screens/room_section/rooms_floor/widget/room_card.dart';
import 'package:vlr/views/screens/room_section/room/room_profile_screen/room_profile_screen.dart';

class RoomsAndFloorScreen extends StatefulWidget {
  const RoomsAndFloorScreen({super.key});

  @override
  State<RoomsAndFloorScreen> createState() => _RoomsAndFloorScreenState();
}

class _RoomsAndFloorScreenState extends State<RoomsAndFloorScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final listingId = Get.find<HomeController>().selectListingModel?.id;
      if (listingId != null) {
        Get.find<RoomController>().fetchFloors(listingId.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Select Floor & Room",
          style: Helper(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        ),
      ),
      bottomNavigationBar: GetBuilder<RoomController>(
        builder: (controller) {
          final selectedRoom = controller.pgRoomModelList.firstWhereOrNull((e) => e.isSelect);
          final bool isEnabled = selectedRoom != null;

          return Container(
            padding: EdgeInsets.fromLTRB(16, 12, 16, MediaQuery.of(context).padding.bottom + 12),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Color(0xFFE0E0E0))),
              boxShadow: [
                BoxShadow(color: Color(0x1A000000), blurRadius: 12, offset: Offset(0, -4))
              ],
            ),
            child: GestureDetector(
              onTap: !isEnabled
                  ? null
                  : () {
                      final listingId = Get.find<HomeController>().selectListingModel?.id;
                      if (listingId != null && selectedRoom.id != null) {
                        controller.fetchRoomDetails(listingId.toString(), selectedRoom.id!);
                        navigate(context: context, page: const RoomProfileScreen());
                      }
                    },
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  color: isEnabled ? const Color(0xFF022C7F) : Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: !isEnabled
                      ? null
                      : [
                          BoxShadow(
                            color: const Color(0xFF022C7F).withValues(alpha: 0.35),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          )
                        ],
                ),
                child: Center(
                  child: Text(
                    isEnabled ? "Continue with Room ${selectedRoom.roomNumber}" : "Select a Room",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: isEnabled ? Colors.white : Colors.grey[600],
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      body: GetBuilder<RoomController>(
        builder: (controller) {
          if (controller.isLoading && controller.pgFloorModelList.isEmpty) {
            return const Center(child: CircularProgressIndicator(color: primaryColor));
          }

          if (controller.pgFloorModelList.isEmpty && !controller.isLoading) {
            return const Center(child: Text("No floors available for this listing"));
          }

          return Row(
            children: [
              // Sidebar for Floors
              Container(
                width: 90,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  border: Border(
                    right: BorderSide(color: Colors.grey[200]!, width: 1),
                  ),
                ),
                child: ListView.separated(
                  itemCount: controller.pgFloorModelList.length,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    // Reverse the display order so ground floor is at the bottom
                    final floor = controller.pgFloorModelList[controller.pgFloorModelList.length - 1 - index];
                    return FloorSidebarItem(
                      floor: floor,
                      onTap: () {
                        controller.updateSelectPgFloor(floor);
                      },
                    );
                  },
                ),
              ),

              // Main area for Rooms
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Text(
                        "${controller.pgFloorModelList.firstWhereOrNull((e) => e.isSelect)?.name ?? 'Rooms'}",
                        style: Helper(context).textTheme.titleSmall?.copyWith(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    Expanded(
                      child: controller.isLoading
                          ? const Center(child: CircularProgressIndicator(color: primaryColor))
                          : controller.pgRoomModelList.isEmpty
                              ? const Center(child: Text("No rooms on this floor"))
                              : ListView.builder(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  itemCount: controller.pgRoomModelList.length,
                                  itemBuilder: (context, index) {
                                    final room = controller.pgRoomModelList[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 16),
                                      child: RoomCard(
                                        room: room,
                                        onTap: () {
                                          controller.updateSelectPgRoomModel(room);
                                          // Handle room selection / navigation
                                        },
                                      ),
                                    );
                                  },
                                ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
