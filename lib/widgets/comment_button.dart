import 'package:flutter/material.dart';
class MyCommentButton extends StatelessWidget {
  const MyCommentButton({super.key, required this.onPressed, required this.icon});
  final void Function() onPressed;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: icon,color: Colors.green[600],
    );
  }
}
