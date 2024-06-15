import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final String text;
  final String hintText;
  final TextEditingController? controller;

  const MyTextField({
    super.key,
    required this.text,
    required this.hintText,
    this.controller,
  });

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _showError = false;

  void _validateInput() {
    setState(() {
      _showError = widget.controller?.text.isEmpty ?? true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align left
      children: [
        Row(
          children: [
            Text(
              "${widget.text} ",
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
              color: _showError
                  ? Colors.red
                  : Theme.of(context).colorScheme.tertiary,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(2),
          child: TextField(
            autocorrect: true,
            controller: widget.controller,
            textCapitalization: TextCapitalization.words,
            style: TextStyle(
              color: Theme.of(context).colorScheme.surface,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
              contentPadding: const EdgeInsets.all(15),
              hintText: widget.hintText,
              hintStyle: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.tertiary,
              ),
              border: InputBorder.none,
            ),
            onChanged: (text) {
              _validateInput();
            },
            onEditingComplete: () {
              _validateInput();
              FocusScope.of(context)
                  .nextFocus(); // Move focus to the next field
            },
          ),
        ),
        if (_showError)
          const Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text(
              'This field cannot be empty',
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}
