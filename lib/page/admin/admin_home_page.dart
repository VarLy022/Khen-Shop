import 'package:flutter/material.dart';
import 'package:shoes_app/page/admin/drawerMenu.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
        
      ),
      drawer: Drawermenu(),
    );
  }
}