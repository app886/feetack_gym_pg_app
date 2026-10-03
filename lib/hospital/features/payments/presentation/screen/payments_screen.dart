import 'package:flutter/material.dart';


import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/animated_widgets.dart';
import '../../../bills_invoices/presentation/screen/bills_invoices_screen.dart';

class PaymentsScreen extends StatefulWidget {
  final double amount;
  final String billTitle;

  const PaymentsScreen({
    Key? key,
    this.amount = 45.0,
    this.billTitle = 'Dr. Mohamed Saeed Consultation Fee',
  }) : super(key: key);

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  String _paymentMethod = 'UPI / Instant Pay';

  final List<Map<String, dynamic>> _methods = [
    {'title': 'UPI / Instant Pay', 'desc': 'Google Pay, PhonePe, Apple Pay', 'icon': Icons.qr_code_scanner},
    {'title': 'Credit / Debit Card', 'desc': 'Visa, MasterCard, Amex', 'icon': Icons.credit_card},
    {'title': 'Net Banking', 'desc': 'All major national & international banks', 'icon': Icons.account_balance},
    {'title': 'Health Insurance / Cashless', 'desc': 'Use linked insurance policy claim', 'icon': Icons.shield_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: const Text('Payments & Checkout', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: colorWhite)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: colorWhite, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.receipt_long, color: colorWhite),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BillsInvoicesScreen())),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Amount Summary Card
            ModernCard(
              color: primaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total Payable Amount', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  const SizedBox(height: 4),
                  Text('\$${widget.amount.toStringAsFixed(2)}', style: const TextStyle(color: colorWhite, fontSize: 32, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('For: ${widget.billTitle}', style: const TextStyle(color: colorWhite, fontSize: 13, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const SectionHeader(title: 'Choose Payment Method'),
            ...List.generate(_methods.length, (index) {
              final m = _methods[index];
              final isSelected = _paymentMethod == m['title'];
              return FadeSlideTransitionWidget(
                index: index,
                child: ModernCard(
                  margin: const EdgeInsets.only(bottom: 12),
                  border: Border.all(color: isSelected ? primaryColor : borderGrey, width: isSelected ? 2 : 1),
                  onTap: () => setState(() => _paymentMethod = m['title']),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: isSelected ? fillColor : backgroundColor, borderRadius: BorderRadius.circular(10)),
                        child: Icon(m['icon'], color: isSelected ? primaryColor : textMuted, size: 24),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(m['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: textDark)),
                            const SizedBox(height: 2),
                            Text(m['desc'], style: const TextStyle(fontSize: 11, color: textMuted)),
                          ],
                        ),
                      ),
                      Radio<String>(
                        value: m['title'],
                        groupValue: _paymentMethod,
                        activeColor: primaryColor,
                        onChanged: (val) => setState(() => _paymentMethod = val!),
                      ),
                    ],
                  ),
                ),
              );
            }),

            const SizedBox(height: 16),
            Row(
              children: const [
                Icon(Icons.lock, size: 14, color: wellnessGreen),
                SizedBox(width: 6),
                Text('256-bit SSL Secure Payment Gateway Encryption', style: TextStyle(fontSize: 11, color: textMuted)),
              ],
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: wellnessGreen,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 4,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      title: Row(
                        children: const [
                          Icon(Icons.check_circle, color: wellnessGreen, size: 28),
                          SizedBox(width: 10),
                          Text('Payment Successful!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        ],
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Amount: \$${widget.amount.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          const Text('Transaction ID: #TXN-9028491823', style: TextStyle(fontSize: 12, color: textMuted)),
                          const SizedBox(height: 12),
                          const Text('Receipt generated and saved in Bills & Invoices.', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      actions: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                          onPressed: () {
                            Navigator.pop(ctx);
                            Navigator.pop(context);
                          },
                          child: const Text('Done', style: TextStyle(color: colorWhite)),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.payment, color: colorWhite),
                label: Text('Pay \$${widget.amount.toStringAsFixed(2)} Securely', style: const TextStyle(color: colorWhite, fontSize: 15, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
