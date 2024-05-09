
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/utils/colors.dart';
import '../utils/global_variables.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
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
            icon: Icon(Icons.people_alt_rounded,color: _page==1 ? primaryColor: secondaryColor,),label: "",
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
