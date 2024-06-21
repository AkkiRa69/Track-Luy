import 'package:akkhara_tracker/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyEmojiField extends StatelessWidget {
  final String text;
  final String hintText;
  final TextEditingController? controller;

  const MyEmojiField({
    super.key,
    required this.text,
    required this.hintText,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "$text ",
              style: const TextStyle(color: AppColors.text),
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
              color: AppColors.grey,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(2),
          child: TextField(
            autofocus: true,
            autocorrect: true,
            controller: controller,
            keyboardType: TextInputType.text,
            inputFormatters: [LengthLimitingTextInputFormatter(1)],
            style: TextStyle(
              color: Theme.of(context).colorScheme.surface,
              fontSize: 14,
            ),
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
