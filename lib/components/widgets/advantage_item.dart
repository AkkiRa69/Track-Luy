import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AdvantageItem extends StatelessWidget {
  final Widget widget;
  final String percent, title;
  const AdvantageItem(
      {super.key,
      required this.widget,
      required this.percent,
      required this.title});

  @override
  Widget build(BuildContext context) {
    const Color white = Colors.white;
    const Color green = Color(0xff2beb8b);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(35),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              width: 1.5,
              color: Colors.grey.shade600,
            ),
          ),
          child: Column(
            children: [
              widget,
              const Gap(20),
              Text(
                percent,
                style: const TextStyle(
                  color: green,
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
        const Gap(20),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: white,
          ),
        ),
      ],
    );
  }
}
