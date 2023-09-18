// ignore_for_file: prefer_const_constructors, prefer_final_fields, must_be_immutable, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String textValue;
  Function(BuildContext)? deleteFunction;
  Function(bool?)? onChanged;
  final bool checkboxValue;

  TodoTile(
      {Key? key,
      required this.textValue,
      required this.checkboxValue,
      required this.deleteFunction,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
        child: Slidable(
          endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                onPressed: deleteFunction,
                icon: Icons.delete,
                backgroundColor: Colors.red.shade300,
                borderRadius: BorderRadius.circular(10),
              )
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              color: checkboxValue
                  ? Colors.grey[300]
                  : Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Checkbox(
                  value: checkboxValue,
                  onChanged: onChanged,
                  activeColor: Theme.of(context).hintColor,
                  side: BorderSide(
                    color:
                        Theme.of(context).primaryTextTheme.bodyLarge?.color ??
                            Colors.black,
                    width: 2,
                  ),
                ),
                Flexible(
                  child: Text(
                    textValue,
                    style: TextStyle(
                      fontSize: 20,
                      color: checkboxValue
                          ? Colors.grey
                          : Theme.of(context).primaryTextTheme.bodyLarge?.color,
                      decoration: checkboxValue
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
