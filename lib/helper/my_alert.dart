import 'package:flutter/cupertino.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

void showSuccessAlert(BuildContext context, String text) {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.success,
    text: text,
  );
}

void showInvalidAlert(BuildContext context, String text) {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.error,
    title: 'Oops...',
    text: text,
  );
}

void showCupertinoAlert(BuildContext context, String text) {
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: const Text("Invalid!"),
        content: Text(text),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}
