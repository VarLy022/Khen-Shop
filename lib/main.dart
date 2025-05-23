import 'package:flutter/material.dart';
import 'package:shoes_app/auth/login_page.dart';
import 'package:shoes_app/auth/register_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shoe Shop',
      // home: LoginPage(),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        // '/home': (context) => HomePage(),
        // '/manage': (context) => ManagePage(),
        // '/products': (context) => ProductsPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: const Color.fromARGB(241, 255, 250, 250),
        fontFamily: 'NotoSansLao',
        appBarTheme: AppBarTheme(backgroundColor: Colors.white54),
        // textTheme: const TextTheme(
        //   bodyLarge: TextStyle(color: Colors.white),
        //   bodyMedium: TextStyle(color: Colors.white),
        //   bodySmall: TextStyle(color: Colors.white),
        //   titleLarge: TextStyle(color: Colors.white),
        //   titleMedium: TextStyle(color: Colors.white),
        //   titleSmall: TextStyle(color: Colors.white),
        //   labelLarge: TextStyle(color: Colors.white),
        //   labelMedium: TextStyle(color: Colors.white),
        //   labelSmall: TextStyle(color: Colors.white),
        // ),
      ),
    );
  }
}
