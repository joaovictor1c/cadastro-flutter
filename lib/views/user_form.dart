import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web/models/user.dart';
import 'package:web/provider/user.dart';

class UserForm extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  @override
  Widget build(BuildContext context) {
    final Users users = Provider.of(context, listen: false);
    // final Users user = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                // Navigator.of(context).pop(AppRoutes.USER_FORM);
                final isValid = _form.currentState.validate();
                if (isValid) {
                  _form.currentState.save();
                  users.put(
                    User(
                      id: _formData['id'],
                      nome: _formData['nome'],
                      email: _formData['email'],
                      avatarUrl: _formData['avatarUrl'],
                    ),
                  );
                  print(_formData);
                  Navigator.pushNamed(context, "/");
                  // Navigator.pushReplacementNamed(context, '/');
                }
              }),
          IconButton(
              icon: Icon(Icons.assignment_return),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
              })
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Container(
            width: 700,
            height: 900,
            color: Colors.grey[100],
            margin: EdgeInsets.fromLTRB(600, 0, 0, 0),
            alignment: Alignment.center,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Nome'),
                  onSaved: (value) => _formData['name'] = value,
                ),
                TextFormField(
                    decoration: InputDecoration(labelText: 'email'),
                    onSaved: (value) => _formData['email'] = value),
                TextFormField(
                    decoration: InputDecoration(labelText: 'Url do Avatar'),
                    onSaved: (value) => _formData['avatarUrl'] = value),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
