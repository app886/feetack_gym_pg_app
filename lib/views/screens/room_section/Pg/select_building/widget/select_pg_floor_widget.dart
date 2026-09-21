import 'package:flutter/material.dart';
import 'package:vlr/data/models/rooom/pg_floor_model.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';

class SelectPgFloor extends StatelessWidget {
  final PgFloorModel? pgFloorModel;
  const SelectPgFloor({
    super.key,
    required this.pgFloorModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: (pgFloorModel?.isSelect ?? false) ? primaryColor : pinLight,
        border: Border.all(
          width: 1,
          color: (pgFloorModel?.isSelect ?? false) ? blueLight3 : greyLight6,
        ),
        boxShadow: (pgFloorModel?.isSelect ?? false)
            ? [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 6,
                  spreadRadius: -4,
                  color: black.withValues(alpha: 0.10),
                ),
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 15,
                  spreadRadius: -3,
                  color: black.withValues(alpha: 0.10),
                ),
              ]
            : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            pgFloorModel?.floorNo ?? "",
            style: Helper(context).textTheme.bodySmall?.copyWith(
                  fontSize: 16,
                  color: (pgFloorModel?.isSelect ?? false) ? white : blackText3,
                ),
          ),
          sizedBoxHeight(height: 4),
          Text(
            pgFloorModel?.floorName ?? "",
            style: Helper(context).textTheme.titleMedium?.copyWith(
                  fontSize: 16,
                  color: (pgFloorModel?.isSelect ?? false) ? white : blackText3,
                ),
          ),
        ],
      ),
    );
  }
}
