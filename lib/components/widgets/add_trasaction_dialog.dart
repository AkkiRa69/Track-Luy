import 'package:akkhara_tracker/components/widgets/my_emoji_filed.dart';
import 'package:akkhara_tracker/components/widgets/my_num_field.dart';
import 'package:akkhara_tracker/components/widgets/my_select_category.dart';
import 'package:akkhara_tracker/components/widgets/my_select_date.dart';
import 'package:akkhara_tracker/components/widgets/my_text_field.dart';
import 'package:akkhara_tracker/components/widgets/my_toggle_switch.dart';
import 'package:akkhara_tracker/components/widgets/save_button.dart';
import 'package:akkhara_tracker/models/expense_database.dart';
import 'package:akkhara_tracker/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTransactionSheet extends StatefulWidget {
  final int currentIndex;
  final Function(int?)? onToggle;
  final TextEditingController amountController;
  final TextEditingController desController;
  final TextEditingController emojiController;
  final TextEditingController cateNameController;
  final List<dynamic> categories;
  final Function(String)? onSelectedCategory;
  final bool isSelected;
  final String selectedCategory;
  final DateTime selectedDate;
  final Function(DateTime?)? onSelectedDate;
  final VoidCallback? onSave;
  final String initilizeSelection;
  final List pastDays;
  final dynamic initDate;

  const AddTransactionSheet(
      {super.key,
      required this.currentIndex,
      required this.onToggle,
      required this.amountController,
      required this.desController,
      required this.emojiController,
      required this.cateNameController,
      required this.categories,
      required this.onSelectedCategory,
      required this.isSelected,
      required this.selectedCategory,
      required this.selectedDate,
      required this.onSelectedDate,
      required this.onSave,
      required this.initilizeSelection,
      required this.pastDays,
      required this.initDate});

  @override
  _AddTransactionSheetState createState() => _AddTransactionSheetState();
}

class _AddTransactionSheetState extends State<AddTransactionSheet> {
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
          const Padding(
            padding: EdgeInsets.only(
              bottom: 20,
            ),
            child: Text(
              "Add Transaction",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: MyToggleSwitch(
              currentIndex: widget.currentIndex,
              onToggle: (index) => widget.onToggle!(index),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Expanded(
                  child: MyNumField(
                    text: "Amount",
                    hintText: "0.00 USD",
                    controller: widget.amountController,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: MyTextField(
                    text: "Description",
                    hintText: "Expense Description",
                    controller: widget.desController,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                Text(
                  "Category ",
                  style: TextStyle(color: AppColors.text),
                ),
                Text(
                  "*",
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: MySelectCategory(
                      categories: widget.categories,
                      onSelected: (value) => widget.onSelectedCategory!(value),
                      isSelected: widget.isSelected,
                      selectedCategory: widget.selectedCategory,
                      initilizeSelection: widget.initilizeSelection,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6, bottom: 12),
            child: Row(
              children: [
                const Text(
                  "Don't see a category you need?   ",
                  style: TextStyle(
                    color: AppColors.text,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        actions: [
                          SaveButton(
                            onPreesed: () {
                              Navigator.pop(context);
                              widget.emojiController.clear();
                              widget.cateNameController.clear();
                            },
                            text: 'Cancel',
                          ),
                          SaveButton(
                            onPreesed: () {
                              context.read<ExpenseDatabase>().addCategory(
                                  widget.emojiController.text,
                                  widget.cateNameController.text);
                              Navigator.pop(context);
                              widget.emojiController.clear();
                              widget.cateNameController.clear();
                            },
                            text: 'Add',
                          ),
                        ],
                        backgroundColor: Colors.black,
                        title: const Text(
                          "Add your own category",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        content: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: MyEmojiField(
                                        text: "Emoji",
                                        hintText: "👍",
                                        controller: widget.emojiController,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      flex: 3,
                                      child: MyTextField(
                                        text: "Name",
                                        hintText: "Enter new name",
                                        controller: widget.cateNameController,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "+ Add category",
                    style: TextStyle(
                      color: AppColors.text,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.text,
                      decorationThickness: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Row(
            children: [
              Text(
                "Date ",
                style: TextStyle(
                  color: AppColors.text,
                ),
              ),
              Text(
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
                      color: AppColors.grey,
                    ),
                  ),
                  child: MySelectDate(
                    initDate: widget.initDate,
                    onSelected: (value) => widget.onSelectedDate!(value),
                    selectedDate: widget.selectedDate,
                    pastDays: widget.pastDays,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 20),
            child: Row(
              children: [
                Expanded(
                  child: SaveButton(
                    onPreesed: widget.onSave,
                    text: 'Save',
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
