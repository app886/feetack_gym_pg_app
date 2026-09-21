import 'package:flutter/material.dart';
import 'package:vlr/data/models/rooom/pg_room_model.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/screens/room_section/Pg/select_room_bed/widget/dot_for_bed_widget.dart';

class RoomWidget extends StatelessWidget {
  final PgRoomModel pgRoomModel;
  const RoomWidget({
    super.key,
    required this.pgRoomModel,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: pgRoomModel.isSelect ? 1.02 : 1,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width / 3.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: pgRoomModel.isSelect ? primaryColor : white,
          border: Border.all(
            width: 1,
            color: pgRoomModel.isSelect ? blueLight3 : greyLight6,
          ),
          boxShadow: [
            BoxShadow(
              color: pgRoomModel.isSelect
                  ? primaryColor.withValues(alpha: 0.18)
                  : black.withValues(alpha: 0.04),
              blurRadius: pgRoomModel.isSelect ? 18 : 8,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              style: Helper(context).textTheme.titleMedium?.copyWith(
                    fontSize: 16,
                    color: pgRoomModel.isSelect ? white : blackText3,
                  ) ??
                  const TextStyle(),
              child: Text(pgRoomModel.roomNo ?? ""),
            ),
            sizedBoxHeight(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              style: Helper(context).textTheme.labelLarge?.copyWith(
                    fontSize: 16,
                    color: pgRoomModel.isSelect ? blueLight6 : greyDart2,
                  ) ??
                  const TextStyle(),
              child: Text(
                pgRoomModel.bedLeftNo == 0
                    ? "Full"
                    : "${pgRoomModel.bedLeftNo} Bed Left",
              ),
            ),
            sizedBoxHeight(height: 16),
            DotOfBedWidget(
              shareTypeNo: pgRoomModel.shareType ?? 0,
              bedLeft: pgRoomModel.bedLeftNo ?? 0,
              isSelect: pgRoomModel.isSelect,
            )
          ],
        ),
      ),
    );
  }
}
