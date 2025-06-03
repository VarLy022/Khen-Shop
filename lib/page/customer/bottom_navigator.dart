import 'package:flutter/material.dart';
import 'package:shoes_app/page/customer/Shop_page.dart';
import 'package:shoes_app/page/customer/home_page.dart';
import 'package:shoes_app/page/customer/my_cart_page.dart';
import 'package:shoes_app/page/customer/profile_page.dart';

class BottomNavigator extends StatefulWidget {
  final String userName;
  final String userImage;
  final String userEmail;
  final String userRole;
  final String userPassword;
  final String userPhone;
  const BottomNavigator({
    required this.userName,
    required this.userImage,
    required this.userEmail,
    required this.userRole,
    required this.userPassword,
    required this.userPhone,
    super.key,
  });

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  late List<Widget> children;
  int currenWidget = 0;

  @override
  void initState() {
    super.initState();
    children = [
      HomePage(
        userName: widget.userName,
        userImage: widget.userImage,
        userEmail: widget.userEmail,
        userRole: widget.userRole,
        userPassword: widget.userPassword,
        userPhone: widget.userPhone,
      ),
      ShopPage(
        userName: widget.userName,
        userImage: widget.userImage,
        userEmail: widget.userEmail,
        userRole: widget.userRole,
        userPassword: widget.userPassword,
        userPhone: widget.userPhone,
      ),
      MyCartPage(),
      ProfilePage(
        userName: widget.userName,
        userImage: widget.userImage,
        userEmail: widget.userEmail,
        userRole: widget.userRole,
        userPassword: widget.userPassword,
        userPhone: widget.userPhone,
      ),
    ];
  }

  onTap(index) {
    setState(() {
      currenWidget = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: children[currenWidget],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
        currentIndex: currenWidget,
        onTap: onTap,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
              color: Colors.black87,
            ),
            label: "ໜ້າຫຼັກ",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_bag,
              size: 30,
              color: Colors.black87,
            ),
            label: "ຊື້ສິນຄ້າ",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
              size: 30,
              color: Colors.black87,
            ),
            label: "ກະຕ່າ",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 30,
              color: Colors.black87,
            ),
            label: "ໂປຣຟາຍ",
          ),
        ],
      ),
    );
  }
}
