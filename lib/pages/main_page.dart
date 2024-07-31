import 'package:akkhara_tracker/components/widgets/expense%20widget/add_trasaction_dialog.dart';
import 'package:akkhara_tracker/helper/my_alert.dart';
import 'package:akkhara_tracker/models/expense.dart';
import 'package:akkhara_tracker/models/expense_database.dart';
import 'package:akkhara_tracker/models/income.dart';
import 'package:akkhara_tracker/pages/portfolio_page.dart';
import 'package:akkhara_tracker/pages/home_page.dart';
import 'package:akkhara_tracker/pages/insight_page.dart';
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
    categories = context.watch<ExpenseDatabase>().categories;
    pastDays = context.watch<ExpenseDatabase>().dates;
    List<Expense> expenses = context.watch<ExpenseDatabase>().expenseList;
    List<Income> incomes = context.watch<ExpenseDatabase>().incomeList;
    final totalExpense =
        context.watch<ExpenseDatabase>().calculateTotalExpense(expenses);
    final totalIncome =
        context.watch<ExpenseDatabase>().calculateTotalIncome(incomes);
    totalBalance = totalIncome - totalExpense;
    return FloatingActionButton(
      backgroundColor: AppColors.kindaBlack,
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
          barrierColor: Colors.black.withOpacity(0.8),
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
            onSave: () async {
              if (isSelected == false) {
                selectedCategory = categories.last;
                // print("last$selectedCategory");
              }
              if (isSelected == true) {
                setState(() {
                  isSelected = false;
                });
              }

              // Process the selected category
              List<String> categoryParts = selectedCategory.split(' ');
              if (categoryParts.length < 2) {
                showCupertinoAlert(context, 'Invalid category format.');
                return;
              }

              String emoji = categoryParts[0];
              String categoryName = categoryParts.sublist(1).join(' ');

              String inputText = amountController.text.replaceAll(',', '.');
              late double amount;
              try {
                amount = double.parse(inputText);
                print("Parsed amount: $amount");
              } catch (e) {
                print("Error parsing amount: $e");
                showCupertinoAlert(context, 'Invalid amount format.');
                return;
              }
              if (currentIndex == 0) {
                if (amount > totalBalance) {
                  showCupertinoAlert(
                      context, "You don't have enough money to spend.");
                  return;
                }
                try {
                  Expense ex = Expense(
                    name: categoryName,
                    amount: amount,
                    date: selectedDate,
                    des: desController.text,
                    emoji: emoji,
                  );

                  // Add the Expense to the database
                  await context.read<ExpenseDatabase>().addExpense(ex);

                  // Navigate back
                  Navigator.pop(context);
                  amountController.clear();
                  desController.clear();
                  selectedCategory = categories.last; // Reset to last category
                  selectedDate = pastDays.first; // Reset to initial date
                } catch (e) {
                  // Show error message using SnackBar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString())),
                  );
                }
              }
              if (currentIndex == 1) {
                try {
                  // Create the Income object
                  Income income = Income(
                    name: categoryName,
                    amount: amount,
                    date: selectedDate,
                    des: desController.text,
                    emoji: emoji,
                  );

                  // Add the Income to the database
                  await context.read<ExpenseDatabase>().addIncome(income);
                  print('added luy = $amount');

                  // Navigate back
                  Navigator.pop(context);
                  amountController.clear();
                  desController.clear();
                  selectedCategory = categories.last; // Reset to last category
                  selectedDate = pastDays.first; // Reset to initial date
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
