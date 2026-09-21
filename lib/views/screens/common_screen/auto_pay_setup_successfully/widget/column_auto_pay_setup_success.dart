import 'package:flutter/material.dart';
import 'package:vlr/data/models/common/row_auto_pay_setup_success_model.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';

class ColumnOfAutoSetupSuccess extends StatelessWidget {
  final RowOfAutoSetupSuccessModel? rowOfAutoSetupSuccessModel;
  const ColumnOfAutoSetupSuccess({
    super.key,
    this.rowOfAutoSetupSuccessModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          rowOfAutoSetupSuccessModel?.title ?? "",
          style: Helper(context).textTheme.bodySmall?.copyWith(
                fontSize: 14,
                color: greyText3,
              ),
        ),
        sizedBoxHeight(height: 4),
        Text(
          rowOfAutoSetupSuccessModel?.subTitle ?? "",
          style: Helper(context).textTheme.titleSmall?.copyWith(
                fontSize: 24,
                color: blackText1,
              ),
        ),
      ],
    );
  }
}
