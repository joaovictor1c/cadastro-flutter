import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web/routes/fluro_routes.dart';

import 'package:web/views/users_list.dart';
import './provider/user.dart';

void main() {
  FluroRouter.setupRouter();
  runApp(Digital());
}

class Digital extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Users(),
        ),
      ],
      child: (MaterialApp(
          debugShowCheckedModeBanner: false,
          home: UserList(),
          onGenerateRoute: FluroRouter.router.generator)),
    );
  }
}
