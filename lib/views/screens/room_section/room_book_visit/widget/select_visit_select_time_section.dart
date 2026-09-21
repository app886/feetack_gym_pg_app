import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlr/controllers/book_appoint_controller.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/screens/gym/gym_book_visit/widget/gym_book_container.dart';

class RoomVisitSelectTimeSection extends StatelessWidget {
  const RoomVisitSelectTimeSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Available Time Slots",
          style: Helper(context).textTheme.titleMedium?.copyWith(
                fontSize: 20,
                color: blackText3,
              ),
        ),
        sizedBoxHeight(height: 16),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: white,
              border: Border.all(width: 1, color: greyLight3)),
          child: GetBuilder<BookAppointController>(
            id: "time_slot",
            builder: (bookAppointController) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: bookAppointController.timeSlotList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 2.4,
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
          ),
        )
      ],
    );
  }
}
