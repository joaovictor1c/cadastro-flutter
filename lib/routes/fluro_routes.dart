import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart' as Fluro;
import 'package:web/views/user_form.dart';
import 'package:web/views/users_list.dart';

class FluroRouter {
  static final router = Fluro.Router();
  static Fluro.Handler _userForm = Fluro.Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        UserForm(),
  );
  static Fluro.Handler _home = Fluro.Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        UserList(),
  );
  static void setupRouter() {
    router.define(
      '/',
      handler: _home,
    );
    router.define(
      '/user',
      handler: _userForm,
    );
  }
}
