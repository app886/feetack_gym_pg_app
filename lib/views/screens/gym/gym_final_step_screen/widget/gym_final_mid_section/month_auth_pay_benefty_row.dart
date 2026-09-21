import 'package:flutter/material.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/base/custom_image.dart';

class MonthlyAutoPayBeneftyWidget extends StatelessWidget {
  final MonthlyAuthPayModel monthlyAuthPayModel;
  const MonthlyAutoPayBeneftyWidget({
    super.key,
    required this.monthlyAuthPayModel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.check_circle_outline,
          color: greenDark,
          size: 18,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                monthlyAuthPayModel.title,
                style: Helper(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: blackText1,
                    ),
              ),
              if (monthlyAuthPayModel.subTitle.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  monthlyAuthPayModel.subTitle,
                  style: Helper(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: greyText2,
                      ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class ExpandablePaymentCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final String price;
  final String priceSuffix;
  final List<MonthlyAuthPayModel> benefits;
  final Widget actionButton;
  final bool isRecommended;
  final bool initiallyExpanded;

  const ExpandablePaymentCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.price,
    required this.priceSuffix,
    required this.benefits,
    required this.actionButton,
    this.isRecommended = false,
    this.initiallyExpanded = false,
  });

  @override
  State<ExpandablePaymentCard> createState() => _ExpandablePaymentCardState();
}

class _ExpandablePaymentCardState extends State<ExpandablePaymentCard> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: widget.isRecommended ? primaryText1.withOpacity(0.4) : greyLight2.withOpacity(0.3),
          width: widget.isRecommended ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CustomImage(
                    path: widget.imagePath,
                    height: 48,
                    width: 48,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.isRecommended)
                          Container(
                            margin: const EdgeInsets.only(bottom: 4),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: primaryText1.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              "RECOMMENDED",
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                                color: primaryText1,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        Text(
                          widget.title,
                          style: Helper(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: blackText1,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: widget.price,
                          style: Helper(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                                color: primaryText1,
                              ),
                          children: [
                            TextSpan(
                              text: " ${widget.priceSuffix}",
                              style: Helper(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: greyText2,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        size: 22,
                        color: greyText2,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(height: 24),
                  Text(
                    widget.subtitle,
                    style: Helper(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 13,
                          color: greyText2,
                          height: 1.4,
                        ),
                  ),
                  const SizedBox(height: 16),
                  ...widget.benefits.map((benefit) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: MonthlyAutoPayBeneftyWidget(monthlyAuthPayModel: benefit),
                      )),
                  const SizedBox(height: 16),
                  widget.actionButton,
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class MonthlyAuthPayModel {
  final String title;
  final String subTitle;

  MonthlyAuthPayModel({required this.title, required this.subTitle});
}

List<MonthlyAuthPayModel> monthlyAuthPayModelList = [
  MonthlyAuthPayModel(
      title: "Ultimate Convenience",
      subTitle:
          "Payments are handled automatically. Never worry about manual renewals or administrative hurdles."),
  MonthlyAuthPayModel(
      title: "Guaranteed Session Slots",
      subTitle:
          "Auto-pay members receive priority scheduling, ensuring your favorite time slots with trainers are never missed."),
  MonthlyAuthPayModel(
      title: "Lock-in Rates",
      subTitle:
          "Subscription members are protected against future price adjustments for the duration of their active plan.")
];
