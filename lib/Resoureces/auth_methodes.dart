import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Resoureces/storage_methodes.dart';
import 'package:instagram_clone/model/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap = await _firestore.collection('user').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }


  // sign up
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
}) async {
    String res = "Some erroe occured";
    try{
      if(email.isNotEmpty || password.isNotEmpty || username.isNotEmpty || bio.isNotEmpty ||file != null){
        //register the user
        UserCredential credential =  await _auth.createUserWithEmailAndPassword(email: email, password: password);

        String photoUrl = await StorageMethodes().uploadImageToStorage('profilePics', file, false);

       // add user to our database
        model.User user = model.User(
          username: username,
          password: password,
          uid: credential.user!.uid,
          email: email,
          bio: bio,
          photoUrl: photoUrl,
          followers: [],
          following: []
        );

        await _firestore.collection('user').doc(credential.user!.uid).set(user.toJson());
        res = "success";
      }
    }
    catch(err) {
      res = err.toString();
    }
    return res;
}

// Login the user
Future<String> loginUaser({
    required String email,
    required String password
})async {
    String res = "some error occured";
    try{
     if(email.isNotEmpty || password.isNotEmpty){
       await _auth.signInWithEmailAndPassword(email: email, password: password);
       res = "success";
     } else {
       res = "Please enter all the fields";
     }
    }
    catch(err) {
      res = err.toString();
    }
    return res;
}

Future<void> signOut() async{
    await _auth.signOut();
}

}