import 'package:flutter/material.dart';
class Comment extends StatelessWidget {
   Comment ({super.key,
     required this.text,
     required this.user,
     required this.time });
  final String text;
  final String user;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.purple.shade400,
          Colors.purple.shade400,
        ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      margin: EdgeInsets.only(bottom: 5),
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //comment
          Text(text, style: TextStyle(
            color: Colors.grey[100]
          ),),
          SizedBox(height: 5,),
          
          // user and time
          
          Row(
            children: [
              Text(user, style: TextStyle(color: Colors.grey[500]),),
              Text(" . "),
              Text(time, style: TextStyle(color: Colors.grey[500]),)
            ],
          )
        ],
      ),
    );
  }
}
