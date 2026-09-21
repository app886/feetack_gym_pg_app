import 'package:flutter/material.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/screens/gym/gym_final_step_screen/widget/gym_final_mid_section/gym_final_cash_payment_section.dart';
import 'package:vlr/views/screens/gym/gym_final_step_screen/widget/gym_final_mid_section/gym_final_month_autopay_section.dart';
import 'package:vlr/views/screens/gym/gym_final_step_screen/widget/gym_final_mid_section/gym_final_one_time_payment_container.dart';
import 'package:vlr/views/screens/gym/gym_final_step_screen/widget/gym_final_top_section.dart';

class GymFinalStepScreen extends StatelessWidget {
  const GymFinalStepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: black.withValues(alpha: 0.05),
        title: Text(
          "FINAL STEP",
          style: Helper(context).textTheme.bodyMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: primaryText1,
                letterSpacing: 1.4,
              ),
        ),
      ),
      body: const SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child: Column(
          children: [
            // GYMFinalTopSection(),
            GYMFinalMonthlyAutoPaySection(),
            GYMFinalOneTimePaymentSection(),
            GYMFinalCashPaymentSection()
          ],
        ),
      ),
    );
  }
}
