import 'package:flutter/material.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';

class SelectRoomBedHeading extends StatelessWidget {
  const SelectRoomBedHeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Select Bed",
              style: Helper(context).textTheme.titleMedium?.copyWith(
                    fontSize: 16,
                    color: blackText3,
                  ),
            ),
            Row(
              children: [
                Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: greyText5,
                      ),
                      borderRadius: BorderRadius.circular(2)),
                ),
                sizedBoxWidth(width: 4),
                Text(
                  "FREE",
                  style: Helper(context).textTheme.labelLarge?.copyWith(
                        fontSize: 10,
                        color: greyText5,
                      ),
                ),
                sizedBoxWidth(width: 16),
                Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                    color: greyText5.withValues(alpha: 0.50),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                sizedBoxWidth(width: 4),
                Text(
                  "TAKEN",
                  style: Helper(context).textTheme.labelLarge?.copyWith(
                        fontSize: 10,
                        color: greyText5,
                      ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
