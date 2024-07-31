import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final bool focus;
  const MyElevatedButton(
      {super.key,
      required this.child,
      required this.onPressed,
      this.focus = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      autofocus: focus,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        side: const BorderSide(
          color: Colors.white60,
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
