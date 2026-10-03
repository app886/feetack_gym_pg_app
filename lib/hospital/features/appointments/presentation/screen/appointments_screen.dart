import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/appointment_widget.dart';


class AppointmentsScreen extends StatefulWidget {
  final String userId;

  const AppointmentsScreen({
    Key? key,
    this.userId = "1",
  }) : super(key: key);

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  // Sample data - in a real app, this would come from an API/Repository
  final List<Map<String, String>> _appointments = [
    {
      'doctorName': 'Mohamed Saeed',
      'date': 'Monday, July 21',
      'time': '11:00 Am',
      'status': 'Upcoming',
      'designation': 'Physical Therapy',
    },
    {
      'doctorName': 'Ahmed Hassan',
      'date': 'Tuesday, July 22',
      'time': '02:30 Pm',
      'status': 'Upcoming',
      'designation': 'Cardiology',
    },
    {
      'doctorName': 'Sara Ali',
      'date': 'Thursday, July 24',
      'time': '09:00 Am',
      'status': 'Upcoming',
      'designation': 'Neurology',
    },
    {
      'doctorName': 'John Smith',
      'date': 'Friday, July 25',
      'time': '04:00 Pm',
      'status': 'Upcoming',
      'designation': 'Dermatology',
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
          'My Appointments',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, size: 20),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _appointments.length,
        itemBuilder: (context, index) {
          final item = _appointments[index];
          return AppointmentWidget(
            doctorName: item['doctorName']!,
            date: item['date']!,
            time: item['time']!,
            status: item['status']!,
            designation: item['designation']!,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          // Logic for booking a new appointment
        },
      ),
    );
  }
}
