import 'package:akkhara_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ExpenseTile extends StatelessWidget {
  final Expense expense;
  const ExpenseTile({super.key, required this.expense});

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
                  expense.emoji,
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
                    expense.des,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    isToday(expense.date)
                        ? "Today"
                        : isYesterday(expense.date)
                            ? "Yesterday"
                            : DateFormat('MMMM dd, yyyy, EEEE')
                                .format(expense.date),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            '-\$${expense.amount.toStringAsFixed(2)}',
            style: GoogleFonts.concertOne(
              fontSize: 20,
              color: const Color(0xfffd657a),
            ),
          ),
        ],
      ),
    );
  }
}

bool isToday(DateTime date) {
  final now = DateTime.now();
  return date.year == now.year &&
      date.month == now.month &&
      date.day == now.day;
}

bool isYesterday(DateTime date) {
  final yesterday = DateTime.now().subtract(const Duration(days: 1));
  return date.year == yesterday.year &&
      date.month == yesterday.month &&
      date.day == yesterday.day;
}
