import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _isRegistering = false; // Track registration state
  String? _errorMessage;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  Future<void> registerUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isRegistering = true;
        _errorMessage = null;
      });
      final url = Uri.parse('http://172.20.10.2:3000/users/register');
      try {
        final response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            'name': nameController.text,
            'email': emailController.text,
            'password': passwordController.text,
            'phone': phoneController.text,
          }),
        );

        if (response.statusCode == 200) {
          // Registration successful
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.leftSlide,
            title: 'ສຳເລັດ',
            desc: 'ທ່ານໄດ້ລົງທະບຽນສຳເລັດແລ້ວ!',
            btnOkOnPress: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ).show();
        } else {
          // Registration failed
          final responseData = jsonDecode(response.body);
           setState(() {
            _errorMessage = responseData['message'] ?? "ເກີດຂໍ້ຜິດພາດໃນການລົງທະບຽນ";
          });
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.leftSlide,
            title: 'ຂໍ້ຜິດພາດ',
            desc: _errorMessage,
            btnOkOnPress: () {},
          ).show();
          print('Registration failed: ${response.statusCode}, ${response.body}');
        }
      } catch (error) {
         setState(() {
          _errorMessage = "ກາລຸນາເຊື່ອມຕໍ່ກັບອິນເຕີເນັດ";
        });
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.leftSlide,
          title: 'Error',
          desc: 'ກາລຸນາເຊື່ອມຕໍ່ກັບອິນເຕີເນັດ',
          btnOkOnPress: () {},
        ).show();
        print('Error registering user: $error');
      } finally {
        setState(() {
          _isRegistering = false;
        });
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
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'ສ້າງບັນຊີໃໝ່',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 34,
                        color: Colors.amber,
                      ),
                    ),
                    const SizedBox(height: 40),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: "ຊື່",
                        labelStyle: TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.blueGrey,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ກາລຸນາປ້ອນຊື່';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "ອີເມວ",
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                            fontSize: 18),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.blueGrey,
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
                        labelStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.amber),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.blueGrey,
                        suffixIcon: IconButton(
                          onPressed: () {
                            _toggleVisibility();
                          },
                          icon: Icon(_obscureText
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ກາລຸນາປ້ອນລະຫັດຜ່ານ';
                        } else if (value.length < 6 || value.length > 20) {
                          return 'ລະຫັດຜ່ານຄວນມີຄວາມຍາວ 6-20 ຕົວອັກສອນ';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: phoneController,
                      decoration: InputDecoration(
                        labelText: "ເບີໂທລະສັບ",
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.amber),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.blueGrey,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ກາລຸນາປ້ອນເບີໂທ';
                        } else if (value.length < 8) {
                          return 'ເບີໂທລະສັບສັ້ນເກີນໄປ';
                        } else if (!['2', '5', '7', '9'].contains(value[0])) {
                          return 'ຮູບແບບເບີໂທບໍ່ຖືກຕ້ອງ';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.12,
                      width: MediaQuery.of(context).size.width * 0.72,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue,
                        ),
                        onPressed: _isRegistering
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  registerUser();
                                }
                              },
                        child: _isRegistering
                            ? const CircularProgressIndicator()
                            : const Text(
                                "ລົງທະບຽນ",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        MaterialPageRoute route =
                            MaterialPageRoute(builder: (_) => LoginPage());
                        Navigator.push(context, route);
                      },
                      child: const Text(
                        "ມີບັນຊີແລ້ວ? ເຂົ້າສູ່ລະບົບ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.amber,
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
