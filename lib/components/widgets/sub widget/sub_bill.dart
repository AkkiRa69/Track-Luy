import 'package:akkhara_tracker/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SubBill extends StatelessWidget {
  const SubBill({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        color: AppColors.kindaBlack,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(20),
            child: CircularPercentIndicator(
              radius: 45.0,
              lineWidth: 5.0,
              animation: true,
              percent: 0.7,
              center: const Text(
                "%70",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20.0,
                ),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              linearGradient: const LinearGradient(
                colors: [
                  Color(0xfff57979),
                  Color(0xff4176ff),
                  Color(0xff32e6f6),
                ],
              ),
            ),
          ),
          // const Gap(25),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "\$180.55",
                style: GoogleFonts.lato(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Amount/",
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[300],
                    ),
                  ),
                  Text(
                    "month",
                    style: GoogleFonts.lato(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}