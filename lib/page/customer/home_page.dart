import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shoes_app/page/admin/drawerMenu.dart';
import 'package:shoes_app/page/customer/shoe_component.dart';

class HomePage extends StatefulWidget {
  final String userName;
  final String userImage;
  final String userEmail;
  final String userRole;

  const HomePage({
    required this.userName,
    required this.userImage,
    required this.userEmail,
    required this.userRole,
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> banner = [
    "assets/images/banner1.jpg",
    "assets/images/banner2.jpg",
    "assets/images/banner3.jpg",
    "assets/images/banner4.jpg",
  ];
  int currenIndex = 0;
  onTap(_index) {
    setState(() {
      currenIndex = _index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 218, 212, 187),
      appBar: AppBar(
        // backgroundColor: Colors.white54,
        title: Center(
          child: Text(
            'KHEN SHOP🛍🛒',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
                size: 30,
              ))
        ],
        automaticallyImplyLeading: widget.userRole != 'admin' ? false : true,
      ),
      drawer: widget.userRole == 'admin'
          ? Drawermenu(
              userName: widget.userName,
              userImage: widget.userImage,
              userEmail: widget.userEmail,
              userRole: widget.userRole,
            )
          : null, // ถ้าไม่ใช่ admin ไม่แสดง Drawer

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    // Avatar
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          widget.userImage), // ✅ เปลี่ยนเป็น URL ของผู้ใช้จริง
                    ),
                    SizedBox(width: 12), // ระยะห่างระหว่างรูปกับชื่อ
                    // ชื่อผู้ใช้
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi👋🏿,",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${widget.userName}",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
          
              CarouselSlider(
                options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  viewportFraction: 1,
                  // enlargeCenterPage: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 100),
                ),
                items: banner.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(color: Colors.amber),
                        child: Image.asset(i, fit: BoxFit.cover),
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(
                height: 50,
                // child: ListView.builder(
                //   shrinkWrap: true,
                //   primary: false,
                //   scrollDirection: Axis.horizontal,
                //   itemCount: category.length,
                //   itemBuilder: (context, index) {
                //     return GestureDetector(
                //       onTap: () {
                //         onTap(index);
                //       },
                //     );
                //   },
                // ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 5,
                ),
                child: Row(
                  children: [
                    Text(
                      "ສິນຄ້າທີ່ດີທີ່ສຸດ",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.category),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text("ທັງໝົດ"),
                    ),
                  ],
                ),
              ),
              ShoeComponent(),
            ],
          ),
        ),
      ),
    );
  }
}
