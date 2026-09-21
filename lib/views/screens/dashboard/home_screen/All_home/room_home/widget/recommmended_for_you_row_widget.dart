import 'package:flutter/material.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/base/common_button.dart';
import 'package:vlr/views/screens/room_section/search_room/search_room_screen.dart';

class RecommendedForYouRow extends StatelessWidget {
  final bool isRoom;
  final String? deposit;

  const RecommendedForYouRow({
    super.key,
    required this.isRoom,
    this.deposit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Recommended for ${isRoom ? "Room" : "PG"}",
              style: Helper(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: blackText1,
                  ),
            ),
            if (deposit != null && deposit != "0.00")
              Text(
                "Starting Deposit: ₹$deposit",
                style: Helper(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: primaryColor,
                    ),
              ),
          ],
        ),
        CustomButton(
          type: ButtonType.tertiary,
          onTap: () => navigate(
            context: context,
            page: const SearchRoomScreen(),
          ),
          child: Text(
            "View All",
            style: Helper(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: primaryText1,
                ),
          ),
        )
      ],
    );
  }
}
