import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:vlr/controllers/book_appoint_controller.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/screens/gym/gym_book_visit/widget/gym_book_container.dart';

class GYMBookVisiSelectTimeSection extends StatelessWidget {
  const GYMBookVisiSelectTimeSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 24,
            spreadRadius: 0,
            color: black.withValues(alpha: 0.06),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: textBlue.withValues(alpha: 0.08),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "2",
                      style: Helper(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            color: textBlue,
                          ),
                    ),
                  ),
                  sizedBoxWidth(width: 14),
                  Text(
                    "Select Time Slot",
                    style: Helper(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: blackText1,
                        ),
                  ),
                ],
              ),

            ],
          ),
          sizedBoxHeight(height: 15),
          GetBuilder<BookAppointController>(
              id: "time_slot",
              builder: (bookAppointController) {
                if (bookAppointController.selectedTime.isEmpty) return const SizedBox.shrink();
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: textBlue.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check_circle_rounded, size: 14, color: textBlue),
                      const SizedBox(width: 4),
                      Text(
                        bookAppointController.selectedTime,
                        style: Helper(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                          color: textBlue,
                        ),
                      ),
                    ],
                  ),
                );
              }
          ),
          sizedBoxHeight(height: 15),
          GetBuilder<BookAppointController>(
            id: "time_slot",
            builder: (bookAppointController) {
              if (bookAppointController.timeSlotList.isEmpty) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
                  decoration: BoxDecoration(
                    color: greyLight.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: greyLight2.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.event_busy_rounded, color: greyDart.withValues(alpha: 0.5), size: 32),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "No slots available",
                        style: Helper(context).textTheme.titleSmall?.copyWith(
                          color: blackText1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Try selecting another date",
                        style: Helper(context).textTheme.bodySmall?.copyWith(
                          color: greyDart,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: bookAppointController.timeSlotList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 2.3,
                ),
                itemBuilder: (context, index) {
                  final time = bookAppointController.timeSlotList[index];
                  final isEnabled = bookAppointController.canSelectTime(time);

                  return GestureDetector(
                    onTap: isEnabled
                        ? () {
                            bookAppointController.selectTime(time);
                          }
                        : null,
                    child: TimeSlotContainer(
                      key: ValueKey(time),
                      isSelected: bookAppointController.isTimeSelected(time),
                      isEnabled: isEnabled,
                      time: time,
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
