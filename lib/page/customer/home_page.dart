import 'package:flutter/material.dart';
import 'package:shoes_app/auth/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Welcom to KHEN SHOES SHOP"),
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 20.0),
      //       child: IconButton(
      //         onPressed: () {
      //           Navigator.of(context).pop();
      //           MaterialPageRoute route =
      //               MaterialPageRoute(builder: (_) => LoginPage());
      //           Navigator.push(context, route);
      //         },
      //         icon: Icon(
      //           Icons.person,
      //           size: 35,
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      body: SafeArea(
        child: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            MaterialPageRoute route =
                MaterialPageRoute(builder: (_) => LoginPage());
            Navigator.push(context, route);
          },
          icon: Icon(
            Icons.person,
            size: 35,
          ),
        ),
      ),
    );
  }
}
