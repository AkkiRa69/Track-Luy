import 'package:akkhara_tracker/models/expense_database.dart';
import 'package:akkhara_tracker/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class SubBill extends StatelessWidget {
  final double totalAmount;
  const SubBill({super.key, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    double balance = context.watch<ExpenseDatabase>().totalBalance;
    double percent = totalAmount / balance;
    percent = percent.clamp(0.0, 1.0); // Ensure percent is between 0.0 and 1.0

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
              percent: percent,
              center: Text(
                "${(percent * 100).toStringAsFixed(2)}%",
                style: const TextStyle(
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "\$${totalAmount.toStringAsFixed(2)}",
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
