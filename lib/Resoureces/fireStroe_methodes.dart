import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/Resoureces/storage_methodes.dart';
import 'package:instagram_clone/model/post.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethodes {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post
  Future<String> uploadPost(
      String description,
      Uint8List file,
      String uid,
      String username,
      String profImage,
      ) async {
    String res = "some error occured";
    try {
      String photoUrl =
          await StorageMethodes().uploadImageToStorage("posts", file, true);

      String postId = const Uuid().v1();
      Posts posts = Posts(
          description: description,
          uid: uid,
          username: username,
          postId: postId,
          dateOfPublish: DateTime.now(),
          postUrl:  photoUrl ,
          profImage: profImage,
          likes: []);

      _firestore.collection('posts').doc(postId).set(posts.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
  
  Future<void> likePost(String postId, String uid, List likes) async {
    try{
      if(likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch(e) {
      print(e.toString());
    }
  }

  Future<void> postComment(String postId, String text, String uid, String name, String porfilePic) async {
    try {
      if(text.isNotEmpty) {
        String commentId = const Uuid().v1();
        await _firestore.collection('posts').doc(postId).collection('comments').doc(commentId).set({
          'porfilePic': porfilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now()
        });
      } else {
        print("Text is empty");
      }
    } catch(e) {
      print(e.toString());
    }
  }

  Future<void> deletePost(String postId) async {
    try{
      await _firestore.collection('posts').doc(postId).delete();
    } catch(err) {
      print(err.toString());
    }
  }
  
  Future<void> followUser(String uid, String followId) async {
    try{
      DocumentSnapshot snap = await _firestore.collection('user').doc(uid).get();

      List following = (snap.data()! as dynamic)['following'];

      if(following.contains(followId)) {
        await _firestore.collection('user').doc(followId).update({
          'followers' : FieldValue.arrayRemove([uid])
        });
        await _firestore.collection('user').doc(uid).update({
          'following' : FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection('user').doc(followId).update({
          'followers' : FieldValue.arrayUnion([uid])
        });
        await _firestore.collection('user').doc(uid).update({
          'following' : FieldValue.arrayUnion([followId])
        });
      }
    } catch(e) {
      print(e.toString());
    }
  }
}
