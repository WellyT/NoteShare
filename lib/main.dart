import 'package:flutter/material.dart';
import 'package:noteshare/providers/notations.dart';
import 'package:noteshare/routes/routes.dart';
import 'package:noteshare/view/notation_list.dart';
import 'package:noteshare/view/user_form.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Notations(),
        )
      ],
      child: MaterialApp(
        title: 'NoteShare',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          AppRoutes.HOME: (_) => NotationList(),
          AppRoutes.USER_FORM: (_) => UserForm()
        },
      ),
    );
  }
}
