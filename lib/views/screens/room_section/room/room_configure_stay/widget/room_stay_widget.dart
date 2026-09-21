import 'package:flutter/material.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';

class StayContainer extends StatelessWidget {
  final bool isSelect;
  const StayContainer({
    super.key,
    required this.isSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 1,
            color: isSelect
                ? primaryColor
                : greyLight1.withValues(
                    alpha: 0.40,
                  ),
          ),
          boxShadow: isSelect
              ? [
                  BoxShadow(
                    offset: const Offset(0, 1),
                    spreadRadius: 0,
                    blurRadius: 2,
                    color: black.withValues(alpha: 0.05),
                  ),
                ]
              : []),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "STANDARD",
                  style: Helper(context).textTheme.titleMedium?.copyWith(
                        fontSize: 10,
                        color: greyDart2,
                      ),
                ),
                sizedBoxHeight(height: 4),
                Text(
                  "3 Months",
                  style: Helper(context).textTheme.displayLarge?.copyWith(
                        fontSize: 18,
                        color: blackText3,
                      ),
                ),
              ],
            ),
          ),
          isSelect
              ? const CircleAvatar(
                  radius: 12,
                  backgroundColor: primaryColor,
                  child: Icon(
                    Icons.check,
                    size: 15,
                  ),
                )
              : Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2,
                      color: greyLight6,
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
