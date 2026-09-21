import 'package:flutter/material.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/screens/room_section/room/room_configure_stay/widget/room_stay_widget.dart';

class ConfigureStayTopSection extends StatelessWidget {
  const ConfigureStayTopSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Stay Duration",
          style: Helper(context).textTheme.titleMedium?.copyWith(
                fontSize: 16,
                color: blackText3,
              ),
        ),
        sizedBoxHeight(height: 16),
        ListView.separated(
          itemBuilder: (context, index) {
            return const StayContainer(
              isSelect: true,
            );
          },
          separatorBuilder: (_, __) => sizedBoxHeight(height: 12),
          itemCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
        )
      ],
    );
  }
}
