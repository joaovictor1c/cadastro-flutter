import 'package:flutter/material.dart';
import 'package:web/models/user.dart';

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
      title: Text(user.nome),
      subtitle: Text(user.email),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
                icon: Icon(Icons.edit),
                color: Colors.orange,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/user',
                      arguments: user);
                  // Navigator.of(context)
                  //     .pushNamed(AppRoutes.USER_FORM, arguments: );
                }),
            IconButton(
                icon: Icon(Icons.delete), color: Colors.black, onPressed: null)
          ],
        ),
      ),
    );
  }
}
