import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/room_controller.dart';
import 'package:vlr/data/models/rooom/pg_room_model.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/screens/room_section/Pg/select_room_bed/widget/room_widget.dart';

class SelectPgRoom extends StatelessWidget {
  const SelectPgRoom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Room",
          style: Helper(context).textTheme.titleMedium?.copyWith(
                fontSize: 16,
                color: blackText3,
              ),
        ),
        sizedBoxHeight(height: 16),
        GetBuilder<RoomController>(builder: (roomController) {
          return SizedBox(
            height: 112,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                PgRoomModel pgRoomModel =
                    roomController.pgRoomModelList[index];
                return GestureDetector(
                  onTap: () {
                    if (roomController.isLoading) {
                      return;
                    }
                    roomController.updateSelectPgRoomModel(pgRoomModel);
                  },
                  child: RoomWidget(
                    pgRoomModel: pgRoomModel,
                  ),
                );
              },
              separatorBuilder: (_, __) => sizedBoxWidth(width: 16),
              itemCount: roomController.pgRoomModelList.length,
            ),
          );
        }),
      ],
    );
  }
}
