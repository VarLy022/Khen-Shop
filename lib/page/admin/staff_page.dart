import 'package:flutter/material.dart';

class StaffPage extends StatefulWidget {
  const StaffPage({super.key});

  @override
  State<StaffPage> createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('KHEN SHOP'),
      // ),
      body: Center(
        child: Text('Hello'),
      ),
    );
  }
}