import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web/models/user.dart';
import 'package:web/provider/user.dart';

class UserTile extends StatelessWidget {
  final User user;
  const UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl == null || user.avatarUrl.isEmpty
        ? CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl));

    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Container(
        width: 100,
        child: Row(children: [
          IconButton(
            icon: Icon(Icons.edit),
            color: Colors.orange,
            onPressed: () {
              Navigator.pushNamed(context, '/user', arguments: user);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            color: Colors.red,
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text('Excluir Usuario'),
                  content: Text('Tem certeza?'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Sim'),
                      onPressed: () {
                        Provider.of<Users>(context, listen: false).remove(user);
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: Text('nao'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            },
          )
        ]),
      ),
    );
  }
}
