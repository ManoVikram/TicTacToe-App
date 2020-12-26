import 'package:flutter/material.dart';

class CustomDialogBox extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback callback;
  final String actionText;

  CustomDialogBox(
    this.title,
    this.content,
    this.callback, [
    this.actionText = "RESET",
  ]);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        FlatButton(
          onPressed: callback,
          child: Text(actionText),
          color: Colors.white,
        ),
      ],
    );
  }
}
