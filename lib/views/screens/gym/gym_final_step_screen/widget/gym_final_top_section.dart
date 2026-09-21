import 'package:flutter/material.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';

class GYMFinalTopSection extends StatelessWidget {
  const GYMFinalTopSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select your\npayment frequency.",
          overflow: TextOverflow.clip,
          style: Helper(context).textTheme.titleSmall?.copyWith(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: blackText1,
              ),
        ),
        sizedBoxHeight(height: 16),
        Text(
          "Tailor your enrollment to fit your lifestyle. Choose a flexible one-time purchase or unlock the full potential of consistency with auto-pay.",
          overflow: TextOverflow.clip,
          style: Helper(context).textTheme.titleSmall?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: greyText2,
              ),
        ),
      ],
    );
  }
}
