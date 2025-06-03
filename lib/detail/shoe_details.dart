import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shoes_app/model/shoe_data_model.dart';

class ShoeDetails extends StatelessWidget {
  final Shoe shoe;

  const ShoeDetails({super.key, required this.shoe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        shoe.name,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[200],
                ),
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  shoe.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/icons/shoes.png',
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                "${shoe.brand} ${shoe.name}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Text(
                "ລາຍລະອຽດ: ${shoe.description}",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Divider(),
            Text(
              "ຂະໜາດ: ${shoe.size}",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                "ລາຄາ: ${NumberFormat("#,##0").format(shoe.price)} LAK",
                style: TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                    ),
                    child: Text(
                      "ເພີ່ມເຂົ້າກະຕ່າ 🛍🛒",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12,),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                    ),
                    child: Text(
                      "ຊື້ເລີຍ 🛍",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40,)
          ],
        ),
      ),
    );
  }
}
