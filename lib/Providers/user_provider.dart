import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/Resoureces/auth_methodes.dart';
import 'package:instagram_clone/model/user.dart';

class UserProvider with ChangeNotifier {
  final AuthMethods _authMethods = AuthMethods();
  User? _user;

  User? get getUser => _user;

  Future<void> refershUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}