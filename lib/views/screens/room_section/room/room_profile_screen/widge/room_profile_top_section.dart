import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:vlr/controllers/room_controller.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/base/custom_image.dart';

class AddFavWidget extends StatelessWidget {
  const AddFavWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoomController>(builder: (roomController) {
      return GestureDetector(
        onTap: () {
          roomController.isAddFavorite = !roomController.isAddFavorite;
          roomController.update();
        },
        child: CircleAvatar(
          radius: 20,
          backgroundColor: white,
          child: Icon(
            roomController.isAddFavorite
                ? Icons.favorite
                : Icons.favorite_border_outlined,
            size: 22,
            color: redDark,
          ),
        ),
      );
    });
  }
}

class RoomProfileTopSection extends StatelessWidget {
  const RoomProfileTopSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoomController>(builder: (roomController) {
      final room = roomController.selectedRoomDetails;
      final listing = room?.listing;
      final rating = listing?.rating?.average ?? 0.0;
      final ratingCount = listing?.rating?.count ?? 0;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 1),
                        blurRadius: 2,
                        spreadRadius: 0,
                        color: black.withValues(alpha: 0.05),
                      )
                    ]),
                child: CustomImage(
                  path: (room?.images != null && room!.images!.isNotEmpty)
                      ? room.images![0].url ?? Assets.imagesHomeProfile
                      : Assets.imagesHomeProfile,
                  height: MediaQuery.of(context).size.height / 3,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const Positioned(
                top: 16,
                right: 16,
                child: AddFavWidget(),
              ),
            ],
          ),
          sizedBoxHeight(height: 12),
          Text(
            listing?.title ?? "Urban Oasis Suite",
            style: Helper(context).textTheme.titleMedium?.copyWith(
                  fontSize: 24,
                  color: blackText3,
                ),
          ),
          if (room?.roomNumber != null)
            Text(
              "Room ${room!.roomNumber} (${room.roomType ?? ''})",
              style: Helper(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          sizedBoxHeight(height: 4),
          Row(
            children: [
               Icon(
                Icons.location_on_outlined,
                color: greyDart2,
                size: 16,
              ),
              sizedBoxWidth(width: 6),
              Expanded(
                child: Text(
                  listing?.address ?? "Koramangala, Bengaluru",
                  style: Helper(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        color: blackText3,
                      ),
                ),
              ),
            ],
          ),
          sizedBoxHeight(height: 6),
          Row(
            children: [
              const Icon(
                Icons.star,
                color: greenDark,
                size: 14,
              ),
              sizedBoxWidth(width: 6),
              Text(
                rating > 0 ? rating.toStringAsFixed(1) : "New",
                style: Helper(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 12,
                      color: blackText1,
                    ),
              ),
              sizedBoxWidth(width: 6),
              Text(
                "($ratingCount Rating)",
                style: Helper(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 12,
                      color: blackText1,
                    ),
              ),
            ],
          ),
          sizedBoxHeight(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (room?.startingPrice != null)
                RichText(
                  text: TextSpan(
                    text: "₹${room!.startingPrice}",
                    style: Helper(context).textTheme.titleMedium?.copyWith(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: primaryColor,
                        ),
                    children: [
                      TextSpan(
                        text: " / month onwards",
                        style: Helper(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: greyDart2,
                            ),
                      )
                    ],
                  ),
                ),
              if (room?.securityDeposit != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    "Security Deposit: ₹${room!.securityDeposit}",
                    style: Helper(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: redDark,
                        ),
                  ),
                ),
            ],
          ),
        ],
      );
    });
  }
}
