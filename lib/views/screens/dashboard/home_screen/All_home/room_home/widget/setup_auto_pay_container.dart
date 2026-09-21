import 'package:flutter/material.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/base/common_button.dart';

class SetUpAskContainer extends StatelessWidget {
  const SetUpAskContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: greyText4, borderRadius: BorderRadius.circular(32)),
      padding: EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Never miss your rent payment",
            style: Helper(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  color: primaryText1,
                ),
          ),
          sizedBoxHeight(height: 16),
          Text(
            "Enable AutoPay and we'll take care of monthly payments. No more late fees, no more manual transfers.",
            style: Helper(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: greyText2,
                ),
          ),
          sizedBoxHeight(height: 16),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: CustomButton(
              height: 56,
              onTap: () {},
              radius: 999,
              color: primaryText1,
              borderColor: primaryText1,
              child: Text(
                "Set Up AutoPay",
                style: Helper(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: white,
                    ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
