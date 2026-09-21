import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/base/common_button.dart';
import 'package:vlr/views/base/custom_image.dart';

class RoomVisitYouHostWidget extends StatelessWidget {
  const RoomVisitYouHostWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Your Host",
          style: Helper(context).textTheme.titleMedium?.copyWith(
                fontSize: 20,
                color: blackText3,
              ),
        ),
        sizedBoxHeight(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              width: 1,
              color: greyLight1.withValues(alpha: 0.30),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: greyLight5),
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        image: AssetImage(
                          Assets.imagesReview1,
                        ),
                      ),
                    ),
                  ),
                  sizedBoxWidth(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Rajesh Khanna",
                          style:
                              Helper(context).textTheme.displayMedium?.copyWith(
                                    fontSize: 16,
                                    color: blackText3,
                                  ),
                        ),
                        sizedBoxHeight(height: 4),
                        Text(
                          "Property Manager",
                          style: Helper(context).textTheme.bodyMedium?.copyWith(
                                fontSize: 12,
                                color: greyDart2,
                              ),
                        ),
                      ],
                    ),
                  ),
                  sizedBoxWidth(width: 16),
                  SizedBox(
                    height: 44,
                    width: 44,
                    child: CustomButton(
                      color: blueLight4,
                      borderColor: blueLight4,
                      radius: 999,
                      onTap: () {},
                      child: SvgPicture.asset(
                        Assets.svgsCall,
                        fit: BoxFit.cover,
                        colorFilter:
                            const ColorFilter.mode(greenDark, BlendMode.srcIn),
                      ),
                    ),
                  ),
                  sizedBoxWidth(width: 8),
                  SizedBox(
                    height: 44,
                    width: 44,
                    child: CustomButton(
                      color: blueLight3,
                      borderColor: blueLight3,
                      radius: 999,
                      onTap: () {},
                      child: SvgPicture.asset(
                        Assets.svgsMessage,
                        // height: 10,
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(white, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
