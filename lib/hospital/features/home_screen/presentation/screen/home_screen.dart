import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/animated_widgets.dart';
import '../../../../core/widgets/appointment_widget.dart';
import '../../../appointments/presentation/screen/appointment_action_sheet.dart';
import '../../../appointments/presentation/screen/appointments_screen.dart';
import '../../../doctor/presentation/screens/doctor_search_screen.dart';
import '../../../emergency_assistance/presentation/screen/emergency_assistance_screen.dart';
import '../../../lab_reports/presentation/screen/lab_report_detail_screen.dart';
import '../../../medicine_reminder/presentation/screen/medicine_reminder_screen.dart';
import '../widget/banner_widget.dart';
import '../widget/doctor_list_section.dart';
import '../widget/home_action_widget.dart';
import '../widget/home_appbar_widget.dart';
import '../widget/home_specialites_widget.dart';
import 'all_services_screen.dart';

class HospitalHomeScreen extends StatelessWidget {
  const HospitalHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: const HomeAppbarWidget(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              // Interactive Search Bar leading to Doctor & Service Search
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const DoctorSearchScreen()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: colorWhite,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: borderGrey),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.search, color: primaryColor, size: 22),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Search doctor, hospital, specialty, tests...',
                          style: TextStyle(fontSize: 13, color: textMuted),
                        ),
                      ),
                      Icon(Icons.tune, color: primaryColor, size: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Emergency SOS Pulse Banner (Feature 15)
              ModernCard(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                color: emergencyRedBg,
                border: Border.all(color: emergencyRed.withOpacity(0.3)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const EmergencyAssistanceScreen()),
                  );
                },
                child: Row(
                  children: [
                    PulseEffectWidget(
                      pulseColor: emergencyRed,
                      maxRadius: 1.25,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: emergencyRed,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.emergency, color: colorWhite, size: 18),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Emergency SOS & Ambulance (24/7)',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: emergencyRed),
                          ),
                          Text(
                            'Tap for 1-click GPS ambulance dispatch & trauma team',
                            style: TextStyle(fontSize: 10, color: textDark),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 14, color: emergencyRed),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Promotional Banner Slider
              const BannerWidget(),
              const SizedBox(height: 20),

              // Today's Medication Reminder Bar (Feature 23)
              ModernCard(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                color: fillColor.withOpacity(0.6),
                border: Border.all(color: primaryLight.withOpacity(0.4)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MedicineReminderScreen()),
                  );
                },
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.alarm, color: colorWhite, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Next Dose: Amoxicillin 500mg', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: textDark)),
                          Text('Today at 08:30 PM (After Dinner)', style: TextStyle(fontSize: 10, color: primaryDark)),
                        ],
                      ),
                    ),
                    StatusBadgeWidget(label: 'Take Pill', textColor: colorWhite, bgColor: primaryColor),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Medical Specialties Carousel
              const HomeSpecialitesWidget(),
              const SizedBox(height: 20),

              // Action Hub & All 35 Services Grid
              SectionHeader(
                title: 'Healthcare Services',
                actionLabel: 'All 35',
                onAction: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AllServicesScreen()),
                  );
                },
              ),

              const HomeActionWidget(),

              const SizedBox(height: 20),

              // Top Rated Doctors Section
              const DoctorListSection(),
              const SizedBox(height: 16),

              // Upcoming Appointments Section with Interactive Sheet
              SectionHeader(
                title: 'Upcoming Appointment',
                actionLabel: 'View all',
                onAction: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AppointmentsScreen(userId: '1')),
                  );
                },
              ),
              GestureDetector(
                onTap: () {
                  AppointmentActionSheet.showManageAppointment(
                    context,
                    doctorName: 'Dr. Mohamed Saeed',
                    specialty: 'Physical Therapy & Neurology',
                    date: 'Monday, July 21',
                    time: '11:00 AM',
                    onUpdate: () {},
                  );
                },
                child: const AppointmentWidget(
                  doctorName: 'Mohamed Saeed',
                  date: 'Monday, July 21',
                  time: '11:00 Am',
                  status: 'Upcoming',
                  designation: 'Physical Therapy',
                ),
              ),
              const SizedBox(height: 20),

              // Recent Lab Report Widget
              SectionHeader(
                title: 'Recent Diagnostic Report',
                actionLabel: 'View report',
                onAction: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LabReportDetailScreen()),
                  );
                },
              ),
              ModernCard(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LabReportDetailScreen()),
                  );
                },
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: diagnosticVioletBg, borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.science, color: diagnosticViolet, size: 26),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Complete Blood Count (CBC)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: textDark)),
                          Text('Tested on 12 Sep 2026 • Verified by Pathologist', style: TextStyle(fontSize: 11, color: textMuted)),
                        ],
                      ),
                    ),
                    StatusBadgeWidget(label: 'Ready', textColor: wellnessGreen, bgColor: wellnessGreenBg),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
