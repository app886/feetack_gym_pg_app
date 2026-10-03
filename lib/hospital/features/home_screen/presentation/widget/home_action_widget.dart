import 'package:flutter/material.dart';

import '../../../../../ecomerce/screens/notification/view/notificatios_screen.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/animated_widgets.dart';
import '../../../ambulance_booking/presentation/screen/ambulance_booking_screen.dart';
import '../../../appointments/presentation/screen/appointments_screen.dart';
import '../../../bed_admission/presentation/screen/bed_admission_screen.dart';
import '../../../bills_invoices/presentation/screen/bills_invoices_screen.dart';
import '../../../blood_bank/presentation/screen/blood_bank_screen.dart';
import '../../../doctor/presentation/screens/doctor_search_screen.dart';
import '../../../doctor_followup/presentation/screen/doctor_followup_screen.dart';
import '../../../emergency_assistance/presentation/screen/emergency_assistance_screen.dart';
import '../../../family_profiles/presentation/screen/family_profiles_screen.dart';
import '../../../health_documents/presentation/screen/health_documents_screen.dart';
import '../../../health_membership/presentation/screen/health_membership_screen.dart';
import '../../../health_packages/presentation/screen/health_packages_screen.dart';
import '../../../home_doctor_visit/presentation/screen/home_doctor_visit_screen.dart';
import '../../../home_nursing/presentation/screen/home_nursing_screen.dart';
import '../../../home_sample_collection/presentation/screen/home_sample_collection_screen.dart';
import '../../../hospital_search/presentation/screen/hospital_search_screen.dart';
import '../../../insurance/presentation/screen/insurance_screen.dart';
import '../../../lab_reports/presentation/screen/lab_report_detail_screen.dart';
import '../../../lab_tests/presentation/screen/lab_test_catalog_screen.dart';
import '../../../medical_equipment/presentation/screen/medical_equipment_screen.dart';
import '../../../medical_records/presentation/screen/medical_records_screen.dart';
import '../../../medicine_order/presentation/screen/medicine_order_screen.dart';
import '../../../medicine_reminder/presentation/screen/medicine_reminder_screen.dart';
import '../../../offers_coupons/presentation/screen/offers_coupons_screen.dart';
import '../../../online_consultation/presentation/screen/online_consultation_screen.dart';
import '../../../payments/presentation/screen/payments_screen.dart';
import '../../../physiotherapy/presentation/screen/physiotherapy_screen.dart';
import '../../../prescriptions/presentation/screen/digital_prescription_screen.dart';
import '../../../profile_health_id/presentation/screen/profile_health_id_screen.dart';
import '../../../ratings_feedback/presentation/screen/ratings_feedback_screen.dart';
import '../../../support_ticket/presentation/screen/support_ticket_screen.dart';
import '../../../vaccination/presentation/screen/vaccination_screen.dart';
import '../../../visits/presentation/screen/visits_screen.dart';


class HomeActionWidget extends StatefulWidget {
  const HomeActionWidget({Key? key}) : super(key: key);

  @override
  State<HomeActionWidget> createState() => _HomeActionWidgetState();
}

class _HomeActionWidgetState extends State<HomeActionWidget> {
  bool _isExpanded = false;
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Doctor & Consult',
    'Diagnostics & Pharmacy',
    'Emergency & Care',
    'Hospital Stay',
    'Bills & Insurance',
    'Records & Reminders',
    'Plans & Support',
  ];

  late final List<Map<String, dynamic>> _allServices = [
    // Top 8 Primary Quick Actions (Row 1 & 2)
    {
      'id': 1,
      'title': 'Doctor\nSearch',
      'category': 'Doctor & Consult',
      'icon': Icons.person_search_rounded,
      'color': const Color(0xFF1976D2),
      'badge': null,
      'screen': const DoctorSearchScreen(),
    },
    {
      'id': 2,
      'title': 'Book\nAppointment',
      'category': 'Doctor & Consult',
      'icon': Icons.calendar_month_rounded,
      'color': const Color(0xFF0288D1),
      'badge': null,
      'screen': const AppointmentsScreen(userId: '1'),
    },
    {
      'id': 3,
      'title': 'Online\nConsult',
      'category': 'Doctor & Consult',
      'icon': Icons.video_camera_front_rounded,
      'color': const Color(0xFF0097A7),
      'badge': 'LIVE',
      'screen': const OnlineConsultationScreen(),
    },
    {
      'id': 10,
      'title': 'Order\nMedicines',
      'category': 'Diagnostics & Pharmacy',
      'icon': Icons.medication_rounded,
      'color': const Color(0xFF00897B),
      'badge': 'FAST',
      'screen': const MedicineOrderScreen(),
    },
    {
      'id': 7,
      'title': 'Lab Test\nBooking',
      'category': 'Diagnostics & Pharmacy',
      'icon': Icons.science_rounded,
      'color': const Color(0xFF7E57C2),
      'badge': null,
      'screen': const LabTestCatalogScreen(),
    },
    {
      'id': 9,
      'title': 'Lab\nReports',
      'category': 'Diagnostics & Pharmacy',
      'icon': Icons.analytics_outlined,
      'color': const Color(0xFF5C6BC0),
      'badge': 'NEW',
      'screen': const LabReportDetailScreen(),
    },
    {
      'id': 15,
      'title': 'Emergency\nSOS',
      'category': 'Emergency & Care',
      'icon': Icons.emergency_rounded,
      'color': const Color(0xFFE53935),
      'badge': '24/7',
      'screen': const EmergencyAssistanceScreen(),
    },
    {
      'id': 11,
      'title': 'Ambulance\nBooking',
      'category': 'Emergency & Care',
      'icon': Icons.airport_shuttle_rounded,
      'color': const Color(0xFFE65100),
      'badge': 'GPS',
      'screen': const AmbulanceBookingScreen(),
    },

    // Expanded Services (9 - 35)
    {
      'id': 4,
      'title': 'Home Doctor\nVisit',
      'category': 'Doctor & Consult',
      'icon': Icons.home_work_rounded,
      'color': const Color(0xFF1E88E5),
      'badge': null,
      'screen': const HomeDoctorVisitScreen(),
    },
    {
      'id': 26,
      'title': 'Doctor\nFollow-up',
      'category': 'Doctor & Consult',
      'icon': Icons.event_repeat_rounded,
      'color': const Color(0xFF1565C0),
      'badge': null,
      'screen': const DoctorFollowupScreen(),
    },
    {
      'id': 5,
      'title': 'Digital\nPrescription',
      'category': 'Diagnostics & Pharmacy',
      'icon': Icons.receipt_long_rounded,
      'color': const Color(0xFF00897B),
      'badge': null,
      'screen': const DigitalPrescriptionScreen(),
    },
    {
      'id': 8,
      'title': 'Home Sample\nCollection',
      'category': 'Diagnostics & Pharmacy',
      'icon': Icons.home_outlined,
      'color': const Color(0xFF7E57C2),
      'badge': null,
      'screen': const HomeSampleCollectionScreen(),
    },
    {
      'id': 12,
      'title': 'Home\nNursing',
      'category': 'Emergency & Care',
      'icon': Icons.elderly_rounded,
      'color': const Color(0xFF3F51B5),
      'badge': null,
      'screen': const HomeNursingScreen(),
    },
    {
      'id': 13,
      'title': 'Physio-\ntherapy',
      'category': 'Emergency & Care',
      'icon': Icons.accessibility_new_rounded,
      'color': const Color(0xFF43A047),
      'badge': null,
      'screen': const PhysiotherapyScreen(),
    },
    {
      'id': 14,
      'title': 'Hospital\nSearch',
      'category': 'Emergency & Care',
      'icon': Icons.local_hospital_rounded,
      'color': const Color(0xFF1E88E5),
      'badge': null,
      'screen': const HospitalSearchScreen(),
    },
    {
      'id': 27,
      'title': 'Blood Bank\nEnquiry',
      'category': 'Emergency & Care',
      'icon': Icons.bloodtype_rounded,
      'color': const Color(0xFFD32F2F),
      'badge': null,
      'screen': const BloodBankScreen(),
    },
    {
      'id': 28,
      'title': 'Medical\nEquipment',
      'category': 'Emergency & Care',
      'icon': Icons.accessible_rounded,
      'color': const Color(0xFF0288D1),
      'badge': null,
      'screen': const MedicalEquipmentScreen(),
    },
    {
      'id': 16,
      'title': 'Health\nPackages',
      'category': 'Hospital Stay',
      'icon': Icons.health_and_safety_rounded,
      'color': const Color(0xFF1976D2),
      'badge': 'SAVE',
      'screen': const HealthPackagesScreen(),
    },
    {
      'id': 17,
      'title': 'Vaccination\nBooking',
      'category': 'Hospital Stay',
      'icon': Icons.vaccines_rounded,
      'color': const Color(0xFF00897B),
      'badge': null,
      'screen': const VaccinationScreen(),
    },
    {
      'id': 18,
      'title': 'Bed / Room\nAdmission',
      'category': 'Hospital Stay',
      'icon': Icons.hotel_rounded,
      'color': const Color(0xFF3F51B5),
      'badge': null,
      'screen': const BedAdmissionScreen(),
    },
    {
      'id': 35,
      'title': 'OPD / IPD\nVisits',
      'category': 'Hospital Stay',
      'icon': Icons.meeting_room_rounded,
      'color': const Color(0xFF00897B),
      'badge': null,
      'screen': const VisitsScreen(),
    },
    {
      'id': 19,
      'title': 'Bill\nPayments',
      'category': 'Bills & Insurance',
      'icon': Icons.payment_rounded,
      'color': const Color(0xFF43A047),
      'badge': null,
      'screen': const PaymentsScreen(),
    },
    {
      'id': 20,
      'title': 'Bills &\nInvoices',
      'category': 'Bills & Insurance',
      'icon': Icons.receipt_rounded,
      'color': const Color(0xFF1E88E5),
      'badge': null,
      'screen': const BillsInvoicesScreen(),
    },
    {
      'id': 21,
      'title': 'Insurance\nClaims',
      'category': 'Bills & Insurance',
      'icon': Icons.shield_outlined,
      'color': const Color(0xFF1565C0),
      'badge': null,
      'screen': const InsuranceScreen(),
    },
    {
      'id': 6,
      'title': 'Medical\nRecords',
      'category': 'Records & Reminders',
      'icon': Icons.folder_shared_rounded,
      'color': const Color(0xFF1976D2),
      'badge': null,
      'screen': const MedicalRecordsScreen(),
    },
    {
      'id': 22,
      'title': 'Family\nProfiles',
      'category': 'Records & Reminders',
      'icon': Icons.family_restroom_rounded,
      'color': const Color(0xFF1E88E5),
      'badge': null,
      'screen': const FamilyProfilesScreen(),
    },
    {
      'id': 23,
      'title': 'Medicine\nReminder',
      'category': 'Records & Reminders',
      'icon': Icons.alarm_rounded,
      'color': const Color(0xFF00897B),
      'badge': null,
      'screen': const MedicineReminderScreen(),
    },
    {
      'id': 24,
      'title': 'Appt\nReminders',
      'category': 'Records & Reminders',
      'icon': Icons.notifications_active_rounded,
      'color': const Color(0xFFFFA000),
      'badge': null,
      'screen': const NotificationsScreen(),
    },
    {
      'id': 25,
      'title': 'Health\nDocuments',
      'category': 'Records & Reminders',
      'icon': Icons.folder_rounded,
      'color': const Color(0xFF1976D2),
      'badge': null,
      'screen': const HealthDocumentsScreen(),
    },
    {
      'id': 33,
      'title': 'Alerts &\nNotifs',
      'category': 'Records & Reminders',
      'icon': Icons.notifications_none_rounded,
      'color': const Color(0xFF1E88E5),
      'badge': null,
      'screen': const NotificationsScreen(),
    },
    {
      'id': 34,
      'title': 'Health ID\n/ ABHA',
      'category': 'Records & Reminders',
      'icon': Icons.badge_outlined,
      'color': const Color(0xFF263238),
      'badge': null,
      'screen': const ProfileHealthIdScreen(),
    },
    {
      'id': 29,
      'title': 'Support &\nHelpdesk',
      'category': 'Plans & Support',
      'icon': Icons.support_agent_rounded,
      'color': const Color(0xFF1E88E5),
      'badge': null,
      'screen': const SupportTicketScreen(),
    },
    {
      'id': 30,
      'title': 'Ratings &\nFeedback',
      'category': 'Plans & Support',
      'icon': Icons.star_rate_rounded,
      'color': const Color(0xFFFFA000),
      'badge': null,
      'screen': const RatingsFeedbackScreen(),
    },
    {
      'id': 31,
      'title': 'Health\nMembership',
      'category': 'Plans & Support',
      'icon': Icons.card_membership_rounded,
      'color': const Color(0xFF7E57C2),
      'badge': 'PRO',
      'screen': const HealthMembershipScreen(),
    },
    {
      'id': 32,
      'title': 'Offers &\nCoupons',
      'category': 'Plans & Support',
      'icon': Icons.local_offer_rounded,
      'color': const Color(0xFFFF7043),
      'badge': 'OFFER',
      'screen': const OffersCouponsScreen(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final displayedServices = _isExpanded
        ? (_selectedCategory == 'All'
            ? _allServices
            : _allServices.where((s) => s['category'] == _selectedCategory).toList())
        : _allServices.take(8).toList();

    return Container(
      decoration: BoxDecoration(
        color: colorWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderGrey.withValues(alpha: 0.8), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // If expanded, show quick category filter tabs
          if (_isExpanded) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 6),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.grid_view_rounded, color: primaryColor, size: 16),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'All Healthcare Services',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: textDark,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: fillColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${displayedServices.length} items',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ],

          // 4-Column Grid of Healthcare Services
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 14, 10, 8),
            child: AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: displayedServices.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.80,
                ),
                itemBuilder: (context, index) {
                  final item = displayedServices[index];
                  return _buildServiceItem(context, item);
                },
              ),
            ),
          ),

          // Bottom Expand / Collapse Handle & Notch (Matches the screenshot toggle style)
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
                if (!_isExpanded) {
                  _selectedCategory = 'All';
                }
              });
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: _isExpanded ? cardColor.withValues(alpha: 0.5) : colorWhite,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                border: Border(
                  top: BorderSide(
                    color: borderGrey.withValues(alpha: 0.6),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _isExpanded ? 'Show Less' : 'Explore All Services',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(width: 4),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 250),
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: primaryColor.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: primaryColor,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem(BuildContext context, Map<String, dynamic> item) {
    final Color color = item['color'] as Color;
    final IconData icon = item['icon'] as IconData;
    final String title = item['title'] as String;
    final String? badge = item['badge'] as String?;
    final Widget screen = item['screen'] as Widget;

    return AnimatedPressable(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => screen),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon Container with 3D/duotone look & optional badge
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFF4F9FF),
                      Color(0xFFE8F1FC),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: const Color(0xFFD1E4FA),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withValues(alpha: 0.08),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                    BoxShadow(
                      color: Colors.white.withValues(alpha: 0.9),
                      blurRadius: 2,
                      offset: const Offset(-1, -1),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    icon,
                    color: color,
                    size: 26,
                  ),
                ),
              ),
              // Badge if present (like the "new" badge in screenshot)
              if (badge != null)
                Positioned(
                  top: -5,
                  right: -6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1.5),
                    decoration: BoxDecoration(
                      color: badge == 'SOS' || badge == '24/7'
                          ? emergencyRed
                          : (badge == 'LIVE' ? const Color(0xFF00C853) : primaryColor),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Text(
                      badge,
                      style: const TextStyle(
                        color: colorWhite,
                        fontSize: 8,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          // Service Title (Centered, 2 lines)
          Flexible(
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: textDark,
                height: 1.15,
                letterSpacing: -0.1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
