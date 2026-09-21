import 'package:flutter/material.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/screens/gym/gym_auto_pay_setup_screen/widget/gym_form_auto_pay_mandate_details_section.dart';
import 'package:vlr/views/screens/gym/gym_auto_pay_setup_screen/widget/gym_form_auto_pay_personal_details_section.dart';

class GymAutoPaySetupScreen extends StatelessWidget {
  const GymAutoPaySetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: black.withValues(alpha: 0.05),
        title: Text(
          "AUTO-PAY SETUP",
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GYMFormAutoPayPersonalDetailsSection(),
            GYMFormAutoPayMandateDetailsSection()
          ],
        ),
      ),
    );
  }
}
