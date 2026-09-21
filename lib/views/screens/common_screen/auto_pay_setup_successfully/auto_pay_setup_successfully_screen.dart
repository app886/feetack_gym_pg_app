import 'package:flutter/material.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/base/common_button.dart';
import 'package:vlr/views/screens/common_screen/auto_pay_setup_successfully/widget/med_section_auto_pay_setup_success_section.dart';
import 'package:vlr/views/screens/common_screen/auto_pay_setup_successfully/widget/top_section_auto_pay_setup_success.dart';
import 'package:vlr/views/screens/dashboard/dashboard_screen.dart';

class AutoPaySetupSuccessfullyScreen extends StatelessWidget {
  const AutoPaySetupSuccessfullyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(),
        body: SingleChildScrollView(
          padding: AppConstants.screenPadding,
          child: Column(
            children: [
              const AutoPaySetupSuccessTopSection(),
              sizedBoxHeight(height: 48),
              const MedSectionAutoPaySetupSuccess(),
              sizedBoxHeight(height: 24),
              CustomButton(
                onTap: () {
                  navigate(context: context, page: const DashboardScreen());
                },
                height: 60,
                radius: 999,
                color: primaryText1,
                borderColor: primaryText1,
                child: Text(
                  "Back to Home",
                  style: Helper(context).textTheme.bodySmall?.copyWith(
                        fontSize: 18,
                        color: white,
                      ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
