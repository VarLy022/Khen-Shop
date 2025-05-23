import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shoes_app/page/customer/bottom_navigator.dart';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>(); // ກວດສອບການປ້ອນຂໍ້ມູນບໍຄົບ
  bool _obscureText = true;
  String? _loginError; // To display login error messages

  // connect to server
  final String _baseApi = kIsWeb
      ? 'http://172.20.10.2:3000' // สำหรับ Web
      : Platform.isAndroid
          ? 'http://172.20.10.2:3000' // สำหรับ Android Emulator
          : 'http://172.20.10.2:3000';

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // login
  Future<void> loginUser() async {
    setState(() {
      _loginError = null; // Clear previous error message
    });

    if (_formkey.currentState!.validate()) {
      // final url = Uri.parse('http://10.0.2.2:3000/users/login');
      try {
        final Uri url = Uri.parse('$_baseApi/users/login');
        final response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            'email': emailController.text,
            'password': passwordController.text,
          }),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final role = data['user']['role'];
          final name = data['user']['name'];
          final image = data['user']['image'];
          final email = data['user']['email'];
          // success
          if (role == 'admin' || role == 'customer') {
            //   Navigator.of(context).pop();
            //   MaterialPageRoute route = MaterialPageRoute(
            //       builder: (_) => AdminHomePage(
            //             userName: name,
            //             userImage: image,
            //             userEmail: email,
            //           ));
            //   Navigator.push(context, route);
            // } else if (role == 'customer') {
            //   Navigator.of(context).pop();
            //   MaterialPageRoute route = MaterialPageRoute(
            //       builder: (_) => BottomNavigator(
            //             userName: name,
            //             userImage: image,
            //             userEmail: email,
            //           ));
            //   Navigator.push(context, route);

            Navigator.of(context).pop();
            MaterialPageRoute route = MaterialPageRoute(
                builder: (_) => BottomNavigator(
                      userRole: role,
                      userName: name,
                      userImage: image,
                      userEmail: email,
                    ));
            Navigator.push(context, route);
          } else {
            setState(() {
              _loginError = 'ອີເມວ ຫຼື ລະຫັດຜ່ານບໍ່ຖືກຕ້ອງ';
            });
          }
        } else if (response.statusCode == 401) {
          // Unauthorized - likely incorrect email or password
          setState(() {
            _loginError = 'ລະຫັດຜ່ານບໍ່ຖືກຕ້ອງ';
          });
        } else if (response.statusCode == 404) {
          // Not Found - likely email not in database
          setState(() {
            _loginError = 'ບໍ່ພົບບັນຊີໃນລະບົບ';
          });
        } else {
          // Other errors
          setState(() {
            _loginError = 'ເກີດຂໍ້ຜິດພາດໃນການເຂົ້າສູ່ລະບົບ';
          });
          print(
              'Login failed with status: ${response.statusCode}, body: ${response.body}');
        }
      } catch (error) {
        setState(() {
          _loginError = 'ກາລຸນາເຊື່ອມຕໍ່ກັບອິນເຕີເນັດ';
        });
        print('Login error: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formkey, // ກວດສອບຂໍ້ມູນບໍຄົບ
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.4,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: CircleAvatar(
                        child: ClipOval(
                          child: Image.asset('assets/images/logo_shoe.jpg'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'KHEN SHOES',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.amber,
                      ),
                    ),
                    const SizedBox(height: 40),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "ອີເມວ",
                        labelStyle: TextStyle(
                          fontFamily: 'NotoSansLao',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.blueGrey,
                        prefixIcon: Icon(
                          Icons.email,
                          size: 30,
                          color: Colors.amberAccent,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "ກາລຸນາປ້ອນອີເມວ";
                        } else if (!EmailValidator.validate(value)) {
                          return 'ຮູບແບບອີເມວບໍ່ຖືກຕ້ອງ';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      obscureText: _obscureText,
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: "ລະຫັດຜ່ານ",
                        labelStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        prefixIcon: Icon(
                          Icons.lock,
                          size: 30,
                          color: Colors.amberAccent,
                        ),
                        suffixIcon: IconButton(
                          onPressed: _toggleVisibility,
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.blueGrey,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "ກາລຸນາປ້ອນລະຫັດຜ່ານ";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    if (_loginError != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          _loginError!,
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.72,
                      height: MediaQuery.of(context).size.width * 0.12,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue,
                        ),
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            loginUser();
                          }
                        },
                        child: const Text(
                          "ເຂົ້າສູ່ລະບົບ",
                          style: TextStyle(
                              fontFamily: 'NotoSansLao',
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'ຫຼື ເຂົ້າລະບົບກັບ',
                              style: TextStyle(
                                fontFamily: 'NotoSansLao',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: CircleAvatar(
                            child: Image.asset('assets/images/google.png'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () {},
                          child: CircleAvatar(
                            child: Image.asset('assets/images/facebook.png'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () {},
                          child: CircleAvatar(
                            child: Image.asset('assets/images/apple.png'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text(
                        "ບໍ່ມີບັນຊີ? ລົງທະບຽນ",
                        style: TextStyle(
                          fontFamily: 'NotoSansLao',
                          fontSize: 18,
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
