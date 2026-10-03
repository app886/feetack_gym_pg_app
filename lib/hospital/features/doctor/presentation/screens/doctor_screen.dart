import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../widget/doctor_show_data_widget.dart';
import 'doctor_detail_screen.dart';


class DoctorScreen extends StatefulWidget {
  final String? initialSpecialty;
  const DoctorScreen({Key? key, this.initialSpecialty}) : super(key: key);

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  late String selectedSpecialty;

  final List<Map<String, dynamic>> specialties = [
    {'name': 'All', 'icon': Icons.grid_view},
    {'name': 'Neurology', 'icon': Icons.psychology},
    {'name': 'Phoniatrics', 'icon': Icons.record_voice_over},
    {'name': 'Endocrinology', 'icon': Icons.opacity},
    {'name': 'Dentist', 'icon': Icons.medical_services},
    {'name': 'Nephrologist', 'icon': Icons.bloodtype},
    {'name': 'Oncologist', 'icon': Icons.biotech},
  ];

  final List<Map<String, dynamic>> allDoctors = [
    {
      'name': 'Dr. Jane Cooper',
      'specialty': 'Dentist',
      'rating': 4.8,
      'reviews': 49,
    },
    {
      'name': 'Dr. Jonny Wilson',
      'specialty': 'Dentist',
      'rating': 4.9,
      'reviews': 4956,
    },
    {
      'name': 'Dr. Jacob Jones',
      'specialty': 'Nephrologist',
      'rating': 4.7,
      'reviews': 120,
    },
    {
      'name': 'Dr. Guy Hawkins',
      'specialty': 'Oncologist',
      'rating': 4.9,
      'reviews': 85,
    },
    {
      'name': 'Dr. Sarah Connor',
      'specialty': 'Neurology',
      'rating': 4.6,
      'reviews': 210,
    },
    {
      'name': 'Dr. Mike Ross',
      'specialty': 'Endocrinology',
      'rating': 4.5,
      'reviews': 150,
    },
  ];

  @override
  void initState() {
    super.initState();
    selectedSpecialty = widget.initialSpecialty ?? 'All';
  }

  @override
  Widget build(BuildContext context) {
    // Filter doctors based on selected specialty
    final filteredDoctors = selectedSpecialty == 'All'
        ? allDoctors
        : allDoctors.where((doc) => doc['specialty'] == selectedSpecialty).toList();

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: const Text(
          'Professional Doctors',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: Column(
        children: [
          // Horizontal Specialty List
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: specialties.length,
              itemBuilder: (context, index) {
                final specialty = specialties[index];
                final isSelected = selectedSpecialty == specialty['name'];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedSpecialty = specialty['name'];
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected ? primaryColor : Colors.grey[300]!,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        specialty['name'],
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Doctors List
          Expanded(
            child: filteredDoctors.isEmpty
                ? const Center(child: Text('No doctors found for this specialty'))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredDoctors.length,
                    itemBuilder: (context, index) {
                      final doctor = filteredDoctors[index];
                      return DoctorShowDataWidget(
                        name: doctor['name'],
                        specialty: doctor['specialty'],
                        rating: doctor['rating'],
                        reviews: doctor['reviews'],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoctorDetailScreen(
                                name: doctor['name'],
                                specialty: doctor['specialty'], doctorName: null, hospital: null, rating: null, reviewsCount: null,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
