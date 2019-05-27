import 'package:flutter/material.dart';

class UserBloc extends ChangeNotifier {

  var _users;

  get users => _users;

  set users(u) {
    _users = u;
    notifyListeners();
  }

}