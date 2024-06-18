import 'package:akkhara_tracker/components/add_trasaction_dialog.dart';
import 'package:akkhara_tracker/helper/date_cal.dart';
import 'package:akkhara_tracker/helper/my_alert.dart';
import 'package:akkhara_tracker/models/expense.dart';
import 'package:akkhara_tracker/models/expense_database.dart';
import 'package:akkhara_tracker/models/income.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class IncomeTile extends StatefulWidget {
  final Income income;
  const IncomeTile({super.key, required this.income});

  @override
  State<IncomeTile> createState() => _IncomeTileState();
}

class _IncomeTileState extends State<IncomeTile> {
  //for add trasaction
  TextEditingController amountController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController emojiController = TextEditingController();
  TextEditingController cateNameController = TextEditingController();
  String selectedCategory = '';
  DateTime selectedDate = DateTime.now();
  int currentIndex = 1;
  bool isSelected = false;
  List categories = [];

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
    context.read<ExpenseDatabase>().readIncome();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.income.id),
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
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xfff5f5f5),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(18),
                    child: Text(
                      widget.income.emoji,
                      style: const TextStyle(fontSize: 28),
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
                          widget.income.des,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.fade,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          widget.income.name,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
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
                  '+\$${widget.income.amount.toStringAsFixed(2)}',
                  style: GoogleFonts.concertOne(
                    fontSize: 20,
                    color: const Color.fromARGB(255, 87, 220, 72),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  isToday(widget.income.date)
                      ? "Today"
                      : isYesterday(widget.income.date)
                          ? "Yesterday"
                          : DateFormat('MMM dd, EEEE')
                              .format(widget.income.date),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ],
            ),
          ],
        ),
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
    context.read<ExpenseDatabase>().deleteIncome(widget.income.id);
    print("deleted ${widget.income.id}");
  }

  void _handleUpdate(BuildContext context) {
    categories = context.read<ExpenseDatabase>().categories;
    List dates = context.read<ExpenseDatabase>().dates;

    // Initialize new controllers for modal sheet
    TextEditingController amountControllerModal =
        TextEditingController(text: widget.income.amount.toStringAsFixed(2));
    TextEditingController desControllerModal =
        TextEditingController(text: widget.income.des);

    String cate = "${widget.income.emoji} ${widget.income.name}";
    dynamic date = widget.income.date;
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

            // Parse and validate amount
            double amount = double.parse(amountControllerModal.text);

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
                  .deleteIncome(widget.income.id);
              await context.read<ExpenseDatabase>().addExpense(ex);

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
                  .updateIncome(widget.income.id, income);

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
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this expense?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Delete'),
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
