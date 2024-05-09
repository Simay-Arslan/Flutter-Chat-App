import 'package:chat_app/responsive/web_screen_layout.dart';
import 'package:flutter/material.dart';
import '../providers/user_provider.dart';
import '../utils/global_variables.dart';
import 'mobile_screen_layout.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget? webScreenLayout;
  final Widget? mobileScreenLayout;
  const ResponsiveLayout({super.key, this.webScreenLayout, this.mobileScreenLayout});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {

  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userProvider= Provider.of(context,listen:false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context,constraints) {
          if (constraints.maxWidth > webScreenSize) {
            //web screen
            return WebScreenLayout();
          }
          //mobile screen
          return MobileScreenLayout();
        }

    );
  }
}
