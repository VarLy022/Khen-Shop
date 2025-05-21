import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'shoe_data_model.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  // Base URL for your API
  final String _baseUrl = kIsWeb
      ? 'http://172.20.10.2:3000/shoes' // สำหรับ Web
      : Platform.isAndroid
          ? 'http://172.20.10.2:3000/shoes' // สำหรับ Android Emulator
          : 'http://172.20.10.2:3000/shoes'; // สำหรับ iOS หรือ desktop

  List<Shoe> _shoes = [];
  bool _isLoading = true;
  String? errorMessage;
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();

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

  // Form controllers for the Add/Edit Shoe dialog
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchShoes();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _nameController.dispose();
    _brandController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _sizeController.dispose();
    _colorController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  // Function to fetch all shoes from the API
  Future<void> _fetchShoes() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      if (response.statusCode == 200) {
        // Parse the JSON response and convert it to a list of Shoe objects
        final List<dynamic> data = json.decode(response.body);
        _shoes = data.map((json) => Shoe.fromJson(json)).toList();
      } else {
        // Handle errors, such as server errors or invalid responses
        _showErrorDialog('Failed to load shoes: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network errors, such as connection refused or timeout
      _showErrorDialog('Error: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Function to add a new shoe to the API
  Future<void> _addShoe() async {
    // Basic form validation
    if (_nameController.text.isEmpty ||
            // _brandController.text.isEmpty ||
            _priceController.text.isEmpty ||
            _stockController.text.isEmpty ||
            _sizeController.text.isEmpty
        // _colorController.text.isEmpty ||
        // _descriptionController.text.isEmpty ||
        // _imageUrlController.text.isEmpty
        ) {
      _showErrorDialog('ກະລຸນາຢ່າໃຫ້ ຊື່,ລາຄາ,ຈຳນວນ,ຂະໜາດ ເປັນຄ່າວ່າງ.');
      return;
    }

    try {
      final shoe = Shoe(
        name: _nameController.text,
        brand: _brandController.text,
        price: double.parse(_priceController.text),
        stock: int.parse(_stockController.text),
        size: _sizeController.text,
        color: _colorController.text,
        description: _descriptionController.text,
        imageUrl: _imageUrlController.text,
      );
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode(shoe.toJson()),
      );

      if (response.statusCode == 201) {
        // Shoe added successfully, refresh the list
        _fetchShoes();
        _clearInputFields();
        Navigator.of(context).pop(); // Close the dialog
      } else {
        _showErrorDialog('ເກີດຂໍ້ຜິດພາດໃນການເພີ່ມເກີບ: ${response.statusCode}');
      }
    } catch (error) {
      _showErrorDialog('ກາລຸນາເຊື່ອມຕໍ່ກັບອິນເຕີເນັດ');
    }
  }

  // Function to edit an existing shoe
  Future<void> _editShoe(Shoe shoe) async {
    // Basic form validation
    if (_nameController.text.isEmpty ||
            // _brandController.text.isEmpty ||
            _priceController.text.isEmpty ||
            _stockController.text.isEmpty ||
            _sizeController.text.isEmpty
        // _colorController.text.isEmpty ||
        // _descriptionController.text.isEmpty ||
        // _imageUrlController.text.isEmpty
        ) {
      _showErrorDialog('ກະລຸນາຢ່າໃຫ້ ຊື່,ລາຄາ,ຈຳນວນ,ຂະໜາດ ເປັນຄ່າວ່າງ.');
      return;
    }
    try {
      final updatedShoe = Shoe(
        shoeId: shoe.shoeId,
        name: _nameController.text,
        brand: _brandController.text,
        price: double.parse(_priceController.text),
        stock: int.parse(_stockController.text),
        size: _sizeController.text,
        color: _colorController.text,
        description: _descriptionController.text,
        imageUrl: _imageUrlController.text,
      );
      final response = await http.put(
        Uri.parse('$_baseUrl/${shoe.shoeId}'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(updatedShoe.toJson()),
      );

      if (response.statusCode == 200) {
        // Shoe updated successfully, refresh the list
        _fetchShoes();
        _clearInputFields();
        Navigator.of(context).pop(); // Close the dialog
      } else {
        _showErrorDialog('Failed to edit shoe: ${response.statusCode}');
      }
    } catch (error) {
      // _showErrorDialog('ຂໍ້ຜິດພາດ: $error');
      _showErrorDialog('ກາລຸນາເຊື່ອມຕໍ່ກັບອິນເຕີເນັດ');
    }
  }

  // Function to delete a shoe
  Future<void> _deleteShoe(int shoeId) async {
    try {
      final response = await http.delete(Uri.parse('$_baseUrl/$shoeId'));
      if (response.statusCode == 200) {
        // Shoe deleted successfully, refresh the list
        _fetchShoes();
      } else {
        _showErrorDialog('Failed to delete shoe: ${response.statusCode}');
      }
    } catch (error) {
      _showErrorDialog('ກາລຸນາເຊື່ອມຕໍ່ກັບອິນເຕີເນັດ');
    }
  }

  // Function to show an error dialog
  void _showErrorDialog(String message) {
    // showDialog(
    //   context: context,
    //   builder: (context) => AlertDialog(
    //     title: const Text('ຂໍ້ຜິດພາດ'),
    //     content: Text(message),
    //     actions: [
    //       TextButton(
    //         onPressed: () => Navigator.of(context).pop(),
    //         child: const Text('ຕົກລົງ'),
    //       ),
    //     ],
    //   ),
    // );

    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      title: 'ຂໍ້ຜິດພາດ',
      desc: message,
      btnOkOnPress: () {},
    ).show();
  }

  // Function to clear input fields in the Add/Edit Shoe dialog
  void _clearInputFields() {
    _nameController.clear();
    _brandController.clear();
    _priceController.clear();
    _stockController.clear();
    _sizeController.clear();
    _colorController.clear();
    _descriptionController.clear();
    _imageUrlController.clear();
  }

  // Function to show the Add/Edit Shoe dialog
  void _showAddEditShoeDialog({Shoe? shoe}) {
    // Initialize controllers with shoe data if editing
    if (shoe != null) {
      _nameController.text = shoe.name;
      _brandController.text = shoe.brand;
      _priceController.text = shoe.price.toString();
      _stockController.text = shoe.stock.toString();
      _sizeController.text = shoe.size;
      _colorController.text = shoe.color;
      _descriptionController.text = shoe.description;
      _imageUrlController.text = shoe.imageUrl;
    } else {
      _clearInputFields(); // Clear fields when adding a new shoe
    }

    showModalBottomSheet(
      backgroundColor: const Color.fromARGB(255, 168, 197, 194),
      context: context,
      isScrollControlled: true, // Make the bottom sheet full-screen if needed
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom:
              MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
          top: 16,
          left: 16,
          right: 16,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    shoe == null ? 'ເພີ່ມເກີບໃໝ່' : 'ແກ້ໄຂຂໍ້ມູນເກີບ',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'ຊື່ເກີບ'),
                ),
                TextField(
                  controller: _brandController,
                  decoration: const InputDecoration(labelText: 'ຍີ່ຫໍ້'),
                ),
                TextField(
                  controller: _priceController,
                  decoration: const InputDecoration(labelText: 'ລາຄາ'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _stockController,
                  decoration: const InputDecoration(labelText: 'ຈຳນວນ'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _sizeController,
                  decoration: const InputDecoration(labelText: 'ຂະໜາດ'),
                ),
                TextField(
                  controller: _colorController,
                  decoration: const InputDecoration(labelText: 'ສີ'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'ລາຍລະອຽດ'),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _imageUrlController,
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
                                      leading: Icon(Icons.camera),
                                      title: Text('ຖ່າຍຮູບ (Camera)'),
                                      onTap: () async {
                                        Navigator.pop(
                                            context); // ปิด bottom sheet
                                        final XFile? photo =
                                            await _picker.pickImage(
                                                source: ImageSource.camera);
                                        if (photo != null) {
                                          setState(() {
                                            _imageUrlController.text =
                                                photo.path;
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
                                            _imageUrlController.text =
                                                image.path;
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        )),
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
                        Navigator.of(context).pop(); // Close the dialog
                        _clearInputFields();
                      },
                      child: const Text(
                        'ຍົກເລີກ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: () {
                        if (shoe == null) {
                          _addShoe();
                        } else {
                          _editShoe(shoe);
                        }
                      },
                      child: Text(
                        shoe == null ? 'ເພີ່ມ' : 'ບັນທຶກ',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade800,
      appBar: AppBar(
        title: isSearching
            ? TextField(
                controller: searchController,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    hintText: 'ຄົ້ນຫາ...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white60),
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                onChanged: (value) {
                  // เรียกฟังก์ชันค้นหา
                  if (searchController.text == "" ||
                      searchController.text == null) {
                    _fetchShoes();
                  } else {
                    searchShoe(searchController.text);
                  }
                },
              )
            : const Text('ຂໍ້ມູນສິນຄ້າ'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                if (!isSearching) {
                  searchController.clear();
                  _fetchShoes();
                }
              });
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator()) // Show loading indicator
          : Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.teal],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: GridView.builder(
                controller: _scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.7, // Adjust as needed
                ),
                padding: const EdgeInsets.all(8),
                itemCount: _shoes.length,
                itemBuilder: (context, index) {
                  final shoe = _shoes[index];
                  return Card(
                    shadowColor: Colors.green,
                    color: const Color.fromARGB(255, 168, 197, 194),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      onTap: () {
                        // Show shoe details or navigate to a detail page
                        _showShoeDetails(shoe);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              child: Image.network(
                                shoe.imageUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                errorBuilder: (context, error, stackTrace) {
                                  return Center(
                                    child:
                                        Image.asset('assets/icons/shoes.png'),
                                    // child: Icon(Icons.shopping_bag),
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  shoe.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  shoe.brand,
                                  style: const TextStyle(fontSize: 14),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'ຂະໜາດ: ${shoe.size}', // Format price
                                  style: const TextStyle(fontSize: 14),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                // SizedBox(height: 8),
                                Text(
                                  'ລາຄາ: ${NumberFormat("#,##0.00", "en_US").format(shoe.price)} LAK',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  size: 25,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  _showAddEditShoeDialog(shoe: shoe);
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  size: 25,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  _showDeleteConfirmationDialog(shoe.shoeId!);
                                },
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
          _showAddEditShoeDialog();
        },
        tooltip: 'ເພີ່ມເກີບໃໝ່',
        child: const Icon(
          Icons.add,
          size: 30,
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showShoeDetails(Shoe shoe) {
    showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, // Allows the sheet to take up full screen height
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 1,
          minChildSize: 0.5,
          maxChildSize: 1,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              // padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.teal, // Background color of the sheet
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20)), // Rounded top corners
              ),
              child: ListView(
                controller: scrollController,
                children: <Widget>[
                  Padding(
                    // padding: const EdgeInsets.symmetric(vertical: 40.0),
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Image.network(
                      shoe.imageUrl,
                      fit: BoxFit.contain,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Image.asset('assets/icons/shoes.png'),
                          // child: Icon(Icons.shopping_bag),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          shoe.name,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'ຍີ່ຫໍ້: ${shoe.brand}',
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'ຈຳນວນ: ${shoe.stock}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'ຂະໜາດ: ${shoe.size}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'ສີ: ${shoe.color}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'ລາຍລະອຽດ:',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          shoe.description,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'ລາຄາ: ${NumberFormat(
                            "#,##0.00",
                          ).format(shoe.price)} LAK',
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Function to show a confirmation dialog before deleting a shoe
  void _showDeleteConfirmationDialog(int shoeId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
              _deleteShoe(shoeId);
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
