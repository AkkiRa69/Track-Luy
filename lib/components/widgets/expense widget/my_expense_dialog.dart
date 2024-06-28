import 'package:akkhara_tracker/components/widgets/expense%20widget/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class MyExpenseDialog extends StatefulWidget {
  final String initialCategory;
  final DateTime selectedDate;
  final TextEditingController amountController; // Use controller for amount
  final TextEditingController desController; // Use controller for description
  final VoidCallback saveButton;
  final VoidCallback expenseTap;
  final VoidCallback incomeTap;
  final int initialIndex;

  const MyExpenseDialog({
    super.key,
    required this.initialCategory,
    required this.selectedDate,
    required this.amountController,
    required this.desController,
    required this.saveButton,
    required this.expenseTap,
    required this.incomeTap,
    required this.initialIndex,
  });
  @override
  _MyExpenseDialogState createState() => _MyExpenseDialogState();
}

class _MyExpenseDialogState extends State<MyExpenseDialog> {
  int currentIndex = 0; // Track selected expense/income index
  late String selectedCategory; // Track selected category
  late DateTime selectedDate; // Track selected date
  DateTime oneDaysAgo = DateTime.now().subtract(const Duration(days: 1));
  DateTime twoDaysAgo = DateTime.now().subtract(const Duration(days: 2));
  DateTime threeDaysAgo = DateTime.now().subtract(const Duration(days: 3));
  DateTime fourDaysAgo = DateTime.now().subtract(const Duration(days: 4));
  DateTime fiveDaysAgo = DateTime.now().subtract(const Duration(days: 5));
  DateTime sixDaysAgo = DateTime.now().subtract(const Duration(days: 6));
  DateTime sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex; // Initialize current index
    selectedCategory = widget.initialCategory; // Initialize selected category
    selectedDate = widget.selectedDate; // Initialize selected date
  }

  // late String _selectedCategory;
  // late DateTime _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                Expanded(
                  child: AnimatedContainer(
                    curve: Curves.linearToEaseOut,
                    margin: const EdgeInsets.all(3),
                    duration: const Duration(milliseconds: 300),
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
                        widget.incomeTap();
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
                Expanded(
                  child: AnimatedContainer(
                    curve: Curves.linearToEaseOut,
                    margin: const EdgeInsets.all(3),
                    duration: const Duration(milliseconds: 300),
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
                        widget.expenseTap();
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
                  controller: widget.amountController,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: MyTextField(
                  text: "Description",
                  hintText: "Expense Description",
                  controller: widget.desController,
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
                style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
              ),
              const Text(
                "*",
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
          const SizedBox(height: 6),
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
                      DropdownMenuEntry(
                        value: "Food",
                        label: "🍕 Food",
                        labelWidget: Text(
                          "🍕 Food",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ),
                      DropdownMenuEntry(
                        value: "Work",
                        label: "💼 Work",
                        labelWidget: Text(
                          "💼 Work",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ),
                      DropdownMenuEntry(
                        value: "Entertainment",
                        label: "🎈 Entertainment",
                        labelWidget: Text(
                          "🎈 Entertainment",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ),
                      DropdownMenuEntry(
                        value: "Apartment",
                        label: "🏡 Apartment",
                        labelWidget: Text(
                          "🏡 Apartment",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ),
                      DropdownMenuEntry(
                        value: "Travel",
                        label: "🚌 Travel",
                        labelWidget: Text(
                          "🚌 Travel",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ),
                      DropdownMenuEntry(
                        value: "Subscriptions",
                        label: "💎 Subscriptions",
                        labelWidget: Text(
                          "💎 Subscriptions",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ),
                      DropdownMenuEntry(
                        value: "Cloths",
                        label: "👖 Cloths",
                        labelWidget: Text(
                          "👖 Cloths",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ),
                      DropdownMenuEntry(
                        value: "Studying",
                        label: "📚 Studying",
                        labelWidget: Text(
                          "📚 Studying",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ),
                      DropdownMenuEntry(
                        value: "Motorcycle",
                        label: "🛵 Motorcycle",
                        labelWidget: Text(
                          "🛵 Motorcycle",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ),
                      DropdownMenuEntry(
                        value: "Haircut",
                        label: "💇 Haircut",
                        labelWidget: Text(
                          "💇 Haircut",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ),
                      DropdownMenuEntry(
                        value: "Gifts",
                        label: "🎁 Gifts",
                        labelWidget: Text(
                          "🎁 Gifts",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ),
                      DropdownMenuEntry(
                        value: "Health",
                        label: "💊 Health",
                        labelWidget: Text(
                          "💊 Health",
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
                style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
              ),
              const Text(
                "*",
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
          const SizedBox(height: 6),
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
                        label: DateFormat('MMM dd (EEEE)').format(twoDaysAgo),
                        labelWidget: Text(
                          DateFormat('MMM dd (EEEE)').format(twoDaysAgo),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ),
                      DropdownMenuEntry(
                        value: threeDaysAgo,
                        label: DateFormat('MMM dd (EEEE)').format(threeDaysAgo),
                        labelWidget: Text(
                          DateFormat('MMM dd (EEEE)').format(threeDaysAgo),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ),
                      DropdownMenuEntry(
                        value: fourDaysAgo,
                        label: DateFormat('MMM dd (EEEE)').format(fourDaysAgo),
                        labelWidget: Text(
                          DateFormat('MMM dd (EEEE)').format(fourDaysAgo),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ),
                      DropdownMenuEntry(
                        value: fiveDaysAgo,
                        label: DateFormat('MMM dd (EEEE)').format(fiveDaysAgo),
                        labelWidget: Text(
                          DateFormat('MMM dd (EEEE)').format(fiveDaysAgo),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ),
                      DropdownMenuEntry(
                        value: sixDaysAgo,
                        label: DateFormat('MMM dd (EEEE)').format(sixDaysAgo),
                        labelWidget: Text(
                          DateFormat('MMM dd (EEEE)').format(sixDaysAgo),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ),
                      DropdownMenuEntry(
                        value: sevenDaysAgo,
                        label: DateFormat('MMM dd (EEEE)').format(sevenDaysAgo),
                        labelWidget: Text(
                          DateFormat('MMM dd (EEEE)').format(sevenDaysAgo),
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
                      onPressed: widget.saveButton,
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
    );
  }
}
