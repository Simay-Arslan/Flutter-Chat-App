

import 'package:flutter/material.dart';
class MyTextField extends StatelessWidget {
  const MyTextField({super.key, required this.controller, required this.hintText, required this.obsecureText});

  final TextEditingController controller;

  final String hintText;

  final bool obsecureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller ,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue)
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue)
        ),
        hintText:hintText,
        fillColor: Theme.of(context).colorScheme.primary,
        filled: false,
      ),


    );
  }
}
