import 'package:flutter/material.dart';

import '../../../../../ecomerce/constants.dart';
import '../../../../core/constants/colors.dart' hide primaryColor;
import '../../../doctor/presentation/screens/doctor_detail_screen.dart';
import '../../../doctor/presentation/screens/doctor_screen.dart';


class DoctorListSection extends StatelessWidget {
  const DoctorListSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> topDoctors = [
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
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Top Doctors',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DoctorScreen()),
                );
              },
              child: Text(
                'View all',
                style: TextStyle(color: primaryColor, fontSize: 12),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 200, // Increased height for more details
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: topDoctors.length,
            itemBuilder: (context, index) {
              final doctor = topDoctors[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DoctorDetailScreen(
                        name: doctor['name'],
                        specialty: doctor['specialty'],
                        doctorName: doctor['name'],
                        hospital: 'Central Hospital',
                        rating: doctor['rating'].toString(),
                        reviewsCount: doctor['reviews'].toString(),
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 140, // Slightly wider for better proportions
                  margin: const EdgeInsets.only(right: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: borderGrey, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                              child: Image.network(
                                'https://i.pravatar.cc/150?u=${doctor['name']}',
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            // Rating Chip
                            Positioned(
                              top: 8,
                              left: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.star, color: Colors.amber, size: 12),
                                    const SizedBox(width: 3),
                                    Text(
                                      doctor['rating'].toString(),
                                      style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: textDark,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.favorite_border, color: primaryColor, size: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              doctor['name'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: textDark,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              doctor['specialty'],
                              style: const TextStyle(
                                color: textMuted,
                                fontSize: 11,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${doctor['reviews']} Reviews',
                              style: const TextStyle(
                                color: primaryColor,
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                              ),
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
    );
  }
}
