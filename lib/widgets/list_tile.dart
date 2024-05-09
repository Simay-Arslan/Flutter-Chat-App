import 'package:flutter/material.dart';
class MyListTile extends StatelessWidget {
  const MyListTile({super.key, required this.icon, required this.text, required this.onTap});
   final IconData icon;
   final String text;
   final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: ListTile(
        leading: Icon(icon),
        onTap: onTap,
        iconColor: Colors.purple,
        title: Text(text,style: TextStyle(color: Colors.purple,fontWeight: FontWeight.bold),)
      ),
    );
  }
}
