import 'package:akkhara_tracker/models/subscription.dart';
import 'package:akkhara_tracker/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SubscriptionTile extends StatelessWidget {
  final Subscription sub;
  final VoidCallback onPressed;
  const SubscriptionTile(
      {super.key, required this.sub, required this.onPressed});
  double get remainingPercentage {
    int totalDays = 30;
    return sub.remainingDays / totalDays;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(8),
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
                sub.image,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Gap(5),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                sub.name,
                style: GoogleFonts.spaceGrotesk(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        "\$${sub.amount.toStringAsFixed(2)}/",
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
                ],
              ),
            ],
          ),
          const Gap(12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: LinearPercentIndicator(
              addAutomaticKeepAlive: false,
              curve: Curves.bounceInOut,
              padding: EdgeInsets.zero,
              animation: true,
              animationDuration: 1000,
              barRadius: const Radius.circular(15),
              lineHeight: 5,
              percent: remainingPercentage,
              backgroundColor: Colors.black54,
              linearGradient: const LinearGradient(
                colors: [
                  Color(0xffff6041),
                  Color(0xffffd941),
                ],
              ),
            ),
          ),
          const Gap(8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "${sub.remainingDays}",
                      style: GoogleFonts.spaceGrotesk(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      " Days Remain",
                      style: GoogleFonts.spaceGrotesk(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
