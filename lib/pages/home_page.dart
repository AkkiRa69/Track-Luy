import 'package:akkhara_tracker/components/add_trasaction_dialog.dart';
import 'package:akkhara_tracker/components/custome_app_bar.dart';
import 'package:akkhara_tracker/components/expense_tile.dart';
import 'package:akkhara_tracker/components/income_tile.dart';
import 'package:akkhara_tracker/components/my_card.dart';
import 'package:akkhara_tracker/components/my_image_card.dart';
import 'package:akkhara_tracker/helper/my_alert.dart';
import 'package:akkhara_tracker/models/expense.dart';
import 'package:akkhara_tracker/models/expense_database.dart';
import 'package:akkhara_tracker/models/income.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    const Color.fromARGB(255, 30, 10, 180), // Adjusted color 1
    const Color.fromARGB(255, 0, 70, 120), // Adjusted color 2
    const Color.fromARGB(255, 20, 80, 150), // Adjusted color 3
  ];
  final List<Color> colors3 = [
    const Color.fromARGB(255, 159, 3, 3),
    const Color.fromARGB(255, 195, 118, 16),
    const Color.fromARGB(255, 231, 95, 5),
  ];
  // int currentIndex = 0;
  double iconSize = 30.0;
  final PageController _pageController = PageController(viewportFraction: 1);

  //for add trasaction
  TextEditingController amountController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController emojiController = TextEditingController();
  TextEditingController cateNameController = TextEditingController();
  String selectedCategory = '';
  DateTime selectedDate = DateTime.now();
  int currentIndex = 0;
  bool isSelected = false;
  List categories = [];
  List pastDays = [];

  double totalExpense = 0;
  double totalIncome = 0;
  double totalBalance = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<ExpenseDatabase>().readExpenses();
    context.read<ExpenseDatabase>().readIncome();
    context.read<ExpenseDatabase>().readCate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      floatingActionButton: _buildFloating(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildAnimatedBottomNavbar(),
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

            //category list
            // SizedBox(
            //   height: 100,
            //   // width: 50,
            //   child: ListView.builder(
            //     physics: const BouncingScrollPhysics(),
            //     scrollDirection: Axis.horizontal,
            //     itemCount: categories.length,
            //     itemBuilder: (context, index) {
            //       List<String> categoryParts = categories[index].split(' ');
            //       String emoji = categoryParts[0];
            //       String categoryName = categoryParts.sublist(1).join(' ');
            //       return Padding(
            //         padding: EdgeInsets.only(
            //           left: MediaQuery.of(context).size.width * 0.05,
            //         ),
            //         child: Column(
            //           children: [
            //             Container(
            //               decoration: const BoxDecoration(
            //                 color: Color(0xff2f2f2f),
            //                 shape: BoxShape.circle,
            //               ),
            //               padding: const EdgeInsets.all(15),
            //               child: Text(
            //                 emoji,
            //                 style: const TextStyle(
            //                   fontSize: 24,
            //                 ),
            //               ),
            //             ),
            //             const SizedBox(
            //               height: 5,
            //             ),
            //             Text(
            //               categoryName,
            //               style: GoogleFonts.lato(
            //                 fontWeight: FontWeight.w600,
            //               ),
            //             ),
            //           ],
            //         ),
            //       );
            //     },
            //   ),
            // ),

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
                      // fontSize: 16,
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

  Widget _buildFloating() {
    categories = context.watch<ExpenseDatabase>().categories;

    pastDays = context.watch<ExpenseDatabase>().dates;
    return FloatingActionButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      onPressed: () {
        showModalBottomSheet(
          sheetAnimationStyle: AnimationStyle(
            curve: Curves.bounceInOut,
            duration: const Duration(
              milliseconds: 300,
            ),
          ),
          backgroundColor: const Color(0xff000000),
          // expand: isExpand,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          barrierColor: Colors.black.withOpacity(0.7),
          context: context,
          builder: (context) => AddTransactionSheet(
            currentIndex: currentIndex,
            onToggle: (index) {
              setState(() {
                currentIndex = index!;
              });
            },
            amountController: amountController,
            desController: desController,
            emojiController: emojiController,
            cateNameController: cateNameController,
            categories: categories,
            onSelectedCategory: (value) {
              setState(() {
                isSelected = true;
                selectedCategory = value;
              });
            },
            isSelected: isSelected,
            selectedCategory: selectedCategory,
            selectedDate: selectedDate,
            onSelectedDate: (value) {
              if (value != null) {
                setState(() {
                  selectedDate = value;
                });
              }
            },
            onSave: () {
              if (isSelected == false) {
                selectedCategory = categories.last;
                print("last$selectedCategory");
              }
              if (isSelected == true) {
                setState(() {
                  isSelected = false;
                });
              }

              // Process the selected category
              List<String> categoryParts = selectedCategory.split(' ');
              if (categoryParts.length < 2) {
                showInvalidAlert(context, 'Invalid category format.');
                return;
              }

              String emoji = categoryParts[0];
              String categoryName = categoryParts.sublist(1).join(' ');

              double amount = double.parse(amountController.text);
              if (currentIndex == 0) {
                try {
                  Expense ex = Expense(
                    name: categoryName,
                    amount: amount,
                    date: selectedDate,
                    des: desController.text,
                    emoji: emoji,
                  );

                  // Add the Expense to the database
                  context.read<ExpenseDatabase>().addExpense(ex);

                  // Navigate back
                  Navigator.pop(context);
                  amountController.clear();
                  desController.clear();
                  categoryName = "";
                  selectedCategory = '';
                  emoji = "";
                  selectedDate = DateTime.now();
                } catch (e) {
                  // Show error message using SnackBar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString())),
                  );
                }
              }
              if (currentIndex == 1) {
                try {
                  // Create the Expense object
                  Income income = Income(
                    name: categoryName,
                    amount: amount,
                    date: selectedDate,
                    des: desController.text,
                    emoji: emoji,
                  );

                  // Add the Expense to the database
                  context.read<ExpenseDatabase>().addIncome(income);

                  // Navigate back
                  Navigator.pop(context);
                  amountController.clear();
                  desController.clear();
                  categoryName = "";
                  emoji = "";
                  selectedCategory = '';
                  selectedDate = DateTime.now();
                } catch (e) {
                  // Show error message using SnackBar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString())),
                  );
                }
              }
            },
            initilizeSelection: categories.last,
            pastDays: pastDays,
            initDate: pastDays.first,
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }

  List<List<String>> splitCategoryList(List<String> categoryList) {
    List<List<String>> result = [];
    for (String category in categoryList) {
      List<String> parts = category.split(' '); // Split by space
      result.add(parts);
    }
    return result;
  }

  int _bottomNavIndex = 0;
  final iconList = <IconData>[
    FontAwesomeIcons.homeAlt,
    FontAwesomeIcons.moneyBillTransfer,
    FontAwesomeIcons.wallet,
    FontAwesomeIcons.gear,
  ];

  Widget _buildAnimatedBottomNavbar() {
    return AnimatedBottomNavigationBar.builder(
      backgroundColor: const Color(0xfff5f5f5),
      height: 65,
      scaleFactor: 1.5,
      itemCount: iconList.length,
      tabBuilder: (int index, bool isActive) {
        return Icon(
          iconList[index],
          size: 20,
          color: isActive
              ? Theme.of(context).colorScheme.primary
              : Colors.grey[500],
        );
      },
      activeIndex: _bottomNavIndex,

      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.smoothEdge,
      leftCornerRadius: 25,
      rightCornerRadius: 25,
      onTap: (index) {
        setState(() {
          _bottomNavIndex = index;
        });
      },
      // Add other params if necessary
    );
  }
}
