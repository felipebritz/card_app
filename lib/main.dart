import 'package:card_app/pages/card_page.dart';
import 'package:card_app/pages/list_page.dart';
import 'package:card_app/pages/login_page.dart';
import 'package:card_app/pages/sign_up_page.dart';
import 'package:card_app/theme/growdev_colors.dart';
import 'package:card_app/utils/app_routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cards',
      theme: ThemeData(
        primarySwatch: azulGrowdev,
      ),
      initialRoute: AppRoutes.loginPage,
      routes: {
        AppRoutes.loginPage: (_) => LoginPage(),
        AppRoutes.signUpPage: (_) => SingUpPage(),
        AppRoutes.listPage: (_) => ListPage(),
        AppRoutes.cardPage: (_) => CardPage()
      },
    );
  }
}
