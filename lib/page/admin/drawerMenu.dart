import 'package:flutter/material.dart';
import 'package:shoes_app/page/admin/manage_page.dart';
import 'package:shoes_app/page/customer/bottom_navigator.dart';
import 'package:shoes_app/auth/login_page.dart';

class Drawermenu extends StatefulWidget {
  final String userName;
  final String userImage;
  final String userEmail;
  final String userRole;
  const Drawermenu(
      {required this.userName,
      required this.userImage,
      required this.userEmail,
      required this.userRole,
      Key? key})
      : super(key: key);

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
            accountName: Text(
              '${widget.userName}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.black,
                // fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              '${widget.userEmail}',
              style: TextStyle(
                  fontFamily: 'NotoSansLao',
                  // color: Colors.green.shade900,
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            currentAccountPicture: Container(
              height: 200,
              width: 200,
              margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(widget.userImage),
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
                          builder: (context) => BottomNavigator(
                            userName: widget.userName,
                            userImage: widget.userImage,
                            userEmail: widget.userEmail,
                            userRole: widget.userRole,
                          ),
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
                          builder: (context) => ManagePage(
                            userName: widget.userName,
                            userImage: widget.userImage,
                            userEmail: widget.userEmail,
                            userRole: widget.userRole,
                          ),
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
