import 'package:flutter/material.dart';
class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.text, required this.onPressed, });


  final String text;
  final void Function() onPressed;


  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: 300,
        height: 60,
        decoration: BoxDecoration(
        color: Colors.blue,
      ),
      child: Text(text,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),


      ),
    );
  }
}
