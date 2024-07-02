import 'package:akkhara_tracker/models/subscription.dart';
import 'package:akkhara_tracker/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class TrendingTile extends StatelessWidget {
  final double gap;
  final Subscription trend;
  final VoidCallback onPressed;
  const TrendingTile(
      {super.key,
      required this.gap,
      required this.trend,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          // color: const Color.fromARGB(255, 237, 167, 167),
          color: AppColors.kindaBlack,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppColors.backGround,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  trend.image,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Gap(gap),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trend.name,
                  style: GoogleFonts.spaceGrotesk(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "\$${trend.amount.toStringAsFixed(2)}/",
                          style: GoogleFonts.spaceGrotesk(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "month",
                          style: GoogleFonts.spaceGrotesk(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: onPressed,
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
