// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  String text;
  VoidCallback onPressed;

  MyButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Theme.of(context).dividerColor,
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
            color: Theme.of(context).primaryTextTheme.bodyLarge?.color),
      ),
    );
  }
}
