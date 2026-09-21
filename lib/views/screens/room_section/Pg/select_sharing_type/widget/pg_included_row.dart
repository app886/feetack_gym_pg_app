import 'package:flutter/material.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';

class PgIncludedRow extends StatelessWidget {
  final String title;

  const PgIncludedRow({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.check_circle_outline_sharp,
          color: greenDark,
        ),
        sizedBoxWidth(width: 8),
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
