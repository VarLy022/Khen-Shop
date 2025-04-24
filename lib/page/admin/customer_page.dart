import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {

  // Base URL for your API
  final String _baseUrl = kIsWeb
      ? 'http://172.20.10.2:3000/shoes' // สำหรับ Web
      : Platform.isAndroid
          ? 'http://172.20.10.2:3000/shoes' // สำหรับ Android Emulator
          : 'http://172.20.10.2:3000/shoes'; // สำหรับ iOS หรือ desktop

  bool _isLoading = true;
  bool _isSearching = false;


  // show all user
  Future<void> _fethUsers() async{
    setState(() {
      _isLoading=true;
    });
    try {
      final response=await http.get(Uri.parse(_baseUrl));
      
    } catch (error) {
      
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ຂໍ້ມູນລູກຄ້າ'),
      ),
      
    );
  }
}
