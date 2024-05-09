
import 'package:chat_app/helper/helper_methods.dart';
import 'package:chat_app/widgets/drawer.dart';
import 'package:chat_app/widgets/text_field.dart';
import 'package:chat_app/widgets/wall_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/resources/auth_methods.dart';
import 'package:chat_app/widgets/drawer.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  FirebaseAuth auth = FirebaseAuth.instance;

  final currentUser = FirebaseAuth.instance.currentUser!;

  final _postTextController= TextEditingController();

  void onSignOut () {
    AuthMethods().signOut();
    Navigator.pushNamed(context, '/login_screen');
    //Navigator.pop(context);
  }

  void postMessage (){
    if(_postTextController.text.isNotEmpty) {
      FirebaseFirestore.instance
          .collection("User Posts")
          .add({
        "UserEmail": currentUser.email,
        "Message": _postTextController.text,
        "TimeStamp": Timestamp.now(),
        "Likes":[]
      });
    }
    setState(() {
      _postTextController.clear();
    });
  }

  /*void onSignOut () {

  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text("THE WALL"),
        backgroundColor: Colors.purple.shade900,
      ),
      drawer: MyDrawer(),
      body: Center(
        child: Container(
          width: 500,
          height: 800,
          decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
          Colors.lightGreenAccent.shade700,
              Colors.lightBlueAccent,
              ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight
          ),
        ),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("User Posts")
                      .orderBy("TimeStamp",descending: false)
                      .snapshots(),
                  builder: (context,snapshot){
                    if(snapshot.hasData){
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context,index){
                            final post = snapshot.data!.docs[index];
                            return WallPost(
                                message:post["Message"],
                                user: post["UserEmail"],
                                 likes: List<String>.from(post["Likes"] ?? []),
                                 postId: post.id,
                                 time: formatDate(post['TimeStamp']),
                            );
                          }
                      );
                    } else if (snapshot.hasError){
                      return Center(
                        child: Text ("Error: ${snapshot.error}"),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    //Navigator.pop(context);

                    );
                  }
                )),
              Row(
                        children: [

                          Expanded(child: Padding(
                            padding: const EdgeInsets.only(left: 20,right: 10,bottom: 10,top: 15),
                            child: MyTextField(controller: _postTextController, hintText: "write something on the wall", obsecureText: false),
                          )),
                          SizedBox(width: 5,),
                          GestureDetector(
                            onTap: postMessage,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15,bottom: 10,),
                                child: Icon(Icons.arrow_circle_up_outlined),
                              ))
                        ],
                      ),

                  GestureDetector(onTap: onSignOut, child: Text("Logged as " + currentUser.email!)),
                  Padding(padding: EdgeInsets.only(bottom: 10))
    ],
              ),
        ),
      ),

    );
  }
}
