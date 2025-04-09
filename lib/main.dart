import 'package:flutter/material.dart';
import 'package:shoes_app/page/admin/manage_page.dart';
import 'package:shoes_app/page/admin/products_page.dart';
import 'package:shoes_app/page/costomer/home_page.dart';
import 'package:shoes_app/page/login_page.dart';
import 'package:shoes_app/page/register_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shoe Shop',
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage(),
        '/manage': (context) => ManagePage(),
        '/products': (context) => ProductsPage(),
      },
      // theme: ThemeData(
      //   textTheme: ,
      // ),
    );
  }
}
