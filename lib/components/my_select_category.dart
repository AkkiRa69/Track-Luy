import 'package:flutter/material.dart';

class MySelectCategory extends StatelessWidget {
  final List categories;
  final void Function(dynamic)? onSelected;
  final bool isSelected;
  final String selectedCategory;
  final String initilizeSelection;
  const MySelectCategory(
      {super.key,
      required this.categories,
      required this.onSelected,
      required this.isSelected,
      required this.selectedCategory,
      required this.initilizeSelection});

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      initialSelection: initilizeSelection,
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.black.withOpacity(0.7)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
        onSelected!(value);
      },
      dropdownMenuEntries: [
        for (int i = 0; i < categories.length; i++)
          DropdownMenuEntry(
            value: categories[i],
            label: categories[i],
            labelWidget: Text(
              categories[i],
              style: TextStyle(
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
          ),
      ],
    );
  }
}
