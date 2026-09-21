import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/book_appoint_controller.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/screens/gym/gym_book_visit/gym_my_visit_list_screen.dart';
import 'package:vlr/views/screens/gym/gym_book_visit_success/gym_book_visit_success_screen.dart';
import 'package:vlr/views/screens/gym/gym_select_plan_screen.dart/widget/gym_select_batch_button_section.dart';
import 'package:vlr/controllers/visit_controller.dart';
import 'package:vlr/controllers/home_controller.dart';
import 'widget/gym_book_visit_gym_profile_section.dart';
import 'widget/gym_book_visit_select_date_section.dart';
import 'widget/gym_book_visit_select_time_section.dart';

class GymBookVisitScreen extends StatefulWidget {
  const GymBookVisitScreen({super.key});

  @override
  State<GymBookVisitScreen> createState() => _GymBookVisitScreenState();
}

class _GymBookVisitScreenState extends State<GymBookVisitScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<BookAppointController>().generateTimeSlots();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: black.withValues(alpha: 0.05),
        title: Text(
          "Book a Visit",
          style: Helper(context).textTheme.bodyMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: primaryText1,
              ),
        ),
      ),
      body: SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child: Column(
          children: [
            const GYMBookingVisitGYMProfile(),
            sizedBoxHeight(height: 32),
            const GYMBookVisiSelectDateSection(),
            sizedBoxHeight(height: 32),
            const GYMBookVisiSelectTimeSection(),
          ],
        ),
      ),
      bottomNavigationBar: GetBuilder<VisitController>(builder: (visitController) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GymSelectPackageButtonSection(
              title: "BOOK VISIT",
              isLoading: visitController.isLoading,
              onTap: () {
                final bookController = Get.find<BookAppointController>();
                final homeController = Get.find<HomeController>();

                if (bookController.selectedTime.isEmpty) {
                  showToast(
                      message: "Please select a time slot",
                      toastType: ToastType.error);
                  return;
                }

                final String formattedDate =
                    "${bookController.selectedDate.year}-${bookController.selectedDate.month.toString().padLeft(2, '0')}-${bookController.selectedDate.day.toString().padLeft(2, '0')}";

                // Assuming bookController.selectedTime is like '08:00 AM', the API needs HH:MM
                final timeParts = bookController.selectedTime.split(' ');
                final hm = timeParts[0].split(':');
                int hr = int.parse(hm[0]);
                if (timeParts.length > 1) {
                  if (timeParts[1] == 'PM' && hr != 12) hr += 12;
                  if (timeParts[1] == 'AM' && hr == 12) hr = 0;
                }
                final formattedTime = "${hr.toString().padLeft(2, '0')}:${hm[1]}";

                visitController
                    .createVisit(
                  listingId: homeController.selectListingModel?.id ?? "",
                  visitDate: formattedDate,
                  visitTime: formattedTime,
                )
                    .then((value) {
                  if (value.isSuccess) {
                    showToast(message: value.message, typeCheck: true);
                    navigate(
                        context: context,
                        page: const GymMyVisitListScreen(),
                        isReplace: true);
                  } else {
                    showToast(message: value.message, toastType: ToastType.error);
                  }
                });
              },
            ),
          ],
        );
      }),
    );
  }
}
