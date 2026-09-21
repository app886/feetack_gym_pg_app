import 'package:flutter/material.dart';
import 'package:vlr/generated/assets.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/base/common_button.dart';

class ReferWidgetCouponsCode extends StatelessWidget {
  const ReferWidgetCouponsCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 5,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            Assets.imagesRoomRefer,
            fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 28, horizontal: 32),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  blueLight3.withValues(alpha: 0.90),
                  blueLight3.withValues(alpha: 0.00),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Refer a Friend",
                  style: Helper(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: white,
                      ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Text(
                    "Get ₹1000 off for every successful referral.",
                    style: Helper(context).textTheme.bodySmall?.copyWith(
                          fontSize: 16,
                          color: white,
                        ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: CustomButton(
                    radius: 99,
                    height: 40,
                    borderColor: white,
                    color: white,
                    onTap: () {},
                    child: Text(
                      "Invite Now",
                      style: Helper(context).textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: blueLight3,
                          ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
