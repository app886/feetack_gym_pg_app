import 'package:flutter/material.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';
import 'package:vlr/views/base/common_button.dart';
import 'package:vlr/views/base/custom_image.dart';
import 'package:vlr/views/screens/room_section/Pg/select_sharing_type/widget/pg_included_row.dart';

class ShareTypeOfPg extends StatelessWidget {
  final PgShareDetails pgShareDetailsModel;
  final Function()? onTap;

  const ShareTypeOfPg({
    super.key,
    required this.pgShareDetailsModel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: white,
          boxShadow: [
            BoxShadow(
              color: black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
              width: 1,
              color: pgShareDetailsModel.mostPopular ? greenDark : greyLight6)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CustomImage(
                path: pgShareDetailsModel.imagePath,
                height: MediaQuery.of(context).size.height / 3.5,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 16,
                left: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 14,
                  ),
                  decoration: BoxDecoration(
                    color: black.withValues(alpha: 0.60),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    pgShareDetailsModel.badgeLabel,
                    style: Helper(context).textTheme.bodySmall?.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: white,
                          letterSpacing: 0.5,
                        ),
                  ),
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: pgShareDetailsModel.mostPopular
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 14,
                        ),
                        decoration: BoxDecoration(
                          color: greenDark,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          "MOST POPULAR",
                          style:
                              Helper(context).textTheme.titleMedium?.copyWith(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: white,
                                  ),
                        ),
                      )
                    : SizedBox(),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: greyLight5,
                      ),
                      child: Icon(
                        pgShareDetailsModel.icon,
                        color: primaryText1,
                        size: 28,
                      ),
                    ),
                    sizedBoxWidth(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pgShareDetailsModel.title,
                            style:
                                Helper(context).textTheme.titleMedium?.copyWith(
                                      fontSize: 20,
                                      color: blackText3,
                                    ),
                          ),
                          Text(
                            pgShareDetailsModel.shareLabel,
                            style: pgShareDetailsModel.mostPopular
                                ? Helper(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontSize: 16,
                                      color: greenDark,
                                    )
                                : Helper(context).textTheme.bodySmall?.copyWith(
                                      fontSize: 16,
                                      color: blackText3,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                sizedBoxHeight(height: 8),
                Text(
                  pgShareDetailsModel.description,
                  style: Helper(context).textTheme.bodySmall?.copyWith(
                        fontSize: 16,
                        color: greyDart2,
                      ),
                ),
                sizedBoxHeight(height: 24),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: pgShareDetailsModel.mostPopular
                        ? greenDark.withValues(alpha: 0.30)
                        : pinLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Starts from",
                        style: Helper(context).textTheme.bodySmall?.copyWith(
                              fontSize: 16,
                              color: blackText3,
                            ),
                      ),
                      sizedBoxHeight(height: 3),
                      RichText(
                        text: TextSpan(
                          text: pgShareDetailsModel.priceLabel,
                          style:
                              Helper(context).textTheme.titleMedium?.copyWith(
                                    fontSize: 16,
                                    color: blackText3,
                                  ),
                          children: [
                            TextSpan(
                              text: " /month",
                              style: Helper(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontSize: 16,
                                    color: greyDart2,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      sizedBoxHeight(height: 3),
                      Text(
                        pgShareDetailsModel.depositLabel,
                        style: Helper(context).textTheme.bodySmall?.copyWith(
                              fontSize: 11,
                              color: const Color(0xFF737686),
                            ),
                      ),
                    ],
                  ),
                ),
                sizedBoxHeight(height: 24),
                Text(
                  "What's included:",
                  style: Helper(context).textTheme.titleMedium?.copyWith(
                        fontSize: 16,
                        color: blackText3,
                      ),
                ),
                sizedBoxHeight(height: 12),
                ListView.separated(
                  itemBuilder: (context, index) {
                    return PgIncludedRow(
                      title: pgShareDetailsModel.includedItems[index],
                    );
                  },
                  separatorBuilder: (_, __) => sizedBoxHeight(height: 8),
                  itemCount: pgShareDetailsModel.includedItems.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                ),
                sizedBoxHeight(height: 56),
                CustomButton(
                  radius: 12,
                  onTap: onTap,
                  color: pgShareDetailsModel.mostPopular
                      ? greenDark
                      : primaryColor,
                  borderColor: pgShareDetailsModel.mostPopular
                      ? greenDark
                      : primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Book This Room",
                        style: Helper(context).textTheme.titleMedium?.copyWith(
                              fontSize: 16,
                              color: white,
                            ),
                      ),
                      sizedBoxWidth(width: 8),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: white,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PgShareDetails {
  final String title;
  final String shareLabel;
  final String description;
  final String badgeLabel;
  final String imagePath;
  final String priceLabel;
  final String depositLabel;
  final IconData icon;
  final List<String> includedItems;
  final bool mostPopular;

  const PgShareDetails({
    required this.title,
    required this.shareLabel,
    required this.description,
    required this.badgeLabel,
    required this.imagePath,
    required this.priceLabel,
    required this.depositLabel,
    required this.icon,
    required this.includedItems,
    required this.mostPopular,
  });
}

const List<PgShareDetails> pgShareDetailsList = [
  PgShareDetails(
    title: "Twin Sharing",
    shareLabel: "2-SHARE ROOM",
    description:
        "Balanced privacy and value with a comfortable room shared by two residents.",
    badgeLabel: "FULLY FURNISHED WITH ATTACHED WASHROOM",
    imagePath: Assets.imagesPgRoom,
    priceLabel: "₹ 14,500",
    depositLabel: "Deposit: 1 month advance (₹14,500)",
    icon: Icons.people_outline_rounded,
    includedItems: [
      "Spacious room for 2 residents",
      "2 cots with premium mattresses",
      "2 study tables and chairs",
      "Shared wardrobe and storage shelves",
      "Daily housekeeping support",
      "Nutritious breakfast and dinner",
      "High-speed Wi-Fi access",
      "Power backup and 24/7 security",
    ],
    mostPopular: false,
  ),
  PgShareDetails(
    title: "Triple Sharing",
    shareLabel: "3-SHARE ROOM",
    description:
        "Affordable community living with dedicated storage, study space, and essential comforts.",
    badgeLabel: "SMART VALUE ROOM WITH BALCONY ACCESS",
    imagePath: Assets.imagesPgRoom,
    priceLabel: "₹ 11,500",
    depositLabel: "Deposit: 1 month advance (₹11,500)",
    icon: Icons.groups_2_outlined,
    includedItems: [
      "Well-ventilated room for 3 residents",
      "3 individual cots and mattresses",
      "Personal lockers for each resident",
      "Shared study desk setup",
      "Attached washroom with geyser",
      "Laundry pickup twice a week",
      "Unlimited Wi-Fi connection",
      "CCTV monitoring and biometric entry",
    ],
    mostPopular: true,
  ),
  PgShareDetails(
    title: "Quad Sharing",
    shareLabel: "4-SHARE ROOM",
    description:
        "Budget-friendly shared stay designed for students and working professionals who want more value.",
    badgeLabel: "BEST FOR GROUP STAY WITH ALL BASICS INCLUDED",
    imagePath: Assets.imagesPgRoom,
    priceLabel: "₹ 9,000",
    depositLabel: "Deposit: 1 month advance (₹9,000)",
    icon: Icons.groups_outlined,
    includedItems: [
      "Comfortable room for 4 residents",
      "4 beds with under-bed storage",
      "Large common wardrobe space",
      "Daily cleaning of room and washroom",
      "Homely meals served twice a day",
      "RO drinking water and refrigerator access",
      "Wi-Fi and common TV lounge",
      "24/7 warden support and security",
    ],
    mostPopular: true,
  ),
];
