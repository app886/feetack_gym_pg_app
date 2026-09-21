import 'package:flutter/material.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/base/custom_image.dart';

class SelectRoomProfileWidget extends StatelessWidget {
  const SelectRoomProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: white,
        border: Border.all(width: 1, color: greyLight3),
      ),
      child: Row(
        children: [
          const CustomImage(
            path: Assets.imagesPgRoom,
            height: 80,
            width: 80,
            fit: BoxFit.cover,
            radius: 12,
          ),
          sizedBoxWidth(width: 16),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Urban Oasis Suite",
                style: Helper(context).textTheme.titleMedium?.copyWith(
                      fontSize: 18,
                      color: blueLight3,
                    ),
              ),
              sizedBoxHeight(height: 2),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 16,
                  ),
                  sizedBoxWidth(width: 2),
                  Text(
                    "Koramangala, Bengaluru",
                    style: Helper(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: greyDart2,
                        ),
                  ),
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
