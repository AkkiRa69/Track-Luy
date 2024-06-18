import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class MyToggleSwitch extends StatelessWidget {
  final int currentIndex;
  final void Function(int?)? onToggle;
  const MyToggleSwitch(
      {super.key, required this.currentIndex, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xff2f2f2f),
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      padding: const EdgeInsets.only(left: 3, top: 3, bottom: 3),

      //expense + income button
      child: Row(
        children: [
          Expanded(
            child: ToggleSwitch(
              minWidth: double.infinity,
              minHeight: 50,
              cornerRadius: 50.0,
              animate: true,
              animationDuration: 200,
              curve: Curves.linearToEaseOut,
              activeBgColors: const [
                [Color(0xff4e4d4d)],
                [Color(0xff4e4d4d)]
              ],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.transparent,
              inactiveFgColor: Colors.white,
              initialLabelIndex: currentIndex,
              totalSwitches: 2,
              labels: const ['Expense', 'Income'],
              radiusStyle: true,
              onToggle: (index) => onToggle!(index),
            ),
          ),
        ],
      ),
    );
  }
}
