import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
// import 'package:hospital_management_system/core/constants/colors.dart';
//
class IpdListScreen extends StatelessWidget {
  const IpdListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample data structured with your requested fields
    final List<Map<String, String>> ipdData = [
      {
        'date': '10 Sep 2026',
        'case': 'Orthopedic Admission',
        'symptoms': 'Fracture Post-Op Management',
        'amount': '₹5,250.00',
        'payment': 'Insurance Claim',
        'status': 'ADMITTED'
      },
      {
        'date': '24 Aug 2026',
        'case': 'Cardiology Care',
        'symptoms': 'Chest Pain & Monitoring',
        'amount': '₹12,450.00',
        'payment': 'Card',
        'status': 'DISCHARGED'
      },
    ];

    return Container(
      color: backgroundColor,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: ipdData.length,
        itemBuilder: (context, index) {
          final item = ipdData[index];
          final isAdmitted = item['status'] == 'ADMITTED';
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            shadowColor: Colors.black.withOpacity(0.08),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.hotel_outlined, color: primaryColor, size: 18),
                          const SizedBox(width: 6),
                          Text(
                            item['case']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: (isAdmitted ? Colors.orange : Colors.blue).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          item['status']!,
                          style: TextStyle(
                            color: isAdmitted ? Colors.orange[800] : Colors.blue[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(height: 1),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoColumn(Icons.calendar_today_outlined, 'Admit Date', item['date']!),
                      ),
                      Expanded(
                        child: _buildInfoColumn(Icons.payments_outlined, 'Payment', item['payment']!),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildInfoColumn(Icons.healing_outlined, 'Symptoms / Diagnosis', item['symptoms']!),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Total Bill: ',
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                          children: [
                            TextSpan(
                              text: item['amount']!,
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.receipt_long_outlined, size: 14, color: Colors.white),
                        label: const Text('Invoice', style: TextStyle(color: Colors.white, fontSize: 12)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          elevation: 0,
                        ),
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

  Widget _buildInfoColumn(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
