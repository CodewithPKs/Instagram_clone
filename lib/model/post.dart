import 'package:cloud_firestore/cloud_firestore.dart';

class Posts{
  final String description;
  final String uid;
  final String username;
  final String postId;
  final  dateOfPublish;
  final String postUrl;
  final String profImage;
  final likes;

  const Posts ({
    required this.description,
    required this.uid,
    required this.username,
    required this.postId,
    required this.dateOfPublish,
    required this.postUrl,
    required this.profImage,
    required this.likes
  });

  Map<String, dynamic> toJson() => {
    "username": username,
    "uid": uid,
    "description": description,
    "postId": postId,
    "dateOfPublish": dateOfPublish,
    "postUrl": postUrl,
    "profImage": profImage,
    "likes" : likes,
  };

  static Posts fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Posts(
      username: snapshot['username'],
      uid: snapshot['uid'],
      description: snapshot['description'],
      postId: snapshot['postId'],
      dateOfPublish: snapshot['dateOfPublish'],
      postUrl: snapshot['postUrl'],
      profImage: snapshot['profImage'],
      likes: 'likes',
    );
  }

}