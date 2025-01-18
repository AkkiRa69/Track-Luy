import 'package:akkhara_tracker/components/widgets/expense%20widget/add_trasaction_dialog.dart';
import 'package:akkhara_tracker/helper/my_alert.dart';
import 'package:akkhara_tracker/models/expense.dart';
import 'package:akkhara_tracker/models/expense_database.dart';
import 'package:akkhara_tracker/models/income.dart';
import 'package:akkhara_tracker/pages/home_page.dart';
import 'package:akkhara_tracker/pages/insight_page.dart';
import 'package:akkhara_tracker/pages/portfolio_page.dart';
import 'package:akkhara_tracker/pages/subscription_page.dart';
import 'package:akkhara_tracker/theme/app_colors.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with AutomaticKeepAliveClientMixin {
  late final List<Widget> _page;
  int _bottomNavIndex = 0;

  @override
  void initState() {
    super.initState();
    _page = [
      const HomePage(),
      const InsightPage(),
      const PlansPage(),
      const AboutMePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      drawer: const Drawer(),
      body: _page[_bottomNavIndex],
      backgroundColor: Colors.transparent,
      floatingActionButton: _buildFloating(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildAnimatedBottomNavbar(),
    );
  }

  final iconList = <IconData>[
    FontAwesomeIcons.moneyBillTransfer,
    FontAwesomeIcons.chartColumn,
    FontAwesomeIcons.diamond,
    FontAwesomeIcons.gear,
  ];

  Widget _buildAnimatedBottomNavbar() {
    return AnimatedBottomNavigationBar.builder(
      backgroundColor: AppColors.kindaBlack,
      elevation: 0,
      height: 65,
      scaleFactor: 1.5,
      itemCount: iconList.length,
      tabBuilder: (int index, bool isActive) {
        return Icon(
          iconList[index],
          size: 20,
          color: isActive ? Colors.white : AppColors.backGround,
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
    );
  }

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

  Widget _buildFloating() {
    // categories = context.watch<ExpenseDatabase>().categories;
    // pastDays = context.watch<ExpenseDatabase>().dates;
    // List<Expense> expenses = context.watch<ExpenseDatabase>().expenseList;
    // List<Income> incomes = context.watch<ExpenseDatabase>().incomeList;
    // final totalExpense =
    //     context.watch<ExpenseDatabase>().calculateTotalExpense(expenses);
    // final totalIncome =
    //     context.watch<ExpenseDatabase>().calculateTotalIncome(incomes);
    // totalBalance = totalIncome - totalExpense;
    return FloatingActionButton(
      backgroundColor: AppColors.kindaBlack,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      onPressed: () {
        // Initialize controllers here instead of as class fields
        final amountController = TextEditingController();
        final desController = TextEditingController();
        final emojiController = TextEditingController();
        final cateNameController = TextEditingController();

        // Get data from provider
        final categories = context.read<ExpenseDatabase>().categories;
        final pastDays = context.read<ExpenseDatabase>().dates;
        final expenses = context.read<ExpenseDatabase>().expenseList;
        final incomes = context.read<ExpenseDatabase>().incomeList;
        final totalExpense =
            context.read<ExpenseDatabase>().calculateTotalExpense(expenses);
        final totalIncome =
            context.read<ExpenseDatabase>().calculateTotalIncome(incomes);
        final totalBalance = totalIncome - totalExpense;

        showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: const Color(0xff000000),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          context: context,
          builder: (context) {
            bool isSelected = false;
            String selectedCategory =
                categories.isNotEmpty ? categories.last : '';
            DateTime selectedDate =
                pastDays.isNotEmpty ? pastDays.first : DateTime.now();
            int currentIndex = 0;

            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: StatefulBuilder(
                builder: (context, setState) {
                  return AddTransactionSheet(
                    currentIndex: currentIndex,
                    onToggle: (index) {
                      setState(() {
                        currentIndex = index ?? 0;
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
                    onSave: () async {
                      // Handle empty categories
                      if (categories.isEmpty) {
                        showCupertinoAlert(
                            context, 'Please add categories first.');
                        return;
                      }

                      if (!isSelected) {
                        selectedCategory = categories.last;
                      }

                      // Validate category format
                      List<String> categoryParts = selectedCategory.split(' ');
                      if (categoryParts.length < 2) {
                        showCupertinoAlert(context, 'Invalid category format.');
                        return;
                      }

                      String emoji = categoryParts[0];
                      String categoryName = categoryParts.sublist(1).join(' ');

                      // Validate amount
                      String inputText =
                          amountController.text.replaceAll(',', '.');
                      double? amount;
                      try {
                        amount = double.parse(inputText);
                      } catch (e) {
                        showCupertinoAlert(context, 'Invalid amount format.');
                        return;
                      }

                      // Handle expense
                      if (currentIndex == 0) {
                        if (amount > totalBalance) {
                          showCupertinoAlert(
                              context, "You don't have enough money to spend.");
                          return;
                        }

                        try {
                          final expense = Expense(
                            name: categoryName,
                            amount: amount,
                            date: selectedDate,
                            des: desController.text,
                            emoji: emoji,
                          );
                          await context
                              .read<ExpenseDatabase>()
                              .addExpense(expense);
                          Navigator.pop(context);
                        } catch (e) {
                          showCupertinoAlert(context, e.toString());
                          return;
                        }
                      }
                      // Handle income
                      else if (currentIndex == 1) {
                        try {
                          final income = Income(
                            name: categoryName,
                            amount: amount,
                            date: selectedDate,
                            des: desController.text,
                            emoji: emoji,
                          );
                          await context
                              .read<ExpenseDatabase>()
                              .addIncome(income);
                          Navigator.pop(context);
                        } catch (e) {
                          showCupertinoAlert(context, e.toString());
                          return;
                        }
                      }

                      // Clear controllers
                      amountController.clear();
                      desController.clear();
                    },
                    initilizeSelection:
                        categories.isNotEmpty ? categories.last : '',
                    pastDays: pastDays,
                    initDate:
                        pastDays.isNotEmpty ? pastDays.first : DateTime.now(),
                  );
                },
              ),
            );
          },
        );
      },
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
