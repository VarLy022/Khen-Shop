import 'package:flutter/material.dart';
import 'package:shoes_app/page/admin/category_page.dart';
import 'package:shoes_app/page/admin/user/customer_page.dart';
import 'package:shoes_app/page/admin/drawerMenu.dart';
import 'package:shoes_app/page/admin/exchange_page.dart';
import 'package:shoes_app/page/admin/products/products_page.dart';
import 'package:shoes_app/page/admin/staff_page.dart';
import 'package:shoes_app/page/admin/supplier_page.dart';

List<String> items = [
  // "ຂໍ້ມູນຫົວໜ່ວຍ",
  "ຂໍ້ມູນປະເພດສີນຄ້າ",
  "ຂໍ້ມູນສີນຄ້າ",
  "ອັດຕາແລກປ່ຽນ",
  "ພະນັກງານ",
  "ຜູ້ສະໜອງ",
  "ລູກຄ້າ", // Ensure to add an item for all 7 routes if you use 7 routes.
];

List<Icon> icons = [
  // Icon(Icons.ac_unit, size: 70, color: Colors.amber),
  Icon(Icons.category, size: 70, color: Colors.amber),
  Icon(Icons.folder_open, size: 70, color: Colors.amber),
  Icon(Icons.currency_exchange_sharp, size: 70, color: Colors.amber),
  Icon(Icons.person, size: 70, color: Colors.amber),
  Icon(Icons.bus_alert, size: 70, color: Colors.amber),
  Icon(Icons.people, size: 70, color: Colors.amber),
];

List<Widget> routePage = [
  // UnitPage(),
  CategoryPage(),
  ProductsPage(),
  ExchangePage(),
  StaffPage(),
  SupplierPage(),
  CustomerPage(),
];

class ManagePage extends StatefulWidget {
  const ManagePage({super.key});

  @override
  State<ManagePage> createState() => _ManagePageState();
}

class _ManagePageState extends State<ManagePage> {
  void selectPage(int idx) {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => routePage[idx],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawermenu(),
      appBar: AppBar(
        title: Text("ຈັດການຂໍ້ມູນ"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.teal],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        // margin: EdgeInsets.all(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView.builder(
            itemCount: items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
            itemBuilder: (c, indx) {
              return InkWell(
                onTap: () {
                  selectPage(indx);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  width: 180,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.blueGrey,
                    border: Border.all(color: Colors.green, width: 2),
                  ),
                  child: Column(
                    children: [
                      icons[indx], // Dynamic icon assignment
                      Spacer(),
                      Text(
                        items[indx], // Dynamic text from items
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          // fontFamily: 'NotosansLao',
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
