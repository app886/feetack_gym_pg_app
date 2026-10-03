import 'package:flutter/material.dart';

import '../../../../../ecomerce/screens/home/views/home_screen.dart';
import '../../../../../ecomerce/screens/profile/views/profile_screen.dart';
import '../../../../core/constants/colors.dart';
import '../../../appointments/presentation/screen/appointments_screen.dart';
import '../../../home_screen/presentation/screen/home_screen.dart';
import '../../../visits/presentation/screen/visits_screen.dart';


class HospitalDashboardScreen extends StatefulWidget {
  final String username;
  final String userId;

  const HospitalDashboardScreen({
    Key? key,
    this.username = "User",
    this.userId = "1",
  }) : super(key: key);

  @override
  State<HospitalDashboardScreen> createState() => _HospitalDashboardScreenState();
}

class _HospitalDashboardScreenState extends State<HospitalDashboardScreen> {
  int _currentIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const HospitalHomeScreen(),
      AppointmentsScreen(userId: widget.userId),
      const VisitsScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: colorWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [
              _buildNavItem(0, Icons.home, 'Home'),
              _buildNavItem(1, Icons.calendar_month_rounded, 'Appointments'),
              _buildNavItem(2, Icons.local_hospital_rounded, 'Visits'),
              _buildNavItem(3, Icons.person_rounded, 'Profile'),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: isSelected ? primaryColor.withOpacity(0.12) : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: isSelected ? primaryColor : colorGrey,
              size: 20,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? primaryColor : colorGrey,
            ),
          ),
        ],
      ),
    );
  }
}
