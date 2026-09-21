import 'package:flutter/material.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/theme.dart';

class CouponDetailTapWidget extends StatelessWidget {
  const CouponDetailTapWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 3.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: primaryColor,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 6,
                spreadRadius: -4,
                color: black.withValues(alpha: 0.10),
              ),
              BoxShadow(
                offset: const Offset(0, 10),
                blurRadius: 15,
                spreadRadius: -3,
                color: black.withValues(alpha: 0.10),
              ),
            ],
          ),
        ),
        Positioned(
          right: -40,
          top: -40,
          child: Container(
            height: 192,
            width: 192,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: white.withValues(
                alpha: 0.05,
              ),
            ),
          ),
        ),
        Positioned(
          left: -40,
          bottom: -40,
          child: Container(
            height: 192,
            width: 192,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: white.withValues(
                alpha: 0.05,
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "EXCLUSIVE OFFER",
                  style: Helper(context).textTheme.labelLarge?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.6,
                        color: blueLight6,
                      ),
                ),
                sizedBoxHeight(height: 8),
                Text(
                  "15% OFF",
                  style: Helper(context).textTheme.titleLarge?.copyWith(
                        fontSize: 26,
                        color: blueLight6,
                      ),
                ),
                sizedBoxHeight(height: 20),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: blueLight6.withValues(alpha: 0.20),
                      border: Border.all(
                        width: 1,
                        color: blueLight6.withValues(
                          alpha: 0.30,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "FEETRACK15",
                          style: Helper(context).textTheme.bodySmall?.copyWith(
                                fontSize: 20,
                                color: blueLight6,
                              ),
                        ),
                        sizedBoxWidth(width: 8),
                        Icon(
                          Icons.copy,
                          color: blueLight6,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
                sizedBoxHeight(height: 16),
                Text(
                  "Tap to copy code",
                  style: Helper(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: blueLight6,
                      ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
