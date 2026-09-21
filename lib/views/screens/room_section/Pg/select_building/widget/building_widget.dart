import 'package:flutter/material.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';

class BuildingWidget extends StatelessWidget {
  final bool isSelect;
  const BuildingWidget({
    super.key,
    required this.isSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 32, 18),
      decoration: BoxDecoration(
        color: isSelect ? blueLight5 : white,
        border: Border.all(width: 2, color: isSelect ? blueLight3 : greyLight6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: whiteSmoke,
            radius: 20,
            child: Icon(
              Icons.apartment_outlined,
              color: greyDart2,
            ),
          ),
          sizedBoxHeight(height: 12),
          Text(
            "Building A",
            style: Helper(context).textTheme.titleMedium?.copyWith(
                  fontSize: 16,
                  color: blackText3,
                ),
          ),
          Text(
            "Heritage Wing",
            style: Helper(context).textTheme.bodySmall?.copyWith(
                  fontSize: 16,
                  color: greyDart,
                ),
          ),
        ],
      ),
    );
  }
}
