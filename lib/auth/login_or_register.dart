import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/sign_up.dart';
import 'package:flutter/material.dart';


class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage =true;

  void togglePages (){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage){
      return LoginScreen();

    }else {
      return SignupScreen();

    }
  }
}
