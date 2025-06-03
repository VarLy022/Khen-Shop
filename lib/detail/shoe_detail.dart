// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:shoes_app/model/shoe_data_model.dart';

// class ShoeDetail extends StatelessWidget {
//   final Shoe shoe;
//   final ScrollController scrollController;

//   const ShoeDetail({
//     Key? key,
//     required this.shoe,
//     required this.scrollController,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         color: Colors.teal,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       child: ListView(
//         controller: scrollController,
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.only(top: 40.0),
//             child: Image.network(
//               shoe.imageUrl,
//               fit: BoxFit.contain,
//               width: double.infinity,
//               errorBuilder: (context, error, stackTrace) {
//                 return Center(child: Image.asset('assets/icons/shoes.png'));
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(shoe.name,
//                     style: const TextStyle(
//                         fontSize: 24, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 8),
//                 Text('ຍີ່ຫໍ້: ${shoe.brand}',
//                     style: const TextStyle(fontSize: 18)),
//                 const SizedBox(height: 8),
//                 Text('ຈຳນວນ: ${shoe.stock}',
//                     style: const TextStyle(fontSize: 18)),
//                 const SizedBox(height: 8),
//                 Text('ຂະໜາດ: ${shoe.size}',
//                     style: const TextStyle(fontSize: 18)),
//                 const SizedBox(height: 8),
//                 Text('ສີ: ${shoe.color}',
//                     style: const TextStyle(fontSize: 18)),
//                 const SizedBox(height: 16),
//                 const Text('ລາຍລະອຽດ:',
//                     style:
//                         TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 8),
//                 Text(shoe.description, style: const TextStyle(fontSize: 16)),
//                 const SizedBox(height: 8),
//                 Text(
//                   'ລາຄາ: ${NumberFormat("#,##0.00").format(shoe.price)} LAK',
//                   style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.amber),
//                 ),
//                 const SizedBox(height: 20),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// void _showShoeDetails(Shoe shoe) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (context) {
//         return DraggableScrollableSheet(
//           initialChildSize: 1,
//           minChildSize: 0.5,
//           maxChildSize: 1,
//           builder: (BuildContext context, ScrollController scrollController) {
//             return ShoeDetails(
//               shoe: shoe,
//               scrollController: scrollController,
//             );
//           },
//         );
//       },
//     );
//   }
