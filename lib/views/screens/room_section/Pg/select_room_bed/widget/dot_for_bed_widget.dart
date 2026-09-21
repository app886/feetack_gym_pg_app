import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:vlr/controllers/room_controller.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';

class DotOfBedWidget extends StatelessWidget {
  final int shareTypeNo;
  final int bedLeft;
  final bool isSelect;

  const DotOfBedWidget({
    super.key,
    required this.shareTypeNo,
    required this.bedLeft,
    required this.isSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoomController>(
      builder: (roomController) {
        return SizedBox(
          height: 10,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: shareTypeNo,
            separatorBuilder: (_, __) => sizedBoxWidth(width: 4),
            itemBuilder: (context, index) {
              // last bedLeft circles red
              bool availableBed = index >= shareTypeNo - bedLeft;

              return CircleAvatar(
                radius: 4,
                backgroundColor: bedLeft == 0
                    ? (isSelect ? white : redDark)
                    : isSelect
                        ? availableBed
                            ? greyLight1
                            : white
                        : availableBed
                            ? blueLight3.withValues(alpha: 0.30)
                            : blueLight3,
              );
            },
          ),
        );
      },
    );
  }
}
