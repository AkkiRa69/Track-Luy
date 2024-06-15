import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final void Function()? onPreesed;
  final String text;
  const SaveButton({super.key, required this.onPreesed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: onPreesed,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(text),
        ),
      ),
    );
  }
}
