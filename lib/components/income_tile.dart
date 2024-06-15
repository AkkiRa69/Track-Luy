import 'package:akkhara_tracker/helper/date_cal.dart';
import 'package:akkhara_tracker/models/income.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class IncomeTile extends StatelessWidget {
  final Income income;
  const IncomeTile({super.key, required this.income});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Color(0xff2f2f2f),
                    // borderRadius: BorderRadius.circular(10),
                    shape: BoxShape.circle),
                padding: const EdgeInsets.all(18),
                child: Text(
                  income.emoji,
                  style: const TextStyle(fontSize: 28),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    income.des,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    isToday(income.date)
                        ? "Today"
                        : isYesterday(income.date)
                            ? "Yesterday"
                            : DateFormat('MMMM dd, yyyy, EEEE')
                                .format(income.date),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            '+\$${income.amount.toStringAsFixed(2)}',
            style: GoogleFonts.concertOne(
              fontSize: 20,
              color: const Color(0xff9fef9a),
            ),
          ),
        ],
      ),
    );
  }
}
