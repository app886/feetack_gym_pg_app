import 'package:flutter/material.dart';
import 'package:vlr/services/theme.dart';

class TimeSlotContainer extends StatelessWidget {
  const TimeSlotContainer({
    super.key,
    required this.isSelected,
    required this.isEnabled,
    required this.time,
  });

  final bool isSelected;
  final bool isEnabled;
  final String time;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: isSelected
            ? textBlue
            : isEnabled
                ? white
                : greyLight4.withValues(alpha: 0.20),
        border: Border.all(
          color: isSelected
              ? textBlue
              : isEnabled
                  ? greyLight2.withValues(alpha: 0.5)
                  : greyLight4.withValues(alpha: 0.30),
          width: 1.2,
        ),
        boxShadow: isSelected ? [
          BoxShadow(
            color: textBlue.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 3),
          )
        ] : [],
      ),
      child: Text(
        time,
        style: TextStyle(
          fontSize: 13,
          letterSpacing: -0.2,
          fontWeight: isSelected ? FontWeight.w800 : FontWeight.w700,
          color: isSelected
              ? white
              : isEnabled
                  ? blackText1
                  : greyDart.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}
