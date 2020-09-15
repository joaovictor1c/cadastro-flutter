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
        automaticallyImplyLeading: false,
        actions: [],
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            Text('Usuários'),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/user');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          width: 700,
          height: 900,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: ListView.builder(
            itemCount: users.count,
            itemBuilder: (ctx, i) => UserTile(users.byIndex(i)),
          ),
        ),
      ),
    );
  }
}
