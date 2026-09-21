import 'package:flutter/material.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';

class TermConditionMedSection extends StatelessWidget {
  const TermConditionMedSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: white,
        border: Border.all(
          width: 1,
          color: greyLight6,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        "Residents are expected to maintain a peaceful environment. A 11:00 PM curfew is strictly enforced for the safety and security of all residents. Quiet hours are observed from 10:00 PM to 7:00 AM.",
        style: Helper(context).textTheme.bodySmall?.copyWith(
              fontSize: 14,
              color: greyDart2,
            ),
      ),
    );
  }
}
