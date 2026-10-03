import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import 'booking_succsess_screen.dart';

class BillingOverviewScreen extends StatefulWidget {
  const BillingOverviewScreen({Key? key}) : super(key: key);

  @override
  State<BillingOverviewScreen> createState() => _BillingOverviewScreenState();
}

class _BillingOverviewScreenState extends State<BillingOverviewScreen> {
  String _selectedMethod = 'UPI';

  final List<Map<String, String>> _paymentMethods = [
    {
      'title': 'Google Pay',
      'subtitle': 'Fast & secure UPI payment via GPay',
      'imageUrl': 'https://cdn-icons-png.flaticon.com/512/6124/6124998.png',
      'value': 'GPay',
    },
    {
      'title': 'UPI Payment',
      'subtitle': 'Paytm / PhonePe / BHIM UPI',
      'imageUrl': 'https://cdn-icons-png.flaticon.com/512/825/825561.png',
      'value': 'UPI',
    },
    {
      'title': 'Credit / Debit Card',
      'subtitle': 'Visa, MasterCard, RuPay cards',
      'imageUrl': 'https://cdn-icons-png.flaticon.com/512/633/633611.png',
      'value': 'Card',
    },
    {
      'title': 'Cash / Pay at Hospital Desk',
      'subtitle': 'Pay in cash at hospital billing counter',
      'imageUrl': 'https://cdn-icons-png.flaticon.com/512/2331/2331717.png',
      'value': 'Cash',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: const Text(
          'Billing Overview',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: colorWhite),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: colorWhite, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderCard(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Pending Invoices'),
                  const SizedBox(height: 12),
                  _buildInvoiceItem(
                    title: 'Consultation - Dr. Jane Cooper',
                    date: '15 Sep 2026',
                    amount: '₹250.00',
                    isUrgent: true,
                  ),
                  _buildInvoiceItem(
                    title: 'Lab Test - Blood Profile',
                    date: '12 Sep 2026',
                    amount: '₹450.00',
                    isUrgent: false,
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Select Payment Method'),
                  const SizedBox(height: 12),
                  ..._paymentMethods.map((method) {
                    return _buildPaymentMethodItem(
                      title: method['title']!,
                      subtitle: method['subtitle']!,
                      imageUrl: method['imageUrl']!,
                      value: method['value']!,
                    );
                  }).toList(),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Recent Transactions'),
                  const SizedBox(height: 12),
                  _buildTransactionItem(
                    title: 'Pharmacy - Medicines',
                    date: '08 Sep 2026',
                    amount: '₹120.00',
                    status: 'Paid',
                  ),
                  _buildTransactionItem(
                    title: 'OPD Visit - Dental',
                    date: '05 Sep 2026',
                    amount: '₹200.00',
                    status: 'Paid',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomPayButton(),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          const Text(
            'Total Outstanding',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 8),
          const Text(
            '₹700.00',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildHeaderStat('Invoices', '02'),
              Container(width: 1, height: 30, color: Colors.white24),
              _buildHeaderStat('Due Date', '20 Sep'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: textDark,
      ),
    );
  }

  Widget _buildInvoiceItem({
    required String title,
    required String date,
    required String amount,
    required bool isUrgent,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isUrgent ? Colors.red.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.receipt_long,
              color: isUrgent ? Colors.red : Colors.orange,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: textDark),
                ),
                Text(
                  date,
                  style: const TextStyle(color: textMuted, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodItem({
    required String title,
    required String subtitle,
    required String imageUrl,
    required String value,
  }) {
    bool isSelected = _selectedMethod == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMethod = value;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? fillColor : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? primaryColor : borderGrey,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: borderGrey, width: 0.8),
              ),
              child: Image.network(
                imageUrl,
                width: 30,
                height: 30,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: primaryColor,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.payment_rounded,
                  color: isSelected ? primaryColor : textMuted,
                  size: 22,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                      fontSize: 14,
                      color: isSelected ? primaryColor : textDark,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 11, color: textMuted),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? primaryColor : Colors.transparent,
                border: Border.all(
                  color: isSelected ? primaryColor : colorGrey,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 14)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem({
    required String title,
    required String date,
    required String amount,
    required String status,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderGrey),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: successColor, size: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: textDark),
                ),
                Text(
                  date,
                  style: const TextStyle(color: textMuted, fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: textDark),
              ),
              Text(
                status,
                style: const TextStyle(color: successColor, fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomPayButton() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2)),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookingSuccsessScreen(
                title: 'Hospital Invoice Payment',
                doctorName: 'Dr. Jane Cooper (Multi-Specialty)',
                amount: '₹700.00',
                date: '15 Sep 2026',
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 2,
        ),
        child: Text(
          'Pay All Outstanding (₹700.00 via $_selectedMethod)',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),
    );
  }
}
