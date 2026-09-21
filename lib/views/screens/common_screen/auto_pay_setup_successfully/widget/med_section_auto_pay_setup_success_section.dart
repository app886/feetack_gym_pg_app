import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/common_controller.dart';
import 'package:vlr/data/models/common/row_auto_pay_setup_success_model.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/screens/common_screen/auto_pay_setup_successfully/widget/column_auto_pay_setup_success.dart'
    show ColumnOfAutoSetupSuccess;

class MedSectionAutoPaySetupSuccess extends StatelessWidget {
  const MedSectionAutoPaySetupSuccess({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          border: Border.all(width: 1, color: greyLight6),
          color: white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 1),
              blurRadius: 2,
              spreadRadius: 0,
              color: black.withValues(
                alpha: 0.05,
              ),
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Auto-pay Summary",
                style: Helper(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      color: greyText2,
                    ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  color: greenDark.withValues(
                    alpha: 0.10,
                  ),
                ),
                child: Text(
                  "ACTIVE",
                  textAlign: TextAlign.center,
                  style: Helper(context).textTheme.titleMedium?.copyWith(
                        fontSize: 12,
                        color: greenDark,
                      ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 24),
            child: Divider(
              color: greyLight6,
            ),
          ),

          GetBuilder<CommonController>(builder: (commonController) {
            return ListView.separated(
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final _rowOfAutoSetupSuccessModel = commonController.isLoading
                    ? RowOfAutoSetupSuccessModel()
                    : commonController.rowOfAutoSetupSuccessModelList[index];
                return ColumnOfAutoSetupSuccess(
                  rowOfAutoSetupSuccessModel: _rowOfAutoSetupSuccessModel,
                );
              },
              separatorBuilder: (_, __) => sizedBoxHeight(height: 24),
              itemCount: commonController.rowOfAutoSetupSuccessModelList.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            );
          })
          //
        ],
      ),
    );
  }
}
