import 'package:flutter/material.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';

class CouponTermConditionRow extends StatelessWidget {
  final String title;
  const CouponTermConditionRow({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.check_circle_rounded,
          color: greenDark,
          size: 20,
        ),
        sizedBoxWidth(width: 16),
        Expanded(
          child: Text(
            title,
            style: Helper(context).textTheme.bodySmall?.copyWith(
                  fontSize: 16,
                  color: greyDart2,
                ),
          ),
        ),
      ],
    );
  }
}
