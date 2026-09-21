import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:vlr/controllers/common_controller.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/base/custom_image.dart';

class VisitScheduleRoomProfile extends StatelessWidget {
  const VisitScheduleRoomProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
            color: black.withValues(alpha: 0.05),
          )
        ],
        border: Border.all(
          width: 1,
          color: greyLight6,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CustomImage(
                path: Assets.imagesPgRoom,
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 3,
                fit: BoxFit.cover,
                // radius: 16,
              ),
              Positioned(
                bottom: 20,
                left: 20,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: white.withValues(alpha: 0.90),
                  ),
                  child: Text(
                    "Urban Oasis Suite",
                    style: Helper(context).textTheme.titleMedium?.copyWith(
                          fontSize: 20,
                          color: blackText3,
                        ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: primaryColor.withValues(alpha: 0.10),
                      ),
                      child: Icon(
                        Icons.location_on_outlined,
                        color: blueLight3,
                      ),
                    ),
                    sizedBoxWidth(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Location",
                            style:
                                Helper(context).textTheme.labelLarge?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: greyDart2,
                                    ),
                          ),
                          Text(
                            "Koramangala, Bengaluru",
                            style:
                                Helper(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: blackText3,
                                    ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                GetBuilder<CommonController>(builder: (commonController) {
                  return commonController.currentSelectService ==
                          SelectTypeService.pg
                      ? Column(
                          children: [
                            sizedBoxHeight(height: 32),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: primaryColor.withValues(alpha: 0.10),
                                  ),
                                  child: Icon(
                                    Icons.person,
                                    color: blueLight3,
                                  ),
                                ),
                                sizedBoxWidth(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Sharing Type",
                                        style: Helper(context)
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: greyDart2,
                                            ),
                                      ),
                                      Text(
                                        "Single Sharing",
                                        style: Helper(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: blackText3,
                                            ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                      : const SizedBox();
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
