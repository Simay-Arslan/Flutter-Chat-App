
import 'package:chat_app/resources/auth_methods.dart';
import 'package:chat_app/responsive/mobile_screen_layout.dart';
import 'package:chat_app/widgets/list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';




class MyDrawer extends StatefulWidget {

   MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {



  void goToHomePage (){
    //Navigator.pushNamed(context, '/home_page');
    Navigator.push(context,
        MaterialPageRoute(builder: (context){
          return MobileScreenLayout();
        }));
  }
  void goToProfilePage (){
    /*Navigator.push(context,
        MaterialPageRoute(builder: (context){
          return ProfilePage();
        }));*/
    Navigator.pushNamed(context, '/profile_page');
  }
  void onSignOut () {
    AuthMethods().signOut();
    Navigator.pushNamed(context, '/login_screen');
    //Navigator.pop(context);
  }
  void goToUsersPage(){
    Navigator.pushNamed(context, '/users_page');
  }



  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Drawer(

    // backgroundColor: Colors.lightGreenAccent,
    child: Container(
    width: 500,
    height: 700,
    decoration: BoxDecoration(
    gradient: LinearGradient(colors: [
    Colors.deepPurple.shade300,
    Colors.cyan.shade100,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight
    ),
    ),
    child: Column(

    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [

    Column(

    children: [
      SizedBox(height: 100,),


     CircleAvatar(
                  radius: 64,
                  backgroundImage: NetworkImage(
                    userProvider.getUser.photoUrl
                  ),),

      SizedBox(height: 40,),

    Divider(height: 20,),
    Column(
    mainAxisAlignment: MainAxisAlignment.center,

    children: [
    MyListTile(icon: Icons.home, text: "H O M E", onTap: goToHomePage),
    ],)


    ],
    ),
    Column(
    children: [
    Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: MyListTile(icon: Icons.logout_outlined, text: "S I G N  O U T", onTap: onSignOut),
    ),
    ],
    )
    ],
    ),
    ));

  }
}
