import 'dart:io';
import 'package:chat_app/widgets/text_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  XFile? image;




   Future <void> editField (String field) async {
     String newValue = "";
     await showDialog (
     context: context,
     builder: (context) =>AlertDialog(
       title: Text("Edit $field"),
       content: TextField(
         autofocus: true,
         decoration: InputDecoration(
           hintText: "Enter a new $field",
         ),
         onChanged: (value){
           setState(() {
             newValue = value;
           });
         },
       ),
       actions: [
         //cancel
         TextButton(
             onPressed: ()=> Navigator.pop(context),
             child: Text("Cancel"),
         ),

         //save
         TextButton(
           onPressed: ()=> Navigator.pop(context),
           child: Text("Save"),
         )

       ],
     )
     );
     if (newValue.trim().length > 0 ){
       FirebaseFirestore.instance.collection("users").doc(currentUser.uid).update({field:newValue});
     }
  }



  Future<XFile?> pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery, // Or ImageSource.camera
    );
    return pickedFile;
  }

  Future<XFile?> pickImageCam () async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.camera, // Or ImageSource.camera
    );
    return pickedFile;
  }

  Future<String> uploadImage(XFile image) async {
    final storage = FirebaseStorage.instance;
    final fileName = image.path.split('/').last; // Extract filename
    final reference = storage.ref().child('profilePics/$fileName');
    final uploadTask = reference.putFile(File(image.path));


    final snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  Future<void> updateUserProfile(String imageUrl) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final docRef = FirebaseFirestore.instance.collection('users').doc(currentUser.uid);
      await docRef.update({
        'photoUrl': imageUrl,
      });
    } else {
      // Handle case where user is not authenticated
      print('User not logged in, cannot update profile');
    }
  }

  Future <void> selectImage (BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
      return SimpleDialog(
          title: Text("Change Your Photo"),
    children: [
    SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text("Take From Camera"),
                onPressed: () async {
                  Navigator.of(context).pop;
    final pickedImage = await pickImageCam();
    if (pickedImage != null) {
    final imageUrl = await uploadImage(pickedImage);
    await updateUserProfile(imageUrl);
    // Update UI to display the new profile picture

    }}
              ),
     SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text("Choose From Gallery"),
                onPressed: () async {
                    Navigator.of(context).pop;
                                final pickedImage = await pickImage();
                                if (pickedImage != null) {
                                  final imageUrl = await uploadImage(pickedImage);
                                  await updateUserProfile(imageUrl);
                                  // Update UI to display the new profile picture

                                }}

     )]);});}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        title: Text("PROFILE PAGE"),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection("users").doc(currentUser.uid).snapshots(),
        builder: (context, snaphots){
          //get user data
          if(snaphots.hasData){
            final userData = snaphots.data!.data() as Map<String,dynamic>;

            return Center(
              child: Container(

                alignment: Alignment.center,
                padding: EdgeInsets.all(20),
                width: 500,
                height: 800,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.orange.shade400,
                    Colors.lightBlueAccent,
                  ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight
                  ),
                ),
                child: ListView(
                  children: [
                    SizedBox(height: 10),

                    Stack(
                      alignment: Alignment.center,
                        children : [

                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(userData['photoUrl']),
                            backgroundColor: Colors.blue,
                          ),
                          Positioned(
                              bottom: -10,
                              left: 80,
                              right: 0,
                              top: 60,
                              child: IconButton(
                                icon: Icon(Icons.mode_edit),
                                onPressed: () => selectImage(context),


                              )
                          ),]),
                    SizedBox(height: 59,),
                    Text(currentUser.email!,
                      textAlign: TextAlign.center,),


                    SizedBox(height: 20,),
                    Text("My Details",style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    ),
                    ),
                    SizedBox(height: 20,),
                    MyTextBox(text: userData['username'], sectionname: "User Name", onPressed: () => editField("username")),
                    SizedBox(height: 20,),
                    MyTextBox(text: userData['bio'], sectionname: "Bio",onPressed: () => editField("bio")),
                  ],
                ),
              ),
            );
          } else if (snaphots.hasError){
            return Center(child: Text("Error ${snaphots.error}"),);
          }
          return Center(child: CircularProgressIndicator(),);
        },
      )
    );
  }
}



