import 'package:flutter/material.dart';
import 'package:todo_app/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  DialogBox({required this.controller, required this.onCancel, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow.shade300,
     content: Container(
       height: 120,
       child: Column(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: [
           TextField(
             controller: controller,
             decoration: InputDecoration(border: OutlineInputBorder(),
               hintText: 'Add a new task',
             ),
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.end,
             children: [
             MyButton(text: 'Save', onPressed: onSave),
             SizedBox(width: 10),
             MyButton(text: 'Cancel', onPressed: onCancel),

           ],)
         ],
       ),
     ),
    );
  }
}
