import 'package:flutter/material.dart';
import 'package:shoes_app/page/admin/admin_home_page.dart';
import 'package:shoes_app/page/admin/manage_page.dart';
import 'package:shoes_app/page/customer/home_page.dart';
import 'package:shoes_app/auth/login_page.dart';

class Drawermenu extends StatefulWidget {
  const Drawermenu({super.key});

  @override
  State<Drawermenu> createState() => _DrawermenuState();
}

class _DrawermenuState extends State<Drawermenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.deepPurpleAccent,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                // color: const Color.fromARGB(255, 59, 131, 89),
                // image: DecorationImage(
                //     image: AssetImage('assets/images/background.jpg'),
                //     fit: BoxFit.cover),

                gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topCenter,
            )),
            accountName: const Text(
              'KHEN SHOP',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.black,
                // fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: const Text(
              'varlee@gmail.com',
              style: TextStyle(
                  fontFamily: 'NotoSansLao',
                  // color: Colors.green.shade900,
                  fontSize: 19,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            currentAccountPicture: Container(
              height: 200,
              width: 200,
              margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
              child: CircleAvatar(
                child: ClipOval(
                  child: Image.asset('assets/images/logo_shoe.jpg'),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              
              children: [
                Card(
                  elevation: 5,
                  child: ListTile(
                    leading: Icon(
                      Icons.home,
                      color: Colors.teal,
                      size: 25,
                    ),
                    title: Text(
                      'ໜ້າຫຼັກ',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontFamily: 'NotoSansLao'),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminHomePage(),
                        ),
                      );
                    },
                  ),
                ),
                Divider(),
                Card(
                  elevation: 5,
                  child: ListTile(
                    leading: Icon(
                      Icons.folder,
                      color: Colors.teal,
                      size: 25,
                    ),
                    title: Text(
                      'ຈັດການຂໍ້ມູນ',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontFamily: 'NotoSansLao'),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ManagePage(),
                        ),
                      );
                    },
                  ),
                ),
                Divider(),
                Card(
                  elevation: 5,
                  child: ListTile(
                    leading: Icon(
                      Icons.shopping_bag,
                      color: Colors.teal,
                      size: 25,
                    ),
                    title: Text(
                      'ຂາຍສິນຄ້າ',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontFamily: 'NotoSansLao'),
                    ),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => SalePage(),
                      //   ),
                      // );
                    },
                  ),
                ),
                Divider(),
                Card(
                  elevation: 5,
                  child: ListTile(
                    leading: Icon(
                      Icons.arrow_forward,
                      color: Colors.teal,
                      size: 25,
                    ),
                    title: Text(
                      'ສັ່ງຊື້ສິນຄ້າ',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontFamily: 'NotoSansLao'),
                    ),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => OrderPage(),
                      //   ),
                      // );
                    },
                  ),
                ),
                Divider(),
                Card(
                  elevation: 5,
                  child: ListTile(
                    leading: Icon(
                      Icons.download,
                      color: Colors.teal,
                      size: 25,
                    ),
                    title: Text(
                      'ນຳເຂົ້າສິນຄ້າ',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontFamily: 'NotoSansLao'),
                    ),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => ImportPage(),
                      //   ),
                      // );
                    },
                  ),
                ),
                Divider(),
                Card(
                  elevation: 5,
                  child: ListTile(
                    leading: Icon(
                      Icons.search,
                      color: Colors.teal,
                      size: 25,
                    ),
                    title: Text(
                      'ຄົ້ນຫາ',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontFamily: 'NotoSansLao'),
                    ),
                    onTap: () {},
                  ),
                ),
                Divider(),
                Card(
                  elevation: 5,
                  child: ListTile(
                    leading: Icon(
                      Icons.bar_chart,
                      color: Colors.teal,
                      size: 25,
                    ),
                    title: Text(
                      'ລາຍງານ',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontFamily: 'NotoSansLao'),
                    ),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => ReportPage(),
                      //   ),
                      // );
                    },
                  ),
                ),
                Divider(),
                Card(
                  elevation: 5,
                  child: ListTile(
                    leading: Icon(
                      Icons.people,
                      color: Colors.teal,
                      size: 25,
                    ),
                    title: Text(
                      'User interface',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontFamily: 'NotoSansLao'),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                  ),
                ),
                Divider(),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Card(
                    elevation: 5,
                    color: Colors.grey[800],
                    child: ListTile(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      leading: Icon(
                        Icons.logout,
                        color: Colors.red,
                        size: 30,
                      ),
                      title: Text(
                        "Logout",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: 'NotoSansLao'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
