import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/animated_widgets.dart';
// import 'package:hospital_management_system/core/constants/colors.dart';
// import 'package:hospital_management_system/core/widgets/animated_widgets.dart';

class InsuranceScreen extends StatelessWidget {
  const InsuranceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: const Text('Health Insurance & TPA Claims', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: colorWhite)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: colorWhite, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Digital Insurance Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.blue.withOpacity(0.3), blurRadius: 16, offset: const Offset(0, 6)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('STAR HEALTH INSURANCE', style: TextStyle(color: colorWhite, fontWeight: FontWeight.bold, fontSize: 15, letterSpacing: 1.1)),
                      Icon(Icons.shield, color: Colors.amberAccent, size: 26),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text('Policy Number', style: TextStyle(color: Colors.white70, fontSize: 10)),
                  const Text('SH-89210-9941-2026', style: TextStyle(color: colorWhite, fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      _CardDetail(label: 'Primary Insured', value: 'Ahmed Mohamed'),
                      _CardDetail(label: 'Sum Insured', value: '\$50,000'),
                      _CardDetail(label: 'Valid Thru', value: '12/2027'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const SectionHeader(title: 'Cashless Hospitalization Claim Tracker'),
            ModernCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Claim #CLM-2026-9182', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: textDark)),
                      StatusBadgeWidget(label: 'Approved & Settled', textColor: wellnessGreen, bgColor: wellnessGreenBg),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text('Hospital: City Care Hospital • Dept: Neurology', style: TextStyle(fontSize: 11, color: textMuted)),
                  const SizedBox(height: 12),
                  _buildClaimStep('1. Pre-Authorization Submitted', '10 Sep 2026', true),
                  _buildClaimStep('2. TPA Medical Query Cleared', '11 Sep 2026', true),
                  _buildClaimStep('3. Cashless Approval Granted (\$1,450)', '12 Sep 2026', true),
                  _buildClaimStep('4. Final Discharge & Settlement', '14 Sep 2026', true),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const SectionHeader(title: 'Insurance Actions'),
            Row(
              children: [
                Expanded(
                  child: ModernCard(
                    padding: const EdgeInsets.all(12),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(backgroundColor: primaryColor, content: Text('Opening new cashless claim form...')),
                      );
                    },
                    child: Column(
                      children: const [
                        Icon(Icons.add_moderator, color: primaryColor, size: 28),
                        SizedBox(height: 6),
                        Text('Submit New Claim', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ModernCard(
                    padding: const EdgeInsets.all(12),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('E-Card downloaded to gallery!')),
                      );
                    },
                    child: Column(
                      children: const [
                        Icon(Icons.download_for_offline_outlined, color: primaryColor, size: 28),
                        SizedBox(height: 6),
                        Text('Download E-Card', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClaimStep(String title, String date, bool isDone) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(isDone ? Icons.check_circle : Icons.radio_button_unchecked, color: isDone ? wellnessGreen : colorGrey, size: 16),
          const SizedBox(width: 8),
          Expanded(child: Text(title, style: TextStyle(fontSize: 12, fontWeight: isDone ? FontWeight.w600 : FontWeight.normal, color: textDark))),
          Text(date, style: const TextStyle(fontSize: 10, color: textMuted)),
        ],
      ),
    );
  }
}

class _CardDetail extends StatelessWidget {
  final String label;
  final String value;

  const _CardDetail({Key? key, required this.label, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 9)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(color: colorWhite, fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
