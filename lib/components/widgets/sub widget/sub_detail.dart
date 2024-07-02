import 'package:akkhara_tracker/models/subscription.dart';
import 'package:akkhara_tracker/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SubDetail extends StatelessWidget {
  final Subscription sub;
  final VoidCallback onSwipe;
  const SubDetail({super.key, required this.sub, required this.onSwipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: AppColors.backGround,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            sub.image,
            height: 100,
          ),
          const Gap(10),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: Colors.white,
                )),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              "Premium",
              style: GoogleFonts.spaceGrotesk(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
          const Gap(25),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 20),
                  height: 1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        Colors.white,
                        Colors.white.withOpacity(0.4),
                        Colors.white.withOpacity(0.1),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Details",
                  style: GoogleFonts.spaceGrotesk(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 20),
                  height: 1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.white.withOpacity(0.4),
                        Colors.white.withOpacity(0.1),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      box(
                          80,
                          DateFormat("dd MMM yyyy").format(
                              (sub.startDate).add(const Duration(days: 30))),
                          "Due Date",
                          context),
                      const Gap(20),
                      box(40, "Active", "Staus", context),
                    ],
                  ),
                ),
                const Gap(20),
                Expanded(
                  child: Column(
                    children: [
                      box(40, "Monthly", "Billing Cycle", context),
                      const Gap(20),
                      box(80, "\$${sub.amount.toStringAsFixed(2)}",
                          "Payment Due", context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: SwipeButton.expand(
          height: 55,
          thumbPadding: const EdgeInsets.all(3),
          thumb: const Icon(Icons.double_arrow_rounded, color: Colors.white),
          activeThumbColor: Colors.black,
          activeTrackColor: Colors.white,
          onSwipe: onSwipe,
          child: const Text(
            "Swipe to pay",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget box(double gap, String sub, String title, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade800,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.spaceGrotesk(
              color: Colors.grey,
            ),
          ),
          Gap(gap),
          Text(
            sub,
            style: GoogleFonts.spaceGrotesk(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
