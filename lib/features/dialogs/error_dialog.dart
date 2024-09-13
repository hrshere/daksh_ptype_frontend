import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorDialog extends StatelessWidget {
  final String errorText;
  final Function onPressed;

  const ErrorDialog({super.key, required this.errorText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      actions: <Widget>[TextButton(onPressed: () => onPressed.call(), child: const Text("OK"))],
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        const Icon(
          Icons.error_outline_rounded,
          size: 96,
          // color: IconsColor.grey,
        ),
        const SizedBox(height: 15),
        Text(
          errorText,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.grey),
        ),
        // SizedBox(height: 10),
        // Align(alignment: Alignment.bottomRight,child: TextButton(onPressed: removeErrorDialog, child: Text("OK"))),
      ]),
    );
  }

  static showErrorDialog(
      {String errorText = "Something Went Wrong",
        required Function onPressed}) {
    Get.dialog(
        ErrorDialog(
          errorText: errorText,
          onPressed: onPressed,
        ),
        barrierDismissible: false);
  }
}
