

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class UsersPage extends StatelessWidget {

  UsersPage({super.key,

  });
  final TextEditingController searchController = TextEditingController();
  final String newValue="";


  @override
  Widget build(BuildContext context) {

     return Scaffold(
       backgroundColor: Theme.of(context).colorScheme.background,
       appBar: AppBar(
         centerTitle: true,
         title: Text("USERS"),
       ),
       body:
             Center(
               child: Container(
    padding: EdgeInsets.all(20),
    width: 500,
    height: 800,
    decoration: BoxDecoration(
    gradient: LinearGradient(colors: [
    Colors.yellowAccent,
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
                         .collection("users")
                 /*.where(
                    'username',
                    isGreaterThanOrEqualTo: searchController.text,)*/
                     .snapshots(),

                   builder: (context, snapshot) {
                     if (snapshot.hasData) {
                       final users = snapshot.data!.docs;
                       return ListView.builder(
                           itemCount: users.length,
                           itemBuilder: (context, index) {
                             final user = users[index];
                             return ListTile(
                               title: Text(user['username']) ,
                               subtitle: Text(user['bio']),
                               leading: Icon(Icons.person),

                             );
                           }
                       );
                     } else if (snapshot.hasError) {
                       return Center(child: Text("Error ${snapshot.error} "),);
                     }
                     return Center(child: CircularProgressIndicator(),);
                   }
                     )
                     ),],
                 ),
               ),
             ),
       );

  }
}
