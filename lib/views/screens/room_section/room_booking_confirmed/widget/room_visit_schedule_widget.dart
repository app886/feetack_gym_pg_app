import 'package:flutter/material.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';

class RoomVisitDetailsWidget extends StatelessWidget {
  const RoomVisitDetailsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 1, color: greyLight6),
        color: greyLight5,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_month,
                color: blueLight3,
              ),
              sizedBoxWidth(width: 8),
              Text(
                "Appointment Detail",
                style: Helper(context).textTheme.titleMedium?.copyWith(
                      fontSize: 18,
                      color: blackText3,
                    ),
              ),
            ],
          ),
          sizedBoxHeight(height: 24),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Date",
                    style: Helper(context).textTheme.labelLarge?.copyWith(
                          fontSize: 14,
                          color: greyDart2,
                        ),
                  ),
                  Text(
                    "Friday, Oct 6, 2023",
                    style: Helper(context).textTheme.titleSmall?.copyWith(
                          fontSize: 16,
                          color: blackText3,
                        ),
                  ),
                ],
              ),
              sizedBoxHeight(height: 10),
              Divider(
                color: greyLight6.withValues(alpha: 0.30),
              )
            ],
          ),
          sizedBoxHeight(height: 16),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Time",
                    style: Helper(context).textTheme.labelLarge?.copyWith(
                          fontSize: 14,
                          color: greyDart2,
                        ),
                  ),
                  Text(
                    "11:30 AM",
                    style: Helper(context).textTheme.titleSmall?.copyWith(
                          fontSize: 16,
                          color: blackText3,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
