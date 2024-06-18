import 'package:akkhara_tracker/components/add_trasaction_dialog.dart';
import 'package:akkhara_tracker/helper/my_alert.dart';
import 'package:akkhara_tracker/models/expense.dart';
import 'package:akkhara_tracker/models/expense_database.dart';
import 'package:akkhara_tracker/models/income.dart';
import 'package:akkhara_tracker/pages/home_page.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

List _page = [
  const HomePage(),
  const Scaffold(),
  const Scaffold(),
  const Scaffold(),
];

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page[_bottomNavIndex],
      floatingActionButton: _buildFloating(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildAnimatedBottomNavbar(),
    );
  }

  int _bottomNavIndex = 0;

  final iconList = <IconData>[
    FontAwesomeIcons.moneyBillTransfer,
    FontAwesomeIcons.chartColumn,
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

  double iconSize = 30.0;

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
}
