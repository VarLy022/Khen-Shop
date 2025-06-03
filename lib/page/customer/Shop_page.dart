import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shoes_app/config/ip_config.dart';
import 'package:shoes_app/model/shoe_data_model.dart';
import 'package:shoes_app/page/admin/drawerMenu.dart';
import 'package:shoes_app/page/customer/product_component.dart';

class ShopPage extends StatefulWidget {
  final String userName;
  final String userImage;
  final String userEmail;
  final String userRole;
  final String userPassword;
  final String userPhone;
  const ShopPage({
    required this.userName,
    required this.userImage,
    required this.userEmail,
    required this.userRole,
    required this.userPassword,
    required this.userPhone,
    super.key,
  });

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  // Base URL for your API
  final String _baseUrl = ApiConfig.baseUrl;

  List<Shoe> _shoes = [];
  bool _isLoading = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchShoes();
  }

  // Function to fetch all shoes from the API
  bool _hasShownError = false; // เพิ่มตัวแปรนี้ไว้ด้านบนของ State
  Future<void> _fetchShoes() async {
    setState(() {
      _isLoading = true;
      _hasShownError = false; // reset ทุกครั้งเมื่อเริ่มโหลดใหม่
    });

    try {
      final response = await http.get(Uri.parse('$_baseUrl/shoes'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _shoes = data.map((json) => Shoe.fromJson(json)).toList();
          _isLoading = false; // ✅ ปิด loading ถ้าโหลดสำเร็จ
        });
      } else {
        // ✅ ถ้ายังไม่ได้โชว์ error ให้โชว์
        if (!_hasShownError) {
          _showErrorDialog('ກາລຸນາເຊື່ອມຕໍ່ອິນເຕີເນັດ');
          _hasShownError = true;
        }
        // ไม่ปิด loading → spinner ค้างไว้
      }
    } catch (error) {
      if (!_hasShownError) {
        _showErrorDialog('ກາລຸນາເຊື່ອມຕໍ່ອິນເຕີເນັດ');
        _hasShownError = true;
      }
      // ไม่ปิด loading → spinner ค้างไว้
    }
  }

  // Function to show an error dialog
  void _showErrorDialog(String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      title: 'ຂໍ້ຜິດພາດ',
      desc: message,
      btnOkOnPress: () {},
    ).show();
  }

  // search
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  Future<void> searchShoe(String keyword) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await http.get(Uri.parse('$_baseUrl/$keyword'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _shoes = data.map((json) => Shoe.fromJson(json)).toList();
        });
      } else {
        _showErrorDialog('Search failed: ${response.statusCode}');
      }
    } catch (error) {
      _showErrorDialog('Error: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'KHEN NIKE SHOP 👟',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 17,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.notifications,
                size: 27,
              ),
            ),
          ),
        ],
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

      // appBar: AppBar(
      //   title: isSearching
      //       ? TextField(
      //           controller: searchController,
      //           decoration: InputDecoration(
      //               contentPadding:
      //                   EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      //               hintText: 'ຄົ້ນຫາ...',
      //               border: OutlineInputBorder(
      //                 borderRadius: BorderRadius.circular(20),
      //               ),
      //               hintStyle: TextStyle(color: Colors.black),
      //               filled: true,
      //               fillColor: Colors.white60),
      //           style:
      //               TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      //           onChanged: (value) {
      //             // เรียกฟังก์ชันค้นหา
      //             if (searchController.text == "" ||
      //                 searchController.text.isEmpty) {
      //               _fetchShoes();
      //             } else {
      //               searchShoe(searchController.text);
      //             }
      //           },
      //         )
      //       : const Text(
      //           'KHEN NIKE SHOP 👟',
      //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      //         ),
      //   centerTitle: true,
      //   actions: [
      //     IconButton(
      //       icon: Icon(isSearching ? Icons.close : Icons.search),
      //       onPressed: () {
      //         setState(() {
      //           isSearching = !isSearching;
      //           if (!isSearching) {
      //             searchController.clear();
      //             _fetchShoes();
      //           }
      //         });
      //       },
      //     ),
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                    
                  ),
                  filled: true,
                  fillColor: Colors.white
                ),
              ),
              const SizedBox(height: 20),
              ProductComponent(),
            ],
          ),
        ),
      ),
    );
  }
}
