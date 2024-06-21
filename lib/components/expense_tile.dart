import 'package:akkhara_tracker/components/add_trasaction_dialog.dart';
import 'package:akkhara_tracker/helper/date_cal.dart';
import 'package:akkhara_tracker/helper/my_alert.dart';
import 'package:akkhara_tracker/models/expense.dart';
import 'package:akkhara_tracker/models/expense_database.dart';
import 'package:akkhara_tracker/models/income.dart';
import 'package:akkhara_tracker/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ExpenseTile extends StatefulWidget {
  final Expense expense;
  const ExpenseTile({super.key, required this.expense});

  @override
  State<ExpenseTile> createState() => _ExpenseTileState();
}

class _ExpenseTileState extends State<ExpenseTile> {
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
  double totalBalance = 0;

  @override
  void dispose() {
    amountController.dispose();
    desController.dispose();
    emojiController.dispose();
    cateNameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ExpenseDatabase>().readExpenses();
  }

  @override
  Widget build(BuildContext context) {
    List<Expense> expenses = context.watch<ExpenseDatabase>().expenseList;
    List<Income> incomes = context.watch<ExpenseDatabase>().incomeList;
    final totalExpense =
        context.watch<ExpenseDatabase>().calculateTotalExpense(expenses);
    final totalIncome =
        context.watch<ExpenseDatabase>().calculateTotalIncome(incomes);
    totalBalance = totalIncome - totalExpense;
    return Dismissible(
      key: ValueKey(widget.expense.id),
      background: _buildDismissibleBackground(context, Alignment.centerLeft),
      secondaryBackground:
          _buildDismissibleBackground(context, Alignment.centerRight),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          // Handle update action
          _handleUpdate(context);
          return false; // Don't dismiss the tile
        } else if (direction == DismissDirection.endToStart) {
          // Confirm delete action
          return await _showDeleteConfirmationDialog(context);
        }
        return false;
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          // Handle delete action
          _handleDelete(context);
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.kindaBlack,
                    shape: BoxShape.circle,
                    // borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    widget.expense.emoji,
                    style: const TextStyle(fontSize: 40),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.expense.des,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.fade,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        widget.expense.name,
                        style: const TextStyle(
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '-\$${widget.expense.amount.toStringAsFixed(2)}',
                style: GoogleFonts.concertOne(
                  fontSize: 20,
                  color: AppColors.red,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                isToday(widget.expense.date)
                    ? "Today"
                    : isYesterday(widget.expense.date)
                        ? "Yesterday"
                        : DateFormat('MMM dd, EEEE')
                            .format(widget.expense.date),
                style: const TextStyle(
                  color: AppColors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDismissibleBackground(
      BuildContext context, Alignment alignment) {
    return Container(
      alignment: alignment,
      decoration: BoxDecoration(
        color: alignment == Alignment.centerLeft ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: alignment == Alignment.centerLeft
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: [
          if (alignment == Alignment.centerLeft)
            _buildActionIcon(context, Icons.edit, Colors.green, _handleUpdate),
          if (alignment == Alignment.centerRight)
            _buildActionIcon(context, Icons.delete, Colors.red, _handleDelete),
        ],
      ),
    );
  }

  Widget _buildActionIcon(BuildContext context, IconData icon, Color color,
      Function(BuildContext) action) {
    return GestureDetector(
      onTap: () => action(context),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Icon(
          icon,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }

  void _handleDelete(BuildContext context) {
    context.read<ExpenseDatabase>().deleteExpense(widget.expense.id);
    print("deleted ${widget.expense.id}");
  }

  void _handleUpdate(BuildContext context) {
    categories = context.read<ExpenseDatabase>().categories;
    List dates = context.read<ExpenseDatabase>().dates;

    // Initialize new controllers for modal sheet
    TextEditingController amountControllerModal =
        TextEditingController(text: widget.expense.amount.toStringAsFixed(2));
    TextEditingController desControllerModal =
        TextEditingController(text: widget.expense.des);

    String cate = "${widget.expense.emoji} ${widget.expense.name}";
    dynamic date = widget.expense.date;
    selectedCategory = cate;
    selectedDate = date;

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => AddTransactionSheet(
        currentIndex: currentIndex,
        onToggle: (index) {
          setState(() {
            currentIndex = index!;
          });
        },
        amountController: amountControllerModal, // Use the new controller here
        desController: desControllerModal, // Use the new controller here
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
        initilizeSelection: cate,
        pastDays: dates,
        initDate: date,
        onSave: () async {
          try {
            // Validate category format
            List<String> categoryParts = selectedCategory.split(' ');
            if (categoryParts.length < 2) {
              showInvalidAlert(context, 'Invalid category format.');
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
            }
            if (amount > totalBalance) {
              showCupertinoAlert(
                  context, "You don't have enough money to spend.");
              return;
            }
            if (currentIndex == 0) {
              // Expense update case
              Expense ex = Expense(
                name: categoryName,
                amount: amount,
                date: selectedDate,
                des: desControllerModal.text,
                emoji: emoji,
              );

              // Update the expense in the database
              await context
                  .read<ExpenseDatabase>()
                  .updateExpense(widget.expense.id, ex);

              // Navigate back and clear fields
              Navigator.pop(context);
              amountControllerModal.clear();
              desControllerModal.clear();
              selectedCategory = '';
              selectedDate = DateTime.now();
            }

            if (currentIndex == 1) {
              // Income addition case
              Income income = Income(
                name: categoryName,
                amount: amount,
                date: selectedDate,
                des: desControllerModal.text,
                emoji: emoji,
              );

              // Delete the expense and add income
              await context
                  .read<ExpenseDatabase>()
                  .deleteExpense(widget.expense.id);
              await context.read<ExpenseDatabase>().addIncome(income);

              // Navigate back and clear fields
              Navigator.pop(context);
              amountControllerModal.clear();
              desControllerModal.clear();
              selectedCategory = '';
              selectedDate = DateTime.now();
            }
          } catch (e) {
            // Show error message using SnackBar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e.toString())),
            );
          }
        },
      ),
    );
  }

  Future<bool?> _showDeleteConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.kindaBlack,
        title: const Text(
          'Confirm Delete',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Are you sure you want to delete this expense?',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: AppColors.red),
            ),
          ),
        ],
      ),
    );
  }
}

String formatDate(DateTime date) {
  DateTime today = DateTime.now();
  DateTime yesterday = today.subtract(const Duration(days: 1));

  if (isSameDate(date, today)) {
    return 'Today';
  } else if (isSameDate(date, yesterday)) {
    return 'Yesterday';
  } else {
    return DateFormat('MMM dd (EEEE)').format(date);
  }
}

bool isSameDate(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}
