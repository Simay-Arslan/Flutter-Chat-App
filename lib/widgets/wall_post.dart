
import 'package:chat_app/helper/helper_methods.dart';
import 'package:chat_app/widgets/comment.dart';
import 'package:chat_app/widgets/comment_button.dart';
import 'package:chat_app/widgets/delete_button.dart';
import 'package:chat_app/widgets/like_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class WallPost extends StatefulWidget {
  const WallPost({super.key, required this.message, required this.user, required this.likes, required this.postId, required this.time, this.comId,});
 final String message;
 final String user;
 final List<String> likes;
 final String postId;
 final String time;
 final String? comId;

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {

  final currentUser = FirebaseAuth.instance.currentUser;
  bool isLiked = false;
  final _commentTextController = TextEditingController();
  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser!.email);

  }
  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference postRef = FirebaseFirestore.instance.collection(
        "User Posts")
        .doc(widget.postId);

    if (isLiked) {
      postRef.update({
        "Likes": FieldValue.arrayUnion([currentUser!.email])
      });
    } else {
      postRef.update({
        "Likes": FieldValue.arrayRemove([currentUser!.email])
      });
    }
  }

  //add a comment
  void addComment (){
  if (_commentTextController.text.isNotEmpty) {
  FirebaseFirestore.instance
      .collection("User Posts")
       .doc(widget.postId)
       .collection("Comments")
      .add({
    "CommentText": _commentTextController.text,
     "CommentedBy": currentUser!.email,
     "CommentTime": Timestamp.now(),
  });
  }
  setState(() {
  _commentTextController.clear();
  Navigator.pop(context);
  });
}
  //write the comment to firestore

  //show dialog box
  void showCommentDialog (){
    showDialog(
        context: context,
        builder: (context)=> AlertDialog(
          title: Text("Add Comment"),
          content: TextField(
          controller: _commentTextController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: "Write a comment",
            ),
          ),
          actions: [
            //cancel
            TextButton(
              onPressed: ()=> Navigator.pop(context),
              child: Text("Cancel"),
            ),

            //save
            TextButton(
              onPressed: addComment,
              child: Text("Send"),

            )

          ],
        ),
    );
  }
  void showDeleteDialog(){
    showDialog(
        context: context,
        builder: (context)=>AlertDialog(
          title: Text("Delete Post"),
          content: Text("Are you sure delete this post?"),
          actions: [
            TextButton(
              onPressed: ()=> Navigator.pop(context),
              child: Text("Cancel"),
            ),

            //save
            TextButton(
              onPressed: deletePost,
              child: Text("Delete"),
            )
          ],
        )
    );
  }
   deletePost () async {
     final commentDocs = await FirebaseFirestore.instance
                         .collection("User Posts")
                         .doc(widget.postId)
                         . collection("Comments")
                         .get();
     for ( var doc in commentDocs.docs ){
         await FirebaseFirestore.instance
             .collection("User Posts")
             .doc(widget.postId)
             . collection("Comments")
             .doc(doc.id).delete();
     }
      FirebaseFirestore.instance.collection("User Posts").doc(widget.postId)
               .delete().then((value) => debugPrint("post deleted"))
               .catchError((error)=> debugPrint("failed to delete post : $error"));

        Navigator.pop(context);

    }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.yellow.shade200,
            Colors.yellow.shade50,
          ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
          ),
          borderRadius:BorderRadius.circular(10),
        ),
        margin: EdgeInsets.only(top: 25,left: 25,right: 25),
        padding: EdgeInsets.all(25),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
          children: [
                SizedBox(width: 70,),
                 Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.message),
                  SizedBox(height:0,),

                  Row(
                    children: [
                      Text(widget.user,style: TextStyle(
                          fontSize: 10,
                          color: Colors.black54,fontWeight: FontWeight.w200
                      ),),
                      Text(" . "),
                      Text(widget.time,style: TextStyle(
                        fontSize: 10,
                          color: Colors.black54,fontWeight: FontWeight.w200
                      ),),
                    ],
                  ),
                ],
              ),
            SizedBox(width: 80,),
              if(widget.user == currentUser!.email)
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: DeleteButton(onTap: showDeleteDialog),
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: LikeButton(isLiked: isLiked, onTap: toggleLike),
                      ),

                      SizedBox(height: 15,),
                      Text(widget.likes.length.toString()),
                    ]),
                SizedBox(width: 10,),
                Column(
                  children: [
                    MyCommentButton(onPressed: showCommentDialog,
                        //onPressedCommentButton,
                        icon: Icon(Icons.comment_rounded,)
                    ),
                     Text("0")
                  ],
                ),
              ],
            ),
                StreamBuilder<QuerySnapshot>(
                    stream:FirebaseFirestore.instance.collection("User Posts")
                        .doc(widget.postId)
                        .collection("Comments")
                        .orderBy("CommentTime",descending: true)
                        . snapshots(),
                    builder: (context,snapshots){
                      if (snapshots.hasData){

                        return ListView(


                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: snapshots.data!.docs.map((doc) {
                            final commentData = doc.data() as Map < String, dynamic>;
                            return Comment(
                              text: commentData['CommentText'],
                              user: commentData['CommentedBy'],
                              time: formatDate(commentData['CommentTime'],)
                            );
                          }).toList (),
                        );
                       }else if (snapshots.hasError) {
                        return Center(child: Text("Error ${snapshots.error} "),);
                      } return Center(child: CircularProgressIndicator(),);
                   }
                ),

    ]),);
  }
}

