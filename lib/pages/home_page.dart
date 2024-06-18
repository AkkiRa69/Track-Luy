import 'package:akkhara_tracker/components/custome_app_bar.dart';
import 'package:akkhara_tracker/components/expense_tile.dart';
import 'package:akkhara_tracker/components/income_tile.dart';
import 'package:akkhara_tracker/components/my_card.dart';
import 'package:akkhara_tracker/components/my_image_card.dart';
import 'package:akkhara_tracker/models/expense.dart';
import 'package:akkhara_tracker/models/expense_database.dart';
import 'package:akkhara_tracker/models/income.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Color> colors1 = [
    const Color.fromARGB(255, 5, 19, 33),
    const Color(0xff292d32),
  ];

  final List<Color> colors2 = [
    const Color.fromARGB(255, 30, 10, 180),
    const Color.fromARGB(255, 0, 70, 120),
    const Color.fromARGB(255, 20, 80, 150),
  ];
  final List<Color> colors3 = [
    const Color.fromARGB(255, 159, 3, 3),
    const Color.fromARGB(255, 195, 118, 16),
    const Color.fromARGB(255, 231, 95, 5),
  ];

  final PageController _pageController = PageController(viewportFraction: 1);
  final ScrollController _scrollController = ScrollController();

  double totalExpense = 0;
  double totalIncome = 0;
  double totalBalance = 0;

  bool _isFabVisible = false;

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<ExpenseDatabase>().readExpenses();
    context.read<ExpenseDatabase>().readIncome();
    context.read<ExpenseDatabase>().readCate();

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
    return Scaffold(
      body: _buildBody(context),
      floatingActionButton: _isFabVisible
          ? FloatingActionButton(
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
    );
  }

  Widget _buildBody(BuildContext context) {
    List<Expense> expenses = context.watch<ExpenseDatabase>().expenseList;
    List<Income> incomes = context.watch<ExpenseDatabase>().incomeList;
    final combinedList =
        context.watch<ExpenseDatabase>().getCombinedList(expenses, incomes);
    final totalExpense =
        context.watch<ExpenseDatabase>().calculateTotalExpense(expenses);
    final totalIncome =
        context.watch<ExpenseDatabase>().calculateTotalIncome(incomes);
    totalBalance = totalIncome - totalExpense;
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom app bar
            const Padding(
              padding: EdgeInsets.only(right: 20, left: 5, top: 15, bottom: 30),
              child: CustomeAppBar(),
            ),

            // Custom balance
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Card
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return AnimatedBuilder(
                        animation: _pageController,
                        builder: (context, child) {
                          double value = 1.0;
                          if (_pageController.position.haveDimensions) {
                            value = _pageController.page! - index;
                            value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                          }
                          return Center(
                            child: SizedBox(
                              height: Curves.easeOut.transform(value) *
                                  MediaQuery.of(context).size.height *
                                  0.30,
                              width: Curves.easeOut.transform(value) *
                                  MediaQuery.of(context).size.width,
                              child: child,
                            ),
                          );
                        },
                        child: index == 0
                            ? MyCard(
                                totalBalance: totalBalance,
                                colors: colors1,
                                totalIncome: totalIncome,
                              )
                            : MyImageCard(
                                image: index == 1
                                    ? "assets/images/card_back$index.jpg"
                                    : "assets/images/card_back$index.png",
                                totalBalance: totalBalance,
                                totalIncome: totalIncome,
                              ),
                      );
                    },
                  ),
                ),

                // Indicator
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Center(
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: 5,
                      effect: ExpandingDotsEffect(
                        spacing: 5,
                        dotColor: Theme.of(context).colorScheme.tertiary,
                        radius: 10,
                        dotHeight: 8,
                        dotWidth: 8,
                        activeDotColor: Theme.of(context).colorScheme.primary,
                      ), // Customize the indicator effect
                    ),
                  ),
                ),

                // Income and Expenses
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.05,
                      top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //income
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 15, bottom: 15, left: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xffe7fadf),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Color(0xff9fef9a),
                                    shape: BoxShape.circle,
                                  ),
                                  padding: const EdgeInsets.all(12),
                                  child: const Icon(
                                    CupertinoIcons.arrow_up,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Total Incomes"),
                                    Text(
                                      "\$${totalIncome.toStringAsFixed(2)}",
                                      style: GoogleFonts.lato(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      //expense
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffffe3e3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.only(
                              top: 15, bottom: 15, left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xfffd657a),
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(12),
                                child: const Icon(
                                  CupertinoIcons.arrow_down,
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Total Expenses"),
                                  Text(
                                    "\$${totalExpense.toStringAsFixed(2)}",
                                    style: GoogleFonts.lato(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            //expense list
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  bottom: 15,
                  right: MediaQuery.of(context).size.width * 0.05,
                  top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Transactions",
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "VIEW ALL",
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
            ),

            //expense list
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: combinedList.length,
              itemBuilder: (context, index) {
                final transaction = combinedList[index];
                if (transaction.isExpense) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.05,
                        bottom: 15),
                    child: ExpenseTile(
                      expense: transaction.data as Expense,
                    ),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.05,
                        bottom: 15),
                    child: IncomeTile(income: transaction.data as Income),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
