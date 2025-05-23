import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'user_data_model.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  final _formKey = GlobalKey<FormState>();
  // Base URL for your API
  final String _baseUrl = kIsWeb
      ? 'http://172.20.10.2:3000' // สำหรับ Web
      : Platform.isAndroid
          ? 'http://172.20.10.2:3000' // สำหรับ Android Emulator
          : 'http://172.20.10.2:3000'; // สำหรับ iOS หรือ desktop

  List<User> _user = [];
  bool isLoading = true;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.get(Uri.parse('$_baseUrl/users'));
      // if (response.statusCode == 200) {
      //   setState(() {
      //     _user = json.decode(response.body);
      //     isLoading = false;
      //   });
      // } else {
      //   print('ໂຫຼດຂໍ້ມູນບໍ່ສຳເລັດ');
      // }
      if (response.statusCode == 200) {
        // Parse the JSON response and convert it to a list of Shoe objects
        final List<dynamic> data = json.decode(response.body);
        _user = data.map((json) => User.fromJson(json)).toList();
      } else {
        // Handle errors, such as server errors or invalid responses
        showErrorDialog('Failed to load user: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network errors, such as connection refused or timeout
      showErrorDialog('ຂໍ້ຜິດພາດ: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // controller
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController userImageController = TextEditingController();

  // function to add and edit user
  void _showAddEditUserDialog({User? user}) {
    if (user != null) {
      nameController.text = user.name;
      emailController.text = user.email;
      pwdController.text = user.password;
      phoneController.text = user.phone;
      // roleController.text = user.role;
      // user_imageController.text = user.user_image;
      // ถ้า user.role เป็น null ให้ใช้ค่าว่าง
      roleController.text = user.role ?? ''; // ใช้ '' หาก null

      // ถ้า user.user_image เป็น null ให้ใช้ค่าว่าง
      userImageController.text = user.user_image ?? ''; // ใช้ '' หาก null
    } else {
      clearInputField();
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: Text(
                    user == null ? 'ເພີ່ມຜູ້ໃຊ້ໃໝ່' : 'ແກ້ໄຂຂໍ້ມູນຜູ້ໃຊ້',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'ຊື່'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ກາລຸນາປ້ອນຊື່';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'ອີເມວ'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ກາລຸນາປ້ອນອີເມວ';
                    } else if (!EmailValidator.validate(value)) {
                      return 'ຮູບແບບອີເມວບໍ່ຖືກຕ້ອງ';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: pwdController,
                  decoration: const InputDecoration(labelText: 'ລະຫັດຜ່ານ'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ກາລຸນາປ້ອນລະຫັດຜ່ານ';
                    } else if (value.length < 6 || value.length > 20) {
                      return 'ລະຫັດຜ່ານຄວນມີຄວາມຍາວ 6-20 ຕົວອັກສອນ';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: 'ເບີໂທລະສັບ'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ກາລຸນາປ້ອນເບີໂທ';
                    } else if (value.length < 8) {
                      return 'ເບີໂທລະສັບສັ້ນເກີນໄປ';
                    } else if (value.length > 11) {
                      return 'ເບີໂທລະສັບຍາວເກີນໄປ';
                    } else if (!['0', '2', '5', '7', '9'].contains(value[0])) {
                      return 'ຮູບແບບເບີໂທບໍ່ຖືກຕ້ອງ';
                    }
                    return null;
                  },
                ),
                TextField(
                  controller: roleController,
                  decoration: const InputDecoration(
                      labelText: 'ບົດບາດ', hintText: 'admin or customer'),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: userImageController,
                        decoration:
                            const InputDecoration(labelText: 'URL ຮູບພາບ'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Wrap(
                                children: [
                                  ListTile(
                                    leading: Icon(Icons.camera_alt),
                                    title: Text('ຖ່າຍຮູບ (Camera)'),
                                    onTap: () async {
                                      Navigator.pop(
                                          context); // ปิด bottom sheet
                                      final XFile? photo =
                                          await _picker.pickImage(
                                              source: ImageSource.camera);
                                      if (photo != null) {
                                        setState(() {
                                          userImageController.text = photo.path;
                                        });
                                      }
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.photo_library),
                                    title: Text('ເລືອກຮູບ (Gallery)'),
                                    onTap: () async {
                                      Navigator.pop(
                                          context); // ปิด bottom sheet
                                      final XFile? image =
                                          await _picker.pickImage(
                                              source: ImageSource.gallery);
                                      if (image != null) {
                                        setState(() {
                                          userImageController.text = image.path;
                                        });
                                      }
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () {
                        Navigator.of(context).pop();
                        clearInputField();
                      },
                      child: Text(
                        'ຍົກເລີກ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 16),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (user == null) {
                            addUser();
                          } else {
                            editUser(user);
                          }
                        }
                      },
                      child: Text(
                        user == null ? 'ເພີ່ມ' : 'ບັນທືກ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // clear input field
  void clearInputField() {
    nameController.clear();
    emailController.clear();
    pwdController.clear();
    phoneController.clear();
    roleController.clear();
    userImageController.clear();
  }

  // show success diaglog
  Future<void> showSuccessDialog(String message) async {
    final completer = Completer<void>();

    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.scale,
      title: 'ສຳເລັດ',
      desc: message,
      btnOkOnPress: () {
        completer.complete(); // เมื่อกด OK ให้ complete
      },
    ).show();

    return completer.future; // รอจนกว่าจะ complete
  }

  //show error dialog
  void showErrorDialog(String message) {
    AwesomeDialog(
            dialogBackgroundColor: Colors.red,
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.scale,
            title: 'ຂໍ້ຜິດພາດ',
            desc: message,
            btnOkOnPress: () {})
        .show();
  }

  // add user
  Future<void> addUser() async {
    if (nameController.text.isEmpty ||
            emailController.text.isEmpty ||
            pwdController.text.isEmpty ||
            phoneController.text.isEmpty
        // roleController.text.isEmpty ||
        // user_imageController.text.isEmpty
        ) {
      showErrorDialog('ກະລຸນາປ້ອນຂໍ້ມູນໃຫ້ຄົບຖ້ວນ.');
      return;
    }

    try {
      final user = User(
        name: nameController.text,
        email: emailController.text,
        password: pwdController.text,
        phone: phoneController.text,
        role: roleController.text.isEmpty ? null : roleController.text,
        user_image:
            userImageController.text.isEmpty ? null : userImageController.text,
      );

      final response = await http.post(
        Uri.parse('$_baseUrl/users/register'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(user.toJson()),
      );
      // พิมพ์สถานะและเนื้อหาตอบกลับ เพื่อดูว่า server ตอบอะไร
      print('RESPONSE STATUS: ${response.statusCode}');
      print('RESPONSE BODY: ${response.body}');

      if (response.statusCode == 200) {
        await fetchUsers(); // รอโหลดข้อมูลใหม่
        clearInputField();

        // await showSuccessDialog('ເພີ່ມຜູ້ໃຊ້ສຳເລັດ.'); // รอ user กด OK ก่อน
        Navigator.of(context).pop(); // ค่อย pop ออก
      } else {
        showErrorDialog(
          // 'ເກີດຂໍ້ຜິດພາດໃນການເພີ່ມຜູ້ໃຊ້: ${response.statusCode}',
          'ເກີດຂໍ້ຜິດພາດໃນການເພີ່ມຜູ້ໃຊ້: ${response.statusCode}\n${response.body}',
        );
      }
    } catch (error) {
      showErrorDialog('ຂໍ້ຜິດພາດ: $error');
    }
  }

  // edit
  Future<void> editUser(User user) async {
    try {
      final updatedUser = User(
        userId: user.userId,
        name: nameController.text,
        email: emailController.text,
        password: pwdController.text,
        phone: phoneController.text,
        role: roleController.text,
        user_image:
            userImageController.text.isEmpty ? null : userImageController.text,
      );

      final response = await http.put(
        Uri.parse('$_baseUrl/users/${user.userId}'), // เพิ่ม /users/ ด้วย
        headers: {"Content-Type": "application/json"},
        body: json.encode(updatedUser.toJson()),
      );

      // print('RESPONSE STATUS: ${response.statusCode}');
      // print('RESPONSE BODY: ${response.body}');
      // print('UPDATE ID: ${user.userId}');
      // print('UPDATE DATA: ${updatedUser.toJson()}');
      // print('UPDATE DATA: ${updatedUser.toJson()}');

      if (response.statusCode == 200) {
        await fetchUsers();
        clearInputField();
        Navigator.of(context).pop();
      } else {
        showErrorDialog(
            'ເກີດຂໍ້ຜິດພາດໃນການແກ້ໄຂຜູ້ໃຊ້: ${response.statusCode}\n${response.body}');
      }
    } catch (error) {
      showErrorDialog('ຂໍ້ຜິດພາດ: $error');
    }
  }

  // delete
  Future<void> deleteUser(int userId) async {
    try {
      final response = await http.delete(Uri.parse('$_baseUrl/users/$userId'));
      if (response.statusCode == 200) {
        // Shoe deleted successfully, refresh the list
        fetchUsers();
      } else {
        showErrorDialog('Failed to delete shoe: ${response.statusCode}');
      }
    } catch (error) {
      showErrorDialog('ກາລຸນາເຊື່ອມຕໍ່ກັບອິນເຕີເນັດ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('ຂໍ້ມູນຜູ້ໃຊ້')),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.teal],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.7,
                ),
                padding: EdgeInsets.all(8),
                itemCount: _user.length,
                itemBuilder: (context, index) {
                  final user = _user[index];
                  return Card(
                    shadowColor: Colors.amber,
                    elevation: 10,
                    color: const Color.fromARGB(255, 168, 197, 194),
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              child: Center(
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage: user
                                              .user_image?.isNotEmpty ==
                                          true
                                      ? NetworkImage(user.user_image!)
                                      : null, // ถ้า user.user_image ไม่เป็น null และไม่ว่าง ให้ใช้ NetworkImage
                                  child: (user.user_image == null ||
                                          user.user_image!.isEmpty)
                                      ? Icon(
                                          Icons.person,
                                          size: 70,
                                        ) // ถ้า user.user_image เป็น null หรือว่าง ให้แสดงไอคอนแทน
                                      : null,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.person),
                                    SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        user.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.email),
                                    SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        user.email,
                                        style: TextStyle(fontSize: 14),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.lock),
                                    SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        user.password,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.call),
                                    SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        user.phone,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.key),
                                    SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        user.role ??
                                            '', // ใช้ค่าสตริงว่างถ้า user.role เป็น null
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  // print('user: $user');
                                  _showAddEditUserDialog(user: user);
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                              ),
                              // SizedBox(width: 8),
                              IconButton(
                                onPressed: () {
                                  showDeleteConfirmationDialog(user.userId!);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddEditUserDialog();
        },
        tooltip: 'ເພີ່ມຜູ້ໃຊ້ໃໝ່',
        child: const Icon(
          Icons.add,
          size: 30,
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Function to show a confirmation dialog before deleting a shoe
  void showDeleteConfirmationDialog(int userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.teal,
        title: const Center(child: Text('ຢືນຢັນການລຶບ')),
        content: Column(
          mainAxisSize: MainAxisSize.min, // ❗ ทำให้ content ไม่สูงเกินไป
          children: const [
            Text(
              'ທ່ານແນ່ໃຈວ່າຕ້ອງການລຶບເກີບນີ້?',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'ຍົກເລີກ',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              deleteUser(userId);
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text(
              'ລຶບ',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
