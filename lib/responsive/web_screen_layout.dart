import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/global_variables.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState (){
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose (){
    super.dispose();
    pageController = PageController();
  }
  navigationTapped (int page){
    pageController.jumpToPage(page);
  }
  void onPageChanged (int page) {
    setState(() {
      _page= page ;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: homeScreenItems,
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged:onPageChanged ,
      ),
      bottomNavigationBar:CupertinoTabBar(
        backgroundColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color: _page==0 ? primaryColor: secondaryColor,),label: "",
            backgroundColor: primaryColor,),
          BottomNavigationBarItem(
            icon: Icon(Icons.search,color: _page==1 ? primaryColor: secondaryColor,),label: "",
            backgroundColor: primaryColor,),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,color: _page==2 ? primaryColor: secondaryColor,),label: "",
            backgroundColor: primaryColor,),

        ],
        onTap: navigationTapped,
      ),
    );
  }
}
