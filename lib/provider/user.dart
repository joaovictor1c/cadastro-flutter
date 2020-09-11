import 'package:uuid/uuid.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:web/data/dummy_users.dart';
import 'package:web/models/user.dart';

class Users with ChangeNotifier {
  final Map<String, User> _items = {...DUMMY_USERS};

  List<User> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  User byIndex(int i) {
    return _items.values.elementAt(i);
  }

  void put(User user) {
    if (user == null) {
      return;
    }

    if (user.id != null &&
        user.id.trim().isNotEmpty &&
        _items.containsKey(user.id)) {
      _items.update(
        user.id,
        (_) => User(
            id: user.id,
            nome: user.nome,
            email: user.email,
            avatarUrl: user.avatarUrl),
      );
    } else {
      var id = Uuid().v1();
      _items.putIfAbsent(
        id,
        () => User(
          id: id,
          nome: user.nome,
          email: user.email,
          avatarUrl: user.avatarUrl,
        ),
      );
    }
    notifyListeners();
  }

  void remove(User user) {
    if (user != null && user.id != null) {
      _items.remove(user.id);
    }
    notifyListeners();
  }
}
