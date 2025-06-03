import 'package:flutter/material.dart';
import 'package:shoes_app/auth/login_page.dart';
import 'package:shoes_app/page/admin/drawerMenu.dart';

class ProfilePage extends StatefulWidget {
  final String userName;
  final String userImage;
  final String userEmail;
  final String userRole;
  final String userPassword;
  final String userPhone;
  const ProfilePage({
    required this.userName,
    required this.userImage,
    required this.userEmail,
    required this.userRole,
    required this.userPassword,
    required this.userPhone,
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Profile',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        automaticallyImplyLeading: widget.userRole != 'admin' ? false : true,
      ),
      drawer: widget.userRole == 'admin'
          ? Drawermenu(
              userName: widget.userName,
              userImage: widget.userImage,
              userEmail: widget.userEmail,
              userRole: widget.userRole,
              userPassword: widget.userPassword,
              userPhone: widget.userPhone,
            )
          : null, // ถ้าไม่ใช่ admin ไม่แสดง Drawer

      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundColor: Colors.white,
                backgroundImage:
                    (widget.userImage.isNotEmpty && widget.userImage.isNotEmpty)
                        ? NetworkImage(widget.userImage)
                        : null,
                child: (widget.userImage.isEmpty)
                    ? Icon(Icons.person, size: 95)
                    : null,
              ),
              const SizedBox(height: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ຊື່: ${widget.userName}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'ອີເມວ: ${widget.userEmail}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'ເບີໂທລະສັບ: ${widget.userPhone}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  // Text(
                  //   'ຊື່: ${widget.userName}',
                  //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  // ),
                  // const SizedBox(height: 8),
                ],
              ),
              const SizedBox(height: 300),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      MaterialPageRoute route =
                          MaterialPageRoute(builder: (_) => const LoginPage());
                      Navigator.push(context, route);
                    },
                    child: const Text(
                      'ອອກຈາກລະບົບ',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
