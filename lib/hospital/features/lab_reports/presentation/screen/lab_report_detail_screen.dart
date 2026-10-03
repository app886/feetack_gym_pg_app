import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/animated_widgets.dart';
// import 'package:hospital_management_system/core/constants/colors.dart';
// import 'package:hospital_management_system/core/widgets/animated_widgets.dart';

class LabReportDetailScreen extends StatelessWidget {
  final String testName;
  final String date;
  final String labName;

  const LabReportDetailScreen({
    Key? key,
    this.testName = 'Complete Blood Count (CBC)',
    this.date = '12 Sep 2026',
    this.labName = 'Apex Central Pathology Lab',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> results = [
      {'param': 'Hemoglobin', 'value': '14.2', 'unit': 'g/dL', 'range': '13.0 - 17.0', 'status': 'Normal'},
      {'param': 'Total WBC Count', 'value': '7,400', 'unit': '/cumm', 'range': '4,000 - 11,000', 'status': 'Normal'},
      {'param': 'Platelet Count', 'value': '240,000', 'unit': '/cumm', 'range': '150,000 - 450,000', 'status': 'Normal'},
      {'param': 'RBC Count', 'value': '4.8', 'unit': 'mil/cumm', 'range': '4.5 - 5.5', 'status': 'Normal'},
      {'param': 'Serum Uric Acid', 'value': '7.4', 'unit': 'mg/dL', 'range': '3.4 - 7.0', 'status': 'Slightly High'},
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: diagnosticViolet,
        elevation: 0,
        title: const Text('Lab Diagnostic Report', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: colorWhite)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: colorWhite, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download_rounded, color: colorWhite),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(backgroundColor: diagnosticViolet, content: Text('Lab Report PDF downloaded!'), behavior: SnackBarBehavior.floating),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Header card
            ModernCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(testName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textDark)),
                      StatusBadgeWidget(label: 'Verified', textColor: wellnessGreen, bgColor: wellnessGreenBg, icon: Icons.verified),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('$labName • $date', style: const TextStyle(fontSize: 12, color: textMuted)),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Sample ID: #LAB-99201', style: TextStyle(fontSize: 11, color: textMuted)),
                      Text('Doctor: Dr. Mohamed Saeed', style: TextStyle(fontSize: 11, color: textMuted)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Results Table Card
            ModernCard(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    child: Text('Test Parameters & Reference Values', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: textDark)),
                  ),
                  const Divider(),
                  ...results.map((r) {
                    final isNormal = r['status'] == 'Normal';
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      margin: const EdgeInsets.only(bottom: 6),
                      decoration: BoxDecoration(
                        color: isNormal ? Colors.transparent : Colors.amber.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(r['param'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: textDark)),
                                Text('Ref: ${r['range']} ${r['unit']}', style: const TextStyle(fontSize: 10, color: textMuted)),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              '${r['value']} ${r['unit']}',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: isNormal ? textDark : warningColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          StatusBadgeWidget(
                            label: r['status'],
                            textColor: isNormal ? wellnessGreen : warningColor,
                            bgColor: isNormal ? wellnessGreenBg : Colors.amber.withOpacity(0.18),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Pathologist Remarks
            ModernCard(
              color: fillColor.withOpacity(0.4),
              border: Border.all(color: primaryLight.withOpacity(0.4)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Pathologist Remarks', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: primaryDark)),
                  SizedBox(height: 6),
                  Text('All cellular blood counts are within normal physiological range. Mild uric acid elevation noted; recommend hydration and routine dietary check.', style: TextStyle(fontSize: 12, height: 1.4)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
