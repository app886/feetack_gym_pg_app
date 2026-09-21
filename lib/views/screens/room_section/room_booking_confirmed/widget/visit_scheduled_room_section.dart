import 'package:flutter/material.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/base/custom_image.dart';

class VisitScheduledRoomSection extends StatelessWidget {
  const VisitScheduledRoomSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const CustomImage(
            path: Assets.imagesVisitSuccess,
            height: 104,
            width: 80,
            fit: BoxFit.cover,
          ),
          Text(
            "Visit Scheduled!",
            style: Helper(context).textTheme.titleMedium?.copyWith(
                  fontSize: 32,
                  color: blackText3,
                ),
          ),
          sizedBoxHeight(height: 8),
          Text(
            "Your appointment for Urban Oasis Suite has been successfully booked.",
            textAlign: TextAlign.center,
            style: Helper(context).textTheme.bodySmall?.copyWith(
                  fontSize: 18,
                  color: greyDart2,
                ),
          ),
        ],
      ),
    );
  }
}
