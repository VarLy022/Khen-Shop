import 'package:flutter/material.dart';
import 'package:shoes_app/page/customer/Shop_page.dart';
import 'package:shoes_app/page/customer/home_page.dart';
import 'package:shoes_app/page/customer/my_cart_page.dart';
import 'package:shoes_app/page/customer/profile_page.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {

  List children = [
    HomePage(),
    ShopPage(),
    MyCartPage(),
    ProfilePage(),
  ];
  int currenWidget = 0;
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
        backgroundColor: Colors.teal,
        type: BottomNavigationBarType.fixed,
        currentIndex: currenWidget,
        onTap: onTap,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: "Shopping",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "My Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}