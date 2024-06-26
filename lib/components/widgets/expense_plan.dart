import 'dart:math' as math;

import 'package:akkhara_tracker/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpensePlan extends StatelessWidget {
  const ExpensePlan({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.kindaBlack,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Expense Plans",
              style: GoogleFonts.lato(
                fontSize: 18,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(15),
            Text(
              "Got expenses? Let us help you plan them effectively and take control of your finances with ease!",
              style: GoogleFonts.lato(
                fontSize: 16,
                color: Colors.grey[400],
                // fontWeight: Font /Weight.bold,
              ),
            ),
            const Gap(25),
            Row(
              children: [
                Expanded(
                  child: Transform.rotate(
                    angle: math.pi / 3, // Rotate 90 degrees
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                const Gap(15),
                Expanded(
                  child: Transform.rotate(
                    angle: math.pi / 4, // Rotate 90 degrees
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Column(
                        children: [],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(15),
            SwipeButton.expand(
              height: 55,
              thumbPadding: const EdgeInsets.all(5),
              thumb: const Icon(
                Icons.double_arrow_rounded,
                color: Colors.white,
              ),
              activeThumbColor: AppColors.red,
              activeTrackColor: AppColors.blue,
              onSwipe: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Swipped"),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text(
                "Swipe to create your plan",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
