import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:vlr/data/repositories/book_appoint_repo.dart';

class BookAppointController extends GetxController implements GetxService {
  final BookAppointRepo bookAppointRepo;
  static const Duration slotInterval = Duration(minutes: 30);

  BookAppointController({required this.bookAppointRepo});

  DateTime selectedDate = DateTime.now();

  String selectedTime = "";
  final Duration appointmentDuration = const Duration(hours: 1);

  DateTime get _today => DateTime.now();

  bool get isSelectedDateToday {
    final today = _today;
    return selectedDate.year == today.year &&
        selectedDate.month == today.month &&
        selectedDate.day == today.day;
  }

  void selectTime(String time) {
    if (!canSelectTime(time)) {
      return;
    }

    selectedTime = time;
    update(["time_slot"]);
  }

  void selectDate(DateTime date) {
    selectedDate = date;
    selectedTime = "";
    generateTimeSlots();
    update(["selected_date", "time_slot"]);
  }

  String openTime = "08:00";
  String closeTime = "20:00";

  List<String> timeSlotList = [];

  int get durationSlotCount {
    final durationInMinutes = appointmentDuration.inMinutes;
    final slotMinutes = slotInterval.inMinutes;
    return ((durationInMinutes + slotMinutes - 1) ~/ slotMinutes).clamp(1, 24);
  }

  DateTime _parseSlotTime(String time) {
    final rawParts = time.split(' ');
    final hmParts = rawParts[0].split(':');
    var hour = int.parse(hmParts[0]);
    final minute = int.parse(hmParts[1]);
    final period = rawParts[1];

    if (period == 'PM' && hour != 12) hour += 12;
    if (period == 'AM' && hour == 12) hour = 0;

    return DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      hour,
      minute,
    );
  }

  bool canSelectTime(String time) {
    final slotStart = _parseSlotTime(time);
    final slotEnd = slotStart.add(appointmentDuration);

    final closeParts = closeTime.split(':');
    final closingDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      int.parse(closeParts[0]),
      int.parse(closeParts[1]),
    );

    if (slotEnd.isAfter(closingDateTime)) {
      return false;
    }

    if (isSelectedDateToday && !slotStart.isAfter(_today)) {
      return false;
    }

    return true;
  }

  bool isTimeSelected(String time) {
    if (selectedTime.isEmpty) {
      return false;
    }

    final selectedStart = _parseSlotTime(selectedTime);
    final selectedEnd = selectedStart.add(appointmentDuration);
    final slotStart = _parseSlotTime(time);

    return !slotStart.isBefore(selectedStart) && slotStart.isBefore(selectedEnd);
  }

  void generateTimeSlots() {
    timeSlotList.clear();

    final openParts = openTime.split(':');
    final closeParts = closeTime.split(':');

    DateTime start = DateTime(
      2025,
      1,
      1,
      int.parse(openParts[0]),
      int.parse(openParts[1]),
    );

    DateTime end = DateTime(
      2025,
      1,
      1,
      int.parse(closeParts[0]),
      int.parse(closeParts[1]),
    );

    final now = _today;

    while (start.isBefore(end) || start == end) {
      final slotDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        start.hour,
        start.minute,
      );

      if (!isSelectedDateToday || slotDateTime.isAfter(now)) {
        timeSlotList.add(formatTime(start));
      }

      start = start.add(slotInterval);
    }

    if (!timeSlotList.contains(selectedTime) ||
        (selectedTime.isNotEmpty && !canSelectTime(selectedTime))) {
      selectedTime = "";
    }

    update(["time_slot"]);
  }

  String formatTime(DateTime time) {
    int hour = time.hour;
    String period = hour >= 12 ? "PM" : "AM";

    hour = hour % 12;
    if (hour == 0) hour = 12;

    return "${hour.toString().padLeft(2, '0')}:"
        "${time.minute.toString().padLeft(2, '0')} $period";
  }
}
