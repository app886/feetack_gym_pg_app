import 'package:flutter/material.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/screens/room_section/room/room_configure_stay/widget/room_add_on_service_widget.dart';

class RoomAddServiceSection extends StatefulWidget {
  const RoomAddServiceSection({
    super.key,
  });

  @override
  State<RoomAddServiceSection> createState() => _RoomAddServiceSectionState();
}

class _RoomAddServiceSectionState extends State<RoomAddServiceSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: greyLight3),
        color: white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.add_circle_outline_outlined,
                color: primaryColor,
              ),
              sizedBoxWidth(width: 8),
              Text(
                "Add-on Services",
                style: Helper(context).textTheme.titleMedium?.copyWith(
                      fontSize: 16,
                      color: blackText3,
                    ),
              ),
            ],
          ),
          sizedBoxHeight(height: 34),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: availableAddOns.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final addOn = availableAddOns[index];

              return AddOnServiceWidget(
                addOnService: addOn, // Pass the whole object here
                onChanged: (bool? newValue) {
                  setState(() {
                    addOn.isChecked = newValue ?? false;
                  });
                },
              );
            },
          )
        ],
      ),
    );
  }
}
