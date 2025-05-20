import 'package:flutter/material.dart';
import 'package:shoes_app/auth/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              MaterialPageRoute route = MaterialPageRoute(builder: (_)=> LoginPage());
              Navigator.push(context, route);
            },
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
