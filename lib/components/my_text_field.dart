import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String text;
  final String hintText;
  final TextEditingController? controller;
  const MyTextField(
      {super.key,
      required this.text,
      required this.hintText,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "$text ",
              style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
            ),
            const Text(
              "*",
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
        const SizedBox(
          height: 6,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.tertiary,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(2),
          child: TextField(
            controller: controller,
            style: TextStyle(
                color: Theme.of(context).colorScheme.surface, fontSize: 14),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15),
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.tertiary,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
