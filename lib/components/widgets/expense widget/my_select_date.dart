import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MySelectDate extends StatelessWidget {
  final void Function(dynamic)? onSelected;
  final DateTime selectedDate;
  final List pastDays;
  final dynamic initDate;
  const MySelectDate(
      {super.key,
      required this.onSelected,
      required this.selectedDate,
      required this.pastDays,
      required this.initDate});

  @override
  Widget build(BuildContext context) {
    print(pastDays);
    return DropdownMenu(
      initialSelection: initDate,
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(
          Colors.black.withOpacity(0.7),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
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
        onSelected!(value);
      },
      dropdownMenuEntries: [
        for (int i = 0; i < pastDays.length; i++)
          DropdownMenuEntry(
            value: pastDays[i],
            label: i == 0
                ? 'Today'
                : i == 1
                    ? 'Yesterday'
                    : DateFormat('MMM dd (EEEE)').format(pastDays[i]),
            labelWidget: Text(
              i == 0
                  ? 'Today'
                  : i == 1
                      ? 'Yesterday'
                      : DateFormat('MMM dd (EEEE)').format(pastDays[i]),
              style: TextStyle(
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
          ),
      ],
    );
  }
}
