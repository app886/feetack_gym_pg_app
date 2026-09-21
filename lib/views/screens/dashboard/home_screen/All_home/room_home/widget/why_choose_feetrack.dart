import 'package:flutter/material.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/screens/dashboard/home_screen/All_home/room_home/widget/why_choose_feetrack_widget.dart';

class WhyChooseFeetrack extends StatelessWidget {
  const WhyChooseFeetrack({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sizedBoxHeight(height: 20),
        Text(
          "Why choose Feetrack?",
          style: Helper(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: blackText1,
              ),
        ),
        sizedBoxHeight(height: 24),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              // mainAxisExtent: 150,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2),
          itemCount: whyChooseFeetrackModelList.length,
          itemBuilder: (context, index) {
            final whyChooseFeetrackModel = whyChooseFeetrackModelList[index];
            return WhyChooseFeetrackWidget(
              whyChooseFeetrackModel: whyChooseFeetrackModel,
            );
          },
        )
      ],
    );
  }
}
