import 'package:flutter/material.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';

class SelectRoomBedSection extends StatelessWidget {
  final bool isAvailable;
  const SelectRoomBedSection({
    super.key,
    required this.isAvailable,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 26),
          decoration: BoxDecoration(
            color: isAvailable ? white : greyLight7,
            borderRadius: BorderRadius.circular(12),
            border:
                isAvailable ? Border.all(width: 1, color: greyLight6) : null,
          ),
          child: Column(
            children: [
              Icon(
                Icons.bed,
                color: isAvailable ? greyDart2 : greyText5,
              ),
              sizedBoxHeight(height: 8),
              Text(
                "BED A1",
                style: Helper(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: isAvailable ? greyDart2 : greyText5,
                    ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: greyText5,
            ),
            child: Text(
              isAvailable ? "AVAILABLE" : "OCCUPIED",
              style: Helper(context).textTheme.titleMedium?.copyWith(
                    fontSize: 8,
                    color: white,
                    letterSpacing: 1,
                  ),
            ),
          ),
        )
      ],
    );
  }
}
