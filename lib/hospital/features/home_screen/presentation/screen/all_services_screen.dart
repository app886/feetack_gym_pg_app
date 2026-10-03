import 'package:flutter/material.dart';

import '../../../../../ecomerce/constants.dart';
import '../../../../../ecomerce/screens/notification/view/notificatios_screen.dart';
import '../../../../core/constants/colors.dart' hide primaryColor;
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

class AllServicesScreen extends StatefulWidget {
  const AllServicesScreen({Key? key}) : super(key: key);

  @override
  State<AllServicesScreen> createState() => _AllServicesScreenState();
}

class _AllServicesScreenState extends State<AllServicesScreen> {
  String _searchQuery = '';
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

  final List<Map<String, dynamic>> _services = [
    // Doctor & Consult
    {
      'id': 1,
      'title': 'Doctor Search',
      'desc': 'Search doctors by hospital, specialty & location',
      'category': 'Doctor & Consult',
      'icon': Icons.person_search,
      'color': primaryColor,
      'screen': const DoctorSearchScreen(),
    },
    {
      'id': 2,
      'title': 'Appointment Booking',
      'desc': 'Book, reschedule or cancel appointments',
      'category': 'Doctor & Consult',
      'icon': Icons.calendar_month,
      'color': primaryColor,
      'screen': const AppointmentsScreen(userId: '1'),
    },
    {
      'id': 3,
      'title': 'Online Consultation',
      'desc': 'Live HD video/tele consultation with specialists',
      'category': 'Doctor & Consult',
      'icon': Icons.video_camera_front,
      'color': primaryColor,
      'screen': const OnlineConsultationScreen(),
    },
    {
      'id': 4,
      'title': 'Home Doctor Visit',
      'desc': 'Request certified physician consultation at home',
      'category': 'Doctor & Consult',
      'icon': Icons.home_work,
      'color': primaryColor,
      'screen': const HomeDoctorVisitScreen(),
    },
    {
      'id': 26,
      'title': 'Doctor Follow-up',
      'desc': 'Schedule free or discounted follow-up visits',
      'category': 'Doctor & Consult',
      'icon': Icons.event_repeat,
      'color': primaryColor,
      'screen': const DoctorFollowupScreen(),
    },

    // Diagnostics & Pharmacy
    {
      'id': 5,
      'title': 'Digital Prescription',
      'desc': 'View and download verified e-prescriptions',
      'category': 'Diagnostics & Pharmacy',
      'icon': Icons.receipt_long,
      'color': pharmacyTeal,
      'screen': const DigitalPrescriptionScreen(),
    },
    {
      'id': 7,
      'title': 'Lab Test Booking',
      'desc': 'Book pathology & diagnostic blood tests',
      'category': 'Diagnostics & Pharmacy',
      'icon': Icons.science,
      'color': diagnosticViolet,
      'screen': const LabTestCatalogScreen(),
    },
    {
      'id': 8,
      'title': 'Home Sample Collection',
      'desc': 'Request blood sample collection from home',
      'category': 'Diagnostics & Pharmacy',
      'icon': Icons.home_outlined,
      'color': diagnosticViolet,
      'screen': const HomeSampleCollectionScreen(),
    },
    {
      'id': 9,
      'title': 'Lab Reports',
      'desc': 'View interactive pathology results with normal ranges',
      'category': 'Diagnostics & Pharmacy',
      'icon': Icons.analytics,
      'color': diagnosticViolet,
      'screen': const LabReportDetailScreen(),
    },
    {
      'id': 10,
      'title': 'Medicine Order',
      'desc': 'Order prescribed medications for fast home delivery',
      'category': 'Diagnostics & Pharmacy',
      'icon': Icons.medication,
      'color': pharmacyTeal,
      'screen': const MedicineOrderScreen(),
    },

    // Emergency & Care
    {
      'id': 11,
      'title': 'Ambulance Booking',
      'desc': 'Emergency & non-emergency ambulance GPS dispatch',
      'category': 'Emergency & Care',
      'icon': Icons.airport_shuttle,
      'color': emergencyRed,
      'screen': const AmbulanceBookingScreen(),
    },
    {
      'id': 12,
      'title': 'Home Nursing',
      'desc': 'Book nurse & attendant services (12h/24h shifts)',
      'category': 'Emergency & Care',
      'icon': Icons.elderly,
      'color': careIndigo,
      'screen': const HomeNursingScreen(),
    },
    {
      'id': 13,
      'title': 'Physiotherapy',
      'desc': 'Book home or clinic physical rehab sessions',
      'category': 'Emergency & Care',
      'icon': Icons.accessibility_new,
      'color': wellnessGreen,
      'screen': const PhysiotherapyScreen(),
    },
    {
      'id': 14,
      'title': 'Hospital Search',
      'desc': 'Find hospitals, clinics, beds & departments',
      'category': 'Emergency & Care',
      'icon': Icons.local_hospital,
      'color': primaryColor,
      'screen': const HospitalSearchScreen(),
    },
    {
      'id': 15,
      'title': 'Emergency Assistance',
      'desc': '1-Tap SOS dispatch & emergency helplines',
      'category': 'Emergency & Care',
      'icon': Icons.emergency,
      'color': emergencyRed,
      'screen': const EmergencyAssistanceScreen(),
    },
    {
      'id': 27,
      'title': 'Blood Bank Enquiry',
      'desc': 'Search blood types & partner blood banks',
      'category': 'Emergency & Care',
      'icon': Icons.bloodtype,
      'color': emergencyRed,
      'screen': const BloodBankScreen(),
    },
    {
      'id': 28,
      'title': 'Home Medical Equipment',
      'desc': 'Rent or buy oxygen concentrators, hospital beds',
      'category': 'Emergency & Care',
      'icon': Icons.accessible,
      'color': primaryColor,
      'screen': const MedicalEquipmentScreen(),
    },

    // Hospital Stay & Preventive
    {
      'id': 16,
      'title': 'Health Packages',
      'desc': 'Book full-body checkups & health screening packages',
      'category': 'Hospital Stay',
      'icon': Icons.health_and_safety,
      'color': primaryColor,
      'screen': const HealthPackagesScreen(),
    },
    {
      'id': 17,
      'title': 'Vaccination Booking',
      'desc': 'Schedule adult & child immunizations & certificates',
      'category': 'Hospital Stay',
      'icon': Icons.vaccines,
      'color': pharmacyTeal,
      'screen': const VaccinationScreen(),
    },
    {
      'id': 18,
      'title': 'Bed / Admission Request',
      'desc': 'Send hospital admission and room bed enquiries',
      'category': 'Hospital Stay',
      'icon': Icons.hotel,
      'color': careIndigo,
      'screen': const BedAdmissionScreen(),
    },
    {
      'id': 35,
      'title': 'OPD / IPD Visits',
      'desc': 'View your past and active OPD & IPD consultations',
      'category': 'Hospital Stay',
      'icon': Icons.meeting_room,
      'color': careIndigo,
      'screen': const VisitsScreen(),
    },

    // Bills & Insurance
    {
      'id': 19,
      'title': 'Payments',
      'desc': 'Pay consultation, lab, hospital and medicine bills',
      'category': 'Bills & Insurance',
      'icon': Icons.payment,
      'color': wellnessGreen,
      'screen': const PaymentsScreen(),
    },
    {
      'id': 20,
      'title': 'Bills & Invoices',
      'desc': 'View payment history & download tax invoices',
      'category': 'Bills & Insurance',
      'icon': Icons.receipt,
      'color': primaryColor,
      'screen': const BillsInvoicesScreen(),
    },
    {
      'id': 21,
      'title': 'Insurance Details',
      'desc': 'Store health insurance policy & track cashless claims',
      'category': 'Bills & Insurance',
      'icon': Icons.shield,
      'color': primaryDark,
      'screen': const InsuranceScreen(),
    },

    // Records & Reminders
    {
      'id': 6,
      'title': 'Medical Records',
      'desc': 'Access EHR visit history, diagnoses & vitals',
      'category': 'Records & Reminders',
      'icon': Icons.folder_shared,
      'color': primaryColor,
      'screen': const MedicalRecordsScreen(),
    },
    {
      'id': 22,
      'title': 'Family Profiles',
      'desc': 'Manage family members, children & dependent profiles',
      'category': 'Records & Reminders',
      'icon': Icons.family_restroom,
      'color': primaryColor,
      'screen': const FamilyProfilesScreen(),
    },
    {
      'id': 23,
      'title': 'Medicine Reminder',
      'desc': 'Set medication alarms, pill schedule & adherence',
      'category': 'Records & Reminders',
      'icon': Icons.alarm,
      'color': pharmacyTeal,
      'screen': const MedicineReminderScreen(),
    },
    {
      'id': 24,
      'title': 'Appointment Reminder',
      'desc': 'Configure SMS, WhatsApp & push reminder alerts',
      'category': 'Records & Reminders',
      'icon': Icons.notifications_active,
      'color': ambulanceAmber,
      'screen': const NotificationsScreen(),
    },
    {
      'id': 25,
      'title': 'Health Documents',
      'desc': 'Secure health document vault for reports & scans',
      'category': 'Records & Reminders',
      'icon': Icons.folder,
      'color': primaryColor,
      'screen': const HealthDocumentsScreen(),
    },
    {
      'id': 33,
      'title': 'Notifications',
      'desc': 'Appointment, medicine, report & payment alerts',
      'category': 'Records & Reminders',
      'icon': Icons.notifications,
      'color': primaryColor,
      'screen': const NotificationsScreen(),
    },
    {
      'id': 34,
      'title': 'Profile & Health ID',
      'desc': 'Manage ABHA / Digital Health ID card & emergency data',
      'category': 'Records & Reminders',
      'icon': Icons.badge,
      'color': textDark,
      'screen': const ProfileHealthIdScreen(),
    },

    // Plans & Support
    {
      'id': 29,
      'title': 'Support / Ticket',
      'desc': 'Raise complaints, requests & 24/7 helpdesk',
      'category': 'Plans & Support',
      'icon': Icons.support_agent,
      'color': primaryColor,
      'screen': const SupportTicketScreen(),
    },
    {
      'id': 30,
      'title': 'Ratings & Feedback',
      'desc': 'Rate completed doctor visits & hospital services',
      'category': 'Plans & Support',
      'icon': Icons.star_rate,
      'color': Colors.amber,
      'screen': const RatingsFeedbackScreen(),
    },
    {
      'id': 31,
      'title': 'Health Membership',
      'desc': 'Purchase monthly/yearly family healthcare plans',
      'category': 'Plans & Support',
      'icon': Icons.card_membership,
      'color': diagnosticViolet,
      'screen': const HealthMembershipScreen(),
    },
    {
      'id': 32,
      'title': 'Offers & Coupons',
      'desc': 'Access eligible healthcare discount vouchers',
      'category': 'Plans & Support',
      'icon': Icons.local_offer,
      'color': offerOrange,
      'screen': const OffersCouponsScreen(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _services.where((s) {
      final matchQuery = s['title'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
          s['desc'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
      final matchCat = _selectedCategory == 'All' || s['category'] == _selectedCategory;
      return matchQuery && matchCat;
    }).toList();

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: const Text('All Healthcare Services', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: colorWhite)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: colorWhite, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Header search
          Container(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
            color: primaryColor,
            child: Column(
              children: [
                TextField(
                  onChanged: (val) => setState(() => _searchQuery = val),
                  decoration: InputDecoration(
                    hintText: 'Search across all 35 healthcare services...',
                    hintStyle: const TextStyle(fontSize: 13, color: textMuted),
                    prefixIcon: const Icon(Icons.search, color: primaryColor),
                    filled: true,
                    fillColor: colorWhite,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 32,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      final cat = _categories[index];
                      final isSelected = _selectedCategory == cat;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(cat),
                          labelStyle: TextStyle(
                            fontSize: 11,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? primaryColor : colorWhite,
                          ),
                          selected: isSelected,
                          selectedColor: colorWhite,
                          backgroundColor: Colors.white.withOpacity(0.2),
                          checkmarkColor: primaryColor,
                          onSelected: (val) => setState(() => _selectedCategory = cat),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Services Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.15,
              ),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final s = filtered[index];
                final Color color = s['color'] as Color;

                return FadeSlideTransitionWidget(
                  index: index,
                  child: ModernCard(
                    padding: const EdgeInsets.all(12),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => s['screen'] as Widget),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(10)),
                              child: Icon(s['icon'] as IconData, color: color, size: 22),
                            ),
                            Text('#${s['id']}', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color.withOpacity(0.6))),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          s['title'] as String,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: textDark),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          s['desc'] as String,
                          style: const TextStyle(fontSize: 10, color: textMuted),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
