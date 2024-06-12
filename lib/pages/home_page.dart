import 'package:akkhara_tracker/components/custome_app_bar.dart';
import 'package:akkhara_tracker/components/expense_tile.dart';
import 'package:akkhara_tracker/components/income_tile.dart';
import 'package:akkhara_tracker/components/my_card.dart';
import 'package:akkhara_tracker/components/my_image_card.dart';
import 'package:akkhara_tracker/components/my_text_field.dart';
import 'package:akkhara_tracker/models/expense.dart';
import 'package:akkhara_tracker/models/expense_database.dart';
import 'package:akkhara_tracker/models/income.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
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

  DateTime oneDaysAgo = DateTime.now().subtract(const Duration(days: 1));
  DateTime twoDaysAgo = DateTime.now().subtract(const Duration(days: 2));
  DateTime threeDaysAgo = DateTime.now().subtract(const Duration(days: 3));
  DateTime fourDaysAgo = DateTime.now().subtract(const Duration(days: 4));
  DateTime fiveDaysAgo = DateTime.now().subtract(const Duration(days: 5));
  DateTime sixDaysAgo = DateTime.now().subtract(const Duration(days: 6));
  DateTime sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));

  // final PageController _pageController = PageController();
  TextEditingController amountController = TextEditingController();
  TextEditingController desController = TextEditingController();
  late String selectedCategory;
  DateTime selectedDate = DateTime.now();
  int currentIndex = 0;
  int index = 0;

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      floatingActionButton: _buildFloating(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNavBar(),
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
                  child: PageView(
                    controller: _pageController,
                    children: [
                      MyCard(
                        totalBalance: totalBalance,
                        colors: colors1,
                      ),
                      MyImageCard(
                        image: "assets/images/card_back1.jpg",
                        totalBalance: totalBalance,
                      ),
                      MyImageCard(
                        image: "assets/images/card_back2.png",
                        totalBalance: totalBalance,
                      ),
                      MyImageCard(
                        image: "assets/images/card_back3.png",
                        totalBalance: totalBalance,
                      ),
                      MyImageCard(
                        image: "assets/images/card_back4.png",
                        totalBalance: totalBalance,
                      ),
                    ],
                  ),
                ),

                // Indicator
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 10),
                //   child: Center(
                //     child: SmoothPageIndicator(
                //       controller: _pageController,
                //       count: 5,
                //       effect: WormEffect(
                //         spacing: 5,
                //         dotColor: Theme.of(context).colorScheme.tertiary,
                //         radius: 10,
                //         dotHeight: 8,
                //         dotWidth: 8,
                //         activeDotColor: Theme.of(context).colorScheme.primary,
                //       ), // Customize the indicator effect
                //     ),
                //   ),
                // ),

                // Income and Expenses
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.05,
                      top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //income
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            color: const Color(0xffe7fadf),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                      const SizedBox(
                        width: 15,
                      ),
                      //expense
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffffe3e3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                  bottom: 10,
                  right: MediaQuery.of(context).size.width * 0.05,
                  top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Transactions",
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "VIEW ALL",
                    style: GoogleFonts.lato(
                        fontSize: 16, fontWeight: FontWeight.bold),
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
                  return ExpenseTile(expense: transaction.data as Expense);
                } else {
                  return IncomeTile(income: transaction.data as Income);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloating() {
    List categories = context.watch<ExpenseDatabase>().categories;
    return FloatingActionButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => Container(
            decoration: const BoxDecoration(
              color: Color(0xff000000),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // text
                const Text(
                  "Add Transaction",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),

                // expense + income button
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff2f2f2f),
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    children: [
                      //expense button
                      Expanded(
                        child: Container(
                          // curve: Curves.linearToEaseOut,
                          margin: const EdgeInsets.all(3),
                          // duration: const Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            color: currentIndex == 0
                                ? const Color(0xff4e4d4d)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            onPressed: () {
                              setState(() {
                                currentIndex = 0;
                              });
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(13.0),
                              child: Text(
                                "Expense",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      //income button
                      Expanded(
                        child: Container(
                          // curve: Curves.linearToEaseOut,
                          margin: const EdgeInsets.all(3),
                          // duration: const Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            color: currentIndex == 1
                                ? const Color(0xff4e4d4d)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            onPressed: () {
                              setState(() {
                                currentIndex = 1;
                              });
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(13.0),
                              child: Text(
                                "Income",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                // all text field
                Row(
                  children: [
                    Expanded(
                      child: MyTextField(
                        text: "Amount",
                        hintText: "0.00 USD",
                        controller: amountController,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: MyTextField(
                        text: "Description",
                        hintText: "Expense Description",
                        controller: desController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // dropdown menu
                Row(
                  children: [
                    Text(
                      "Category ",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                    const Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                //selected category
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        child: DropdownMenu(
                          menuStyle: MenuStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              Colors.black.withOpacity(0.7),
                            ),
                          ),
                          inputDecorationTheme: InputDecorationTheme(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 15),
                            isDense: true,
                            hintStyle: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                            border: InputBorder.none,
                          ),
                          hintText: "Select category",
                          selectedTrailingIcon: Icon(
                            Icons.arrow_drop_up,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                          trailingIcon: Icon(
                            Icons.arrow_drop_down_outlined,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                          textStyle: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                            fontSize: 14,
                          ),
                          width: MediaQuery.of(context).size.width * 0.92,
                          onSelected: (value) {
                            if (value != null) {
                              setState(() {
                                selectedCategory = value;
                              });
                            }
                          },
                          dropdownMenuEntries: [
                            for (int i = 0; i < categories.length; i++)
                              DropdownMenuEntry(
                                value: categories[i],
                                label: categories[i],
                                labelWidget: Text(
                                  categories[i],
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // add category
                Padding(
                  padding: const EdgeInsets.only(top: 6, bottom: 12),
                  child: Row(
                    children: [
                      Text(
                        "Don't see a category you need?   ",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: const BoxDecoration(),
                          child: Text(
                            "+ Add category",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              decoration: TextDecoration.underline,
                              decorationColor:
                                  Theme.of(context).colorScheme.secondary,
                              decorationThickness: 2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // date
                Row(
                  children: [
                    Text(
                      "Date ",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                    const Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                //seletect date
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        child: DropdownMenu(
                          menuStyle: MenuStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              Colors.black.withOpacity(0.7),
                            ),
                          ),
                          inputDecorationTheme: InputDecorationTheme(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 15),
                            isDense: true,
                            hintStyle: TextStyle(
                              color: Theme.of(context).colorScheme.surface,
                            ),
                            border: InputBorder.none,
                          ),
                          hintText: "Today",
                          selectedTrailingIcon: Icon(
                            Icons.calendar_today_outlined,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                          trailingIcon: Icon(
                            Icons.calendar_today_outlined,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                          textStyle: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                            fontSize: 14,
                          ),
                          width: MediaQuery.of(context).size.width * 0.92,
                          onSelected: (value) {
                            if (value != null) {
                              setState(() {
                                selectedDate = value;
                              });
                            }
                          },
                          dropdownMenuEntries: [
                            DropdownMenuEntry(
                              value: DateTime.now(),
                              label: 'Today',
                              labelWidget: Text(
                                "Today",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              ),
                            ),
                            DropdownMenuEntry(
                              value: oneDaysAgo,
                              label: 'Yesterday',
                              labelWidget: Text(
                                "Yesterday",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              ),
                            ),
                            // week
                            DropdownMenuEntry(
                              value: twoDaysAgo,
                              label: DateFormat('MMM dd (EEEE)')
                                  .format(twoDaysAgo),
                              labelWidget: Text(
                                DateFormat('MMM dd (EEEE)').format(twoDaysAgo),
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              ),
                            ),
                            DropdownMenuEntry(
                              value: threeDaysAgo,
                              label: DateFormat('MMM dd (EEEE)')
                                  .format(threeDaysAgo),
                              labelWidget: Text(
                                DateFormat('MMM dd (EEEE)')
                                    .format(threeDaysAgo),
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              ),
                            ),
                            DropdownMenuEntry(
                              value: fourDaysAgo,
                              label: DateFormat('MMM dd (EEEE)')
                                  .format(fourDaysAgo),
                              labelWidget: Text(
                                DateFormat('MMM dd (EEEE)').format(fourDaysAgo),
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              ),
                            ),
                            DropdownMenuEntry(
                              value: fiveDaysAgo,
                              label: DateFormat('MMM dd (EEEE)')
                                  .format(fiveDaysAgo),
                              labelWidget: Text(
                                DateFormat('MMM dd (EEEE)').format(fiveDaysAgo),
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              ),
                            ),
                            DropdownMenuEntry(
                              value: sixDaysAgo,
                              label: DateFormat('MMM dd (EEEE)')
                                  .format(sixDaysAgo),
                              labelWidget: Text(
                                DateFormat('MMM dd (EEEE)').format(sixDaysAgo),
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              ),
                            ),
                            DropdownMenuEntry(
                              value: sevenDaysAgo,
                              label: DateFormat('MMM dd (EEEE)')
                                  .format(sevenDaysAgo),
                              labelWidget: Text(
                                DateFormat('MMM dd (EEEE)')
                                    .format(sevenDaysAgo),
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // save button
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onPressed: () {
                              if (currentIndex == 0) {
                                try {
                                  // Check if selectedCategory is not null or empty
                                  if (selectedCategory.isEmpty) {
                                    throw Exception(
                                        'Please select a category.');
                                  }

                                  // Split selectedCategory into emoji and category name
                                  List<String> categoryParts =
                                      selectedCategory.split(' ');
                                  if (categoryParts.length < 2) {
                                    throw Exception('Invalid category format.');
                                  }

                                  String emoji = categoryParts[0];
                                  String categoryName =
                                      categoryParts.sublist(1).join(' ');

                                  // Check if amountController has valid text
                                  if (amountController.text.isEmpty) {
                                    throw Exception('Please enter an amount.');
                                  }

                                  double amount =
                                      double.parse(amountController.text);

                                  // Check if desController has valid text
                                  if (desController.text.isEmpty) {
                                    throw Exception(
                                        'Please enter a description.');
                                  }

                                  // Create the Expense object
                                  Expense ex = Expense(
                                    name: categoryName,
                                    amount: amount,
                                    date: selectedDate,
                                    des: desController.text,
                                    emoji: emoji,
                                  );

                                  // Add the Expense to the database
                                  context
                                      .read<ExpenseDatabase>()
                                      .addExpense(ex);

                                  // Navigate back
                                  Navigator.pop(context);
                                  amountController.clear();
                                  desController.clear();
                                  categoryName = "";
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
                                  // Check if selectedCategory is not null or empty
                                  if (selectedCategory.isEmpty) {
                                    throw Exception(
                                        'Please select a category.');
                                  }

                                  // Split selectedCategory into emoji and category name
                                  List<String> categoryParts =
                                      selectedCategory.split(' ');
                                  if (categoryParts.length < 2) {
                                    throw Exception('Invalid category format.');
                                  }

                                  String emoji = categoryParts[0];
                                  String categoryName =
                                      categoryParts.sublist(1).join(' ');

                                  // Check if amountController has valid text
                                  if (amountController.text.isEmpty) {
                                    throw Exception('Please enter an amount.');
                                  }

                                  double amount =
                                      double.parse(amountController.text);

                                  // Check if desController has valid text
                                  if (desController.text.isEmpty) {
                                    throw Exception(
                                        'Please enter a description.');
                                  }
                                  print(categoryName);
                                  print(amount);
                                  print(selectedDate);
                                  print(desController.text);
                                  print(emoji);
                                  // Create the Expense object
                                  Income income = Income(
                                    name: categoryName,
                                    amount: amount,
                                    date: selectedDate,
                                    des: desController.text,
                                    emoji: emoji,
                                  );

                                  // Add the Expense to the database
                                  context
                                      .read<ExpenseDatabase>()
                                      .addIncome(income);

                                  // Navigate back
                                  Navigator.pop(context);
                                  amountController.clear();
                                  desController.clear();
                                  categoryName = "";
                                  emoji = "";
                                  selectedDate = DateTime.now();
                                } catch (e) {
                                  // Show error message using SnackBar
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(e.toString())),
                                  );
                                }
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text("Save"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      selectedItemColor: Theme.of(context).colorScheme.primary,
      selectedFontSize: 16,
      unselectedFontSize: 14,
      iconSize: 26,
      unselectedItemColor: Colors.black,
      currentIndex: currentIndex >= 2 ? currentIndex + 1 : currentIndex,
      onTap: (index) {
        if (index != 2) {
          // Skip the dummy spacer index
          setState(() {
            currentIndex = index > 2 ? index - 1 : index;
          });
        }
      },
      items: [
        _buildNavItem(0, "assets/icons/home.png"),
        _buildNavItem(1, "assets/icons/expenses_1.png"),
        _buildDummy(),
        _buildNavItem(2, "assets/icons/income.png"),
        _buildNavItem(3, "assets/icons/profile.png"),
      ],
    );
  }

  BottomNavigationBarItem _buildNavItem(int index, String assetPath) {
    return BottomNavigationBarItem(
      backgroundColor: const Color(0xfff5f4f3),
      icon: Image.asset(
        assetPath,
        height: 30,
      ),
      label: '•',
      
    );
  }

  BottomNavigationBarItem _buildDummy() {
    return const BottomNavigationBarItem(
      backgroundColor: Color(0xfff5f4f3),
      icon: SizedBox(
        width: 15,
      ),
      label: "",
    );
  }
}
