
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/models/user.dart' as model;
import 'package:chat_app/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future <model.User> getUserDetails () async {
    User currentUser= _auth.currentUser!;
    DocumentSnapshot snap = await _firestore.collection("users").doc(currentUser.uid).get();

    return model.User.fromSnap(snap);

  }
  // Sign Up User
  Future<String>signUpUser ({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty || bio.isNotEmpty) {
        //registeruser
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user?.uid);

        String photoUrl = await StorageMethods().uploadImageToStorage("profilePics", file, false);

        //add user to our database
        // create a user from model
        model.User user = model.User(
          username: username,
          uid:cred.user!.uid,
          email: email,
          bio: bio,
          photoUrl:photoUrl,

        );
        await _firestore.collection("users").doc(cred.user!.uid).set(user.toJson(),);

        res = "sucsess";
      }
    }

    catch(err){
      res = err.toString();
    }
    return res;
  }
  //login user
  Future<String> loginUser ({
    required String email,
    required String password
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty ){
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err){
      res= err.toString();
    }
    return res;
  }

  Future <void> signOut () async {
    _auth.signOut();
  }

}
