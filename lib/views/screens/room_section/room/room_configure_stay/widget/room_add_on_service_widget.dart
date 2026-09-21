import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vlr/generated/assets.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';

// import 'your_model_file_path.dart'; // Make sure to import your model

class AddOnServiceWidget extends StatelessWidget {
  final AddOnService addOnService; // Passing the entire model
  final ValueChanged<bool?>
      onChanged; // Keeping the callback for state management

  const AddOnServiceWidget({
    super.key,
    required this.addOnService,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Helper(context).textTheme;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 13.7,
            vertical: 11.6,
          ),
          decoration: BoxDecoration(
            color: greyLight5,
            borderRadius: BorderRadius.circular(8),
          ),
          child: SvgPicture.asset(
            addOnService.iconPath, // Accessed via model
            height: 17,
            fit: BoxFit.cover,
          ),
        ),
        sizedBoxWidth(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                addOnService.title, // Accessed via model
                style: textTheme.titleMedium?.copyWith(
                  fontSize: 14,
                  color: blackText3,
                ),
              ),
              Text(
                addOnService.subtitle, // Accessed via model
                style: textTheme.bodyMedium?.copyWith(
                  fontSize: 10,
                  color: greyDart2,
                ),
              ),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            text: addOnService.price, // Accessed via model
            style: textTheme.titleMedium?.copyWith(
              fontSize: 14,
              color: blackText3,
            ),
            children: [
              TextSpan(
                text: " /mo",
                style: textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                  color: blackText3,
                ),
              )
            ],
          ),
        ),
        Checkbox(
          value: addOnService.isChecked,
          onChanged: onChanged,
          splashRadius: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          side: const BorderSide(
            color: Colors.grey,
            width: 1.5,
          ),
        )
      ],
    );
  }
}

class AddOnService {
  final String id;
  final String title;
  final String subtitle;
  final String price;
  final String iconPath;
  bool isChecked;

  AddOnService({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.iconPath,
    this.isChecked = false,
  });
}

List<AddOnService> availableAddOns = [
  AddOnService(
    id: 'addon_1',
    title: '3 Meals/Day',
    subtitle: 'Chef-prepared healthy dining',
    price: '₹4,500',
    iconPath: Assets.svgsMeal,
  ),
  AddOnService(
    id: 'addon_2',
    title: 'Daily Laundry',
    subtitle: 'Wash, iron & fold service',
    price: '₹1,200',
    iconPath: Assets.svgsMeal, // Make sure to add this to your assets
  ),
  AddOnService(
    id: 'addon_3',
    title: 'Room Cleaning',
    subtitle: 'Deep cleaning every weekend',
    price: '₹800',
    iconPath: Assets.svgsMeal, // Make sure to add this to your assets
  ),
  AddOnService(
    id: 'addon_4',
    title: 'High-Speed WiFi',
    subtitle: 'Up to 200 Mbps unlimited',
    price: '₹500',
    iconPath: Assets.svgsWifi, // Make sure to add this to your assets
  ),
];
