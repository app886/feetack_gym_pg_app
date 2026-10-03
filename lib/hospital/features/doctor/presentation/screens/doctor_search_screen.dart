import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/animated_widgets.dart';
import 'doctor_detail_screen.dart';
// import 'package:hospital_management_system/core/constants/colors.dart';
// import 'package:hospital_management_system/core/widgets/animated_widgets.dart';
// import 'package:hospital_management_system/features/doctor/presentation/screens/doctor_detail_screen.dart';

class DoctorSearchScreen extends StatefulWidget {
  const DoctorSearchScreen({Key? key}) : super(key: key);

  @override
  State<DoctorSearchScreen> createState() => _DoctorSearchScreenState();
}

class _DoctorSearchScreenState extends State<DoctorSearchScreen> {
  String _searchQuery = '';
  String _selectedSpecialty = 'All';
  String _selectedHospital = 'All';

  final List<String> _specialties = [
    'All',
    'Cardiology',
    'Neurology',
    'Orthopedics',
    'Pediatrics',
    'Dermatology',
    'General Medicine'
  ];

  final List<String> _hospitals = [
    'All',
    'City Care Hospital',
    'Apollo Medical Center',
    'St. Jude Memorial',
    'Global Health Clinic'
  ];

  final List<Map<String, dynamic>> _doctors = [
    {
      'id': '1',
      'name': 'Dr. Mohamed Saeed',
      'specialty': 'Neurology',
      'hospital': 'City Care Hospital',
      'rating': 4.9,
      'reviews': 128,
      'experience': '12 yrs exp',
      'fee': '\$40',
      'availability': 'Today, 04:00 PM',
      'imageUrl': 'https://images.unsplash.com/photo-1622253692010-333f2da6031d?w=150',
    },
    {
      'id': '2',
      'name': 'Dr. Sarah Jenkins',
      'specialty': 'Cardiology',
      'hospital': 'Apollo Medical Center',
      'rating': 4.8,
      'reviews': 95,
      'experience': '9 yrs exp',
      'fee': '\$55',
      'availability': 'Tomorrow, 10:30 AM',
      'imageUrl': 'https://images.unsplash.com/photo-1594824813589-98308479e49c?w=150',
    },
    {
      'id': '3',
      'name': 'Dr. Michael Chang',
      'specialty': 'Orthopedics',
      'hospital': 'St. Jude Memorial',
      'rating': 4.7,
      'reviews': 140,
      'experience': '15 yrs exp',
      'fee': '\$50',
      'availability': 'Today, 06:00 PM',
      'imageUrl': 'https://images.unsplash.com/photo-1537368910025-700350fe46c7?w=150',
    },
    {
      'id': '4',
      'name': 'Dr. Emily Watson',
      'specialty': 'Pediatrics',
      'hospital': 'Global Health Clinic',
      'rating': 5.0,
      'reviews': 210,
      'experience': '8 yrs exp',
      'fee': '\$35',
      'availability': 'Today, 02:00 PM',
      'imageUrl': 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=150',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredDoctors = _doctors.where((doc) {
      final matchesSearch = doc['name'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
          doc['specialty'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
          doc['hospital'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesSpecialty = _selectedSpecialty == 'All' || doc['specialty'] == _selectedSpecialty;
      final matchesHospital = _selectedHospital == 'All' || doc['hospital'] == _selectedHospital;
      return matchesSearch && matchesSpecialty && matchesHospital;
    }).toList();

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: const Text('Search Doctors', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: colorWhite)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: colorWhite, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Search & Filters Header
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: colorWhite,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    onChanged: (val) => setState(() => _searchQuery = val),
                    decoration: const InputDecoration(
                      hintText: 'Search by doctor name, specialty, clinic...',
                      hintStyle: TextStyle(color: textMuted, fontSize: 13),
                      prefixIcon: Icon(Icons.search, color: primaryColor),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Specialty Filters
                SizedBox(
                  height: 32,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _specialties.length,
                    itemBuilder: (context, index) {
                      final spec = _specialties[index];
                      final isSelected = spec == _selectedSpecialty;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(spec),
                          labelStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? primaryColor : colorWhite,
                          ),
                          selected: isSelected,
                          selectedColor: colorWhite,
                          backgroundColor: Colors.white.withOpacity(0.2),
                          checkmarkColor: primaryColor,
                          onSelected: (val) {
                            setState(() => _selectedSpecialty = spec);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Search Stats
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${filteredDoctors.length} Doctors Available',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: textDark),
                ),
                DropdownButton<String>(
                  value: _selectedHospital,
                  isDense: true,
                  underline: const SizedBox(),
                  icon: const Icon(Icons.keyboard_arrow_down, color: primaryColor, size: 20),
                  items: _hospitals.map((h) => DropdownMenuItem(value: h, child: Text(h, style: const TextStyle(fontSize: 12)))).toList(),
                  onChanged: (val) => setState(() => _selectedHospital = val ?? 'All'),
                ),
              ],
            ),
          ),

          // Doctor List
          Expanded(
            child: filteredDoctors.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person_search, size: 60, color: colorGrey.withOpacity(0.5)),
                        const SizedBox(height: 12),
                        const Text('No doctors match your criteria', style: TextStyle(color: textMuted, fontSize: 14)),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: filteredDoctors.length,
                    itemBuilder: (context, index) {
                      final doc = filteredDoctors[index];
                      return FadeSlideTransitionWidget(
                        index: index,
                        child: ModernCard(
                          margin: const EdgeInsets.only(bottom: 12),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DoctorDetailScreen(
                                  doctorName: doc['name'],
                                  specialty: doc['specialty'],
                                  hospital: doc['hospital'],
                                  rating: doc['rating'],
                                  reviewsCount: doc['reviews'],

                                  // experienceYears: 10,
                                  // consultationFee: doc['fee'],
                                ),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 32,
                                backgroundColor: fillColor,
                                backgroundImage: NetworkImage(doc['imageUrl']),
                                onBackgroundImageError: (_, __) {},
                                child: const Icon(Icons.person, color: primaryColor, size: 30),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            doc['name'],
                                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: textDark),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                                            Text(' ${doc['rating']}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${doc['specialty']} • ${doc['experience']}',
                                      style: const TextStyle(color: primaryColor, fontSize: 12, fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      doc['hospital'],
                                      style: const TextStyle(color: textMuted, fontSize: 11),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        StatusBadgeWidget(
                                          label: doc['availability'],
                                          textColor: wellnessGreen,
                                          bgColor: wellnessGreenBg,
                                          icon: Icons.access_time_rounded,
                                        ),
                                        Text(
                                          doc['fee'],
                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: textDark),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
