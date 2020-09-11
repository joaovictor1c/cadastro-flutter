import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web/components/user_tile.dart';
import 'package:web/provider/user.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Users users = Provider.of(context);

    return Scaffold(
        appBar: AppBar(
            actions: [],
            centerTitle: true,
            backgroundColor: Colors.blue,
            title: Row(
              children: [
                Text('Cadastro'),
                IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/user');
                    }),
              ],
            )),
        body: ListView.builder(
            itemCount: users.count,
            itemBuilder: (ctx, i) => UserTile(users.byIndex(i))));
  }
}
