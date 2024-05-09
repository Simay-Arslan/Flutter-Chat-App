import 'package:flutter/material.dart';
class MyTextBox extends StatelessWidget {
  const MyTextBox({super.key, required this.text, required this.sectionname, required this.onPressed});
  final String text;
  final String sectionname;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 25,left: 20),
      decoration: BoxDecoration(

      color: Colors.lightBlueAccent.shade400,
    borderRadius: BorderRadius.circular(20),),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(sectionname,style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold
              ),
              ),

              IconButton(onPressed: onPressed, icon: Icon(Icons.settings))
            ],
          ),

          Text(text,),
        ],
        ),
    );
  }
}

