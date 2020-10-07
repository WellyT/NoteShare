import 'package:custom_splash/custom_splash.dart';
import 'package:flutter/material.dart';
import 'package:noteshare/providers/notations_provider.dart';
import 'package:noteshare/routes/routes.dart';
import 'package:noteshare/view/notation_list.dart';
import 'package:noteshare/view/user_form.dart';
import 'package:provider/provider.dart';
import 'package:noteshare/view/welcome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: CustomSplash(
          backGroundColor: const Color.fromARGB(242, 242, 242, 255),
          imagePath: 'assets/icon/logo.png',
          home: HomeStart(),
          duration: 3000,
          type: CustomSplashType.StaticDuration,
        )

    );
  }
}
class HomeStart extends StatelessWidget {
  const  HomeStart({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider<NotationsProvider>.value(
          value: NotationsProvider(),
        )
      ],
      child: MaterialApp(
        title: 'NoteShare',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          AppRoutes.SPLASH_PAGE: (_) => WelcomeScreen(),
          AppRoutes.HOME: (_) => NotationList(),
          AppRoutes.USER_FORM: (_) => UserForm()
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}