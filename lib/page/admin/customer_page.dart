import 'package:flutter/material.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KHEN SHOP'),
      ),
      body: Padding(
  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  child: TextField(
    decoration: InputDecoration(
      labelText: 'ຄົ້ນຫາ', // ชื่อของ TextField
      hintText: 'ຄົ້ນຫາ...', // ข้อความตัวอย่างที่แสดงใน TextField
      contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 12), // Padding ของ TextField
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18), // ขอบมน
      ),
      prefixIcon: IconButton(
        onPressed: () {},
        icon: Icon(Icons.search),
      ),
      filled: true, // เปิดการเติมสีพื้นหลัง
      fillColor: Colors.white, // สีพื้นหลังของ TextField
    ),
    style: TextStyle(fontSize: 16), // ขนาดฟอนต์ที่สามารถปรับได้
  ),
),

    );
  }
}