import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/animated_widgets.dart';
import '../../../bills_invoices/presentation/screen/bills_invoices_screen.dart';
import '../../../family_profiles/presentation/screen/family_profiles_screen.dart';
import '../../../health_documents/presentation/screen/health_documents_screen.dart';
import '../../../health_membership/presentation/screen/health_membership_screen.dart';
import '../../../insurance/presentation/screen/insurance_screen.dart';
import '../../../medical_records/presentation/screen/medical_records_screen.dart';
import '../../../offers_coupons/presentation/screen/offers_coupons_screen.dart';
import '../../../profile_health_id/presentation/screen/profile_health_id_screen.dart';
import '../../../ratings_feedback/presentation/screen/ratings_feedback_screen.dart';
import '../../../support_ticket/presentation/screen/support_ticket_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: const Text('My Profile & Health Hub', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: colorWhite)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // User Header Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileHealthIdScreen()));
                    },
                    child: Stack(
                      children: [
                        const CircleAvatar(
                          radius: 38,
                          backgroundColor: colorWhite,
                          child: Icon(Icons.person, size: 45, color: primaryColor),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(color: wellnessGreen, shape: BoxShape.circle),
                            child: const Icon(Icons.qr_code, size: 16, color: colorWhite),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Ahmed Mohamed',
                    style: TextStyle(color: colorWhite, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'ahmed.mohamed@example.com • +1 (555) 019-2834',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileHealthIdScreen())),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.badge_outlined, size: 14, color: colorWhite),
                          SizedBox(width: 6),
                          Text('ABHA Health ID: HID-9840', style: TextStyle(color: colorWhite, fontSize: 11, fontWeight: FontWeight.bold)),
                          SizedBox(width: 4),
                          Icon(Icons.chevron_right, size: 14, color: colorWhite),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Profile Menus
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildProfileGroup(
                    context,
                    title: 'Health Records & Family',
                    items: [
                      _ProfileMenuItem(
                        icon: Icons.history_edu,
                        title: 'Medical Records (EHR)',
                        subtitle: 'Previous diagnoses & vitals',
                        color: primaryColor,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MedicalRecordsScreen())),
                      ),
                      _ProfileMenuItem(
                        icon: Icons.folder_shared_outlined,
                        title: 'Health Documents Locker',
                        subtitle: 'Prescriptions & scan files',
                        color: pharmacyTeal,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HealthDocumentsScreen())),
                      ),
                      _ProfileMenuItem(
                        icon: Icons.family_restroom_outlined,
                        title: 'Family & Dependents',
                        subtitle: 'Manage spouse, children, parents',
                        color: diagnosticViolet,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FamilyProfilesScreen())),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  _buildProfileGroup(
                    context,
                    title: 'Billing, Insurance & Plans',
                    items: [
                      _ProfileMenuItem(
                        icon: Icons.shield_outlined,
                        title: 'Health Insurance & Claims',
                        subtitle: 'TPA cashless hospitalization tracking',
                        color: primaryDark,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const InsuranceScreen())),
                      ),
                      _ProfileMenuItem(
                        icon: Icons.card_membership_outlined,
                        title: 'Health Membership Plans',
                        subtitle: 'Silver / Gold family healthcare tiers',
                        color: ambulanceAmber,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HealthMembershipScreen())),
                      ),
                      _ProfileMenuItem(
                        icon: Icons.receipt_long_outlined,
                        title: 'Bills & Payment Invoices',
                        subtitle: 'Download receipts & view history',
                        color: wellnessGreen,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BillsInvoicesScreen())),
                      ),
                      _ProfileMenuItem(
                        icon: Icons.local_offer_outlined,
                        title: 'Coupons & Offers',
                        subtitle: 'Active discount vouchers',
                        color: offerOrange,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OffersCouponsScreen())),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  _buildProfileGroup(
                    context,
                    title: 'Help & Reviews',
                    items: [
                      _ProfileMenuItem(
                        icon: Icons.star_rate_outlined,
                        title: 'Ratings & Service Feedback',
                        subtitle: 'Rate doctors & clinical staff',
                        color: Colors.amber,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RatingsFeedbackScreen())),
                      ),
                      _ProfileMenuItem(
                        icon: Icons.support_agent_outlined,
                        title: '24/7 Helpdesk & Support Tickets',
                        subtitle: 'Raise inquiries & complaints',
                        color: primaryColor,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SupportTicketScreen())),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Logout Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: errorColor,
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Logged out successfully!')),
                        );
                      },
                      child: const Text('LOGOUT', style: TextStyle(color: colorWhite, fontWeight: FontWeight.bold, fontSize: 14)),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileGroup(BuildContext context, {required String title, required List<_ProfileMenuItem> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: textDark)),
        ),
        ModernCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: List.generate(items.length, (index) {
              final item = items[index];
              final isLast = index == items.length - 1;
              return Column(
                children: [
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: item.color.withOpacity(0.12), borderRadius: BorderRadius.circular(10)),
                      child: Icon(item.icon, color: item.color, size: 20),
                    ),
                    title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: textDark)),
                    subtitle: Text(item.subtitle, style: const TextStyle(fontSize: 11, color: textMuted)),
                    trailing: const Icon(Icons.chevron_right, size: 18, color: colorGrey),
                    onTap: item.onTap,
                  ),
                  if (!isLast) const Divider(height: 1, indent: 56),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}

class _ProfileMenuItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  _ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });
}
