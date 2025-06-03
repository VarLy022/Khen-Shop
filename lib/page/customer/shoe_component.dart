import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shoes_app/config/ip_config.dart';
import 'package:shoes_app/detail/shoe_details.dart';
import 'package:shoes_app/model/shoe_data_model.dart';

class ShoeComponent extends StatefulWidget {
  const ShoeComponent({super.key});

  @override
  State<ShoeComponent> createState() => _ShoeComponentState();
}

class _ShoeComponentState extends State<ShoeComponent> {
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
      _hasShownError = false;
    });

    try {
      final response = await http.get(Uri.parse('$_baseUrl/shoes'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        List<Shoe> allShoes = data.map((json) => Shoe.fromJson(json)).toList();

        // 🔽 เรียงจากราคาสูง -> ต่ำ แล้วเลือกแค่ 4 อันดับแรก
        allShoes.sort((a, b) => b.price.compareTo(a.price));
        List<Shoe> topShoes = allShoes.take(4).toList();

        setState(() {
          _shoes = topShoes;
          _isLoading = false;
        });
      } else {
        if (!_hasShownError) {
          _showErrorDialog('ກາລຸນາເຊື່ອມຕໍ່ອິນເຕີເນັດ');
          _hasShownError = true;
        }
      }
    } catch (error) {
      if (!_hasShownError) {
        _showErrorDialog('ກາລຸນາເຊື່ອມຕໍ່ອິນເຕີເນັດ');
        _hasShownError = true;
      }
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
                      padding: const EdgeInsets.only(left: 110,),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green
                        ),
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
