import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/animated_widgets.dart';
import '../../../payments/presentation/screen/payments_screen.dart';


class BillsInvoicesScreen extends StatelessWidget {
  const BillsInvoicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> invoices = [
      {
        'id': 'INV-2026-4401',
        'title': 'Consultation & Neurology Exam',
        'doctor': 'Dr. Mohamed Saeed',
        'date': '14 Sep 2026',
        'amount': '\$45.00',
        'status': 'Paid',
        'method': 'UPI / Apple Pay',
      },
      {
        'id': 'INV-2026-3890',
        'title': 'Pathology Lab Tests (CBC + Lipid)',
        'doctor': 'Central Pathology Lab',
        'date': '12 Sep 2026',
        'amount': '\$60.00',
        'status': 'Paid',
        'method': 'Visa Card ending 4812',
      },
      {
        'id': 'INV-2026-5120',
        'title': 'Pharmacy Home Delivery',
        'doctor': 'City Meds Pharmacy',
        'date': '15 Sep 2026',
        'amount': '\$26.00',
        'status': 'Due',
        'method': 'Pending Payment',
      },
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: const Text('Bills & Invoices', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: colorWhite)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: colorWhite, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: invoices.length,
        itemBuilder: (context, index) {
          final inv = invoices[index];
          final isPaid = inv['status'] == 'Paid';

          return FadeSlideTransitionWidget(
            index: index,
            child: ModernCard(
              margin: const EdgeInsets.only(bottom: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(inv['id']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: textMuted)),
                      StatusBadgeWidget(
                        label: inv['status']!,
                        textColor: isPaid ? wellnessGreen : emergencyRed,
                        bgColor: isPaid ? wellnessGreenBg : emergencyRedBg,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(inv['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: textDark)),
                  const SizedBox(height: 2),
                  Text('${inv['doctor']} • ${inv['date']}', style: const TextStyle(fontSize: 11, color: textMuted)),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Total Amount', style: TextStyle(fontSize: 10, color: textMuted)),
                          Text(inv['amount']!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textDark)),
                        ],
                      ),
                      isPaid
                          ? OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(side: const BorderSide(color: primaryColor)),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(backgroundColor: primaryColor, content: Text('Invoice ${inv['id']} downloaded!')),
                                );
                              },
                              icon: const Icon(Icons.download, size: 14, color: primaryColor),
                              label: const Text('Download Invoice', style: TextStyle(fontSize: 11, color: primaryColor)),
                            )
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const PaymentsScreen(amount: 26.0, billTitle: 'Pharmacy Order #INV-2026-5120'),
                                  ),
                                );
                              },
                              child: const Text('Pay Now', style: TextStyle(fontSize: 12, color: colorWhite, fontWeight: FontWeight.bold)),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
