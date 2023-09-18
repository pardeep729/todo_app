// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:todo_app/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).primaryColor,
      content: Container(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Get user input
              TextField(
                controller: controller,
                style: TextStyle(
                    color: Theme.of(context).primaryTextTheme.bodyLarge?.color),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyLarge
                                    ?.color ??
                                Colors.black)),
                    hintText: "Add a new TODO",
                    hintStyle: TextStyle(
                        color: Theme.of(context)
                            .primaryTextTheme
                            .bodyLarge!
                            .color
                            ?.withOpacity(0.7))),
              ),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Save Button
                  MyButton(text: "Save", onPressed: onSave),

                  // Cancel Button
                  MyButton(text: "Cancel", onPressed: onCancel),
                ],
              ),
            ],
          )),
    );
  }
}
