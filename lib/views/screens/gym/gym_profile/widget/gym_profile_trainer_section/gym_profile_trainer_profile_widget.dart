import 'package:flutter/material.dart';
import 'package:vlr/data/models/category_model/staff_model.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/base/custom_image.dart';
import 'package:vlr/views/screens/gym/gym_trainer_profile_screen/gym_trainer_profile_screen.dart';

class GYmProfileTrainerProfileWidget extends StatelessWidget {
  final StaffModel staffModel;
  const GYmProfileTrainerProfileWidget({
    super.key,
    required this.staffModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigate(
          context: context,
          page: GymTrainerProfileScreen(
            staffId: staffModel.id?.toString(),
          ),
        );
      },
      child: Container(
        width: 192,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: greyLight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImage(
              path: staffModel.photoUrl ?? "",
              width: 168,
              height: 160,
              radius: 32,
              fit: BoxFit.cover,
            ),
            sizedBoxHeight(height: 12),
            Text(
              staffModel.name ?? "",
              style: Helper(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: blackText1,
                  ),
            ),
            sizedBoxHeight(height: 4),
            Row(
              children: [
                Flexible(
                  child: Text(
                    "${staffModel.specialization ?? ""}  ",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Helper(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: blackText1,
                        ),
                  ),
                ),
                Icon(
                  Icons.circle,
                  size: 4,
                  color: greyText2,
                ),
                Flexible(
                  child: Text(
                    "  ${staffModel.experienceYears ?? ""} ",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Helper(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: blackText1,
                        ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
