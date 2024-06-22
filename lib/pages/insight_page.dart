import 'package:akkhara_tracker/components/charts/my_bar_chart1.dart';
import 'package:akkhara_tracker/components/custome_app_bar.dart';
import 'package:akkhara_tracker/components/new_expense_tile.dart';
import 'package:akkhara_tracker/models/expense_database.dart';
import 'package:akkhara_tracker/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class InsightPage extends StatefulWidget {
  const InsightPage({super.key});

  @override
  State<InsightPage> createState() => _InsightPageState();
}

class _InsightPageState extends State<InsightPage> {
  final List weeks = [];

  bool _isFabVisible = false;
  final ScrollController _scrollController = ScrollController();
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<ExpenseDatabase>().readExpenses();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!_isFabVisible) {
          setState(() {
            _isFabVisible = true;
          });
        }
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (_isFabVisible) {
          setState(() {
            _isFabVisible = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final expenses = context.watch<ExpenseDatabase>().expenseList;
    double totalExpense =
        context.watch<ExpenseDatabase>().calculateTotalExpense(expenses);
    return Scaffold(
      floatingActionButton: _isFabVisible
          ? FloatingActionButton(
              backgroundColor: AppColors.kindaBlack,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              onPressed: () {
                setState(() {
                  _isFabVisible = false;
                });
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              child: const Icon(
                Icons.arrow_upward_rounded,
                color: Colors.white,
              ),
            )
          : null,
      backgroundColor: const Color(0xff000000),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: CustomeAppBar(onPressed: () {}),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 25, left: 25),
                child: Text(
                  "Total Expense",
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "\$${totalExpense.toStringAsFixed(2)}",
                      style: GoogleFonts.lato(
                        fontSize: 34,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Text(
                        "USD",
                        style: GoogleFonts.lato(
                          fontSize: 24,
                          color: AppColors.text,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.58,
                child: MyBarChart1(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Text(
                  "Transactions",
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  final expense = expenses[index];
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, bottom: 15),
                    child: NewExpenseTile(expense: expense),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
