import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shoes_app/config/ip_config.dart';
import 'package:shoes_app/detail/shoe_details.dart';
import 'package:shoes_app/model/shoe_data_model.dart';

class ProductComponent extends StatefulWidget {
  const ProductComponent({super.key});

  @override
  State<ProductComponent> createState() => _ProductComponentState();
}

class _ProductComponentState extends State<ProductComponent> {
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

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : GridView.builder(
            controller: _scrollController,
            shrinkWrap: true,
            primary: false,
            itemCount: _shoes.length,
            // physics: NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6,
            ),
            itemBuilder: (context, index) {
              final shoe = _shoes[index];
              return Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShoeDetails(
                                  shoe: shoe), // เปลี่ยนเป็นหน้าที่คุณต้องการ
                            ),
                          );
                          // _showShoeDetails(shoe);
                        },
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: Image.network(
                            shoe.imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/icons/shoes.png',
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${shoe.brand} ${shoe.name}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        shoe.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        // style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Text(
                        "${NumberFormat("#,##0").format(shoe.price)} LAK",
                        style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 110,
                      ),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        child: Text(
                          'ຊື້ເລີຍ',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                  ],
                ),
              );
            },
          );
  }
}
