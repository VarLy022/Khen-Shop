// lib/config/api_config.dart
import 'dart:io';
import 'package:flutter/foundation.dart';

class ApiConfig {
  static String get baseUrl {
    if (kIsWeb) {
      return 'http://172.20.10.2:3000'; // สำหรับ Web
    } else if (Platform.isAndroid) {
      return 'http://172.20.10.2:3000'; // สำหรับ Android Emulator
    } else {
      return 'http://172.20.10.2:3000'; // สำหรับ iOS หรือ Desktop
    }
  }
}
