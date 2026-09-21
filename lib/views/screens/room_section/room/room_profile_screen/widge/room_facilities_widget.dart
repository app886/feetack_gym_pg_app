import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vlr/generated/assets.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';

class FacilitiesContainer extends StatelessWidget {
  const FacilitiesContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: greyLight5,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            Assets.svgsWifi,
            fit: BoxFit.contain,
          ),
          sizedBoxWidth(width: 6),
          Text(
            "WiFi",
            style: Helper(context).textTheme.titleMedium?.copyWith(
                  fontSize: 12,
                  color: greyDart2,
                ),
          ),
        ],
      ),
    );
  }
}

List<FacilitiesContainer> facilitiesList = [
  FacilitiesContainer(),
  FacilitiesContainer(),
  FacilitiesContainer(),
  FacilitiesContainer(),
];
