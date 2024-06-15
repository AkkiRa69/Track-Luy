import 'package:flutter/material.dart';

class MyNumField extends StatefulWidget {
  final String text;
  final String hintText;
  final TextEditingController? controller;

  const MyNumField({
    super.key,
    required this.text,
    required this.hintText,
    required this.controller,
  });

  @override
  _MyNumFieldState createState() => _MyNumFieldState();
}

class _MyNumFieldState extends State<MyNumField> {
  bool _showError = false;

  void _validateInput() {
    setState(() {
      _showError = widget.controller?.text.isEmpty ?? true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            controller: widget.controller,
            autofocus: true,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            style: TextStyle(
              color: Theme.of(context).colorScheme.surface,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              // errorText: _showError ? 'This field can1not be empty' : null,
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
