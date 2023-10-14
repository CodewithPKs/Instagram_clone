import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final List followers;
  final List following;
  final String password;

  const User ({
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.username,
    required this.bio,
    required this.followers,
    required this.following,
    required this.password,
});

  Map<String, dynamic> toJson() => {
    "username": username,
    "uid": uid,
    "photoUrl": photoUrl,
    "email": email,
    "bio": bio,
    "followers": followers,
    "following": following,
    "password" : password,
  };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot['username'],
      uid: snapshot['uid'],
      email: snapshot['email'],
      photoUrl: snapshot['photoUrl'],
      bio: snapshot['bio'],
      following: snapshot['following'],
      followers: snapshot['followers'],
      password: 'password',
    );
  }

}