import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:vlr/controllers/book_appoint_controller.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';

class GYMBookVisiSelectDateSection extends StatefulWidget {
  const GYMBookVisiSelectDateSection({
    super.key,
  });

  @override
  State<GYMBookVisiSelectDateSection> createState() =>
      _GYMBookVisiSelectDateSectionState();
}

class _GYMBookVisiSelectDateSectionState
    extends State<GYMBookVisiSelectDateSection> {
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
                      "1",
                      style: Helper(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            color: textBlue,
                          ),
                    ),
                  ),
                  sizedBoxWidth(width: 14),
                  Text(
                    "Select Date",
                    style: Helper(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: blackText1,
                        ),
                  ),
                ],
              ),
              GetBuilder<BookAppointController>(
                id: "selected_date",
                builder: (bookAppointController) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: greyLight.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.calendar_month_rounded, size: 14, color: textBlue.withValues(alpha: 0.8)),
                        const SizedBox(width: 4),
                        Text(
                          DateFormat('MMM yyyy').format(bookAppointController.selectedDate),
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
            ],
          ),
          sizedBoxHeight(height: 28),
          // Calendar
          GetBuilder<BookAppointController>(
              id: "selected_date",
              builder: (bookAppointController) {
                return SizedBox(
                  height: 95,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 60,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final date = DateTime.now().add(Duration(days: index));
                      final isSelected = DateUtils.isSameDay(
                          date, bookAppointController.selectedDate);
                      final isToday = DateUtils.isSameDay(date, DateTime.now());

                      return Padding(
                        padding: const EdgeInsets.only(right: 14),
                        child: GestureDetector(
                          onTap: () => bookAppointController.selectDate(date),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            width: 62,
                            decoration: BoxDecoration(
                              color: isSelected ? textBlue : white,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: isSelected 
                                    ? textBlue 
                                    : isToday ? textBlue.withValues(alpha: 0.4) : greyLight2.withValues(alpha: 0.4),
                                width: 1.5,
                              ),
                              boxShadow: isSelected ? [
                                BoxShadow(
                                  color: textBlue.withValues(alpha: 0.25),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                )
                              ] : [],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  DateFormat('EEE').format(date).toUpperCase(),
                                  style: Helper(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: isSelected ? white.withValues(alpha: 0.8) : greyDart,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 10,
                                        letterSpacing: 0.6,
                                      ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  date.day.toString(),
                                  style: Helper(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        color: isSelected ? white : blackText1,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 22,
                                      ),
                                ),
                                if (isToday && !isSelected)
                                  Container(
                                    margin: const EdgeInsets.only(top: 4),
                                    width: 5,
                                    height: 5,
                                    decoration: const BoxDecoration(
                                      color: textBlue,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
        ],
      ),
    );
  }
}
