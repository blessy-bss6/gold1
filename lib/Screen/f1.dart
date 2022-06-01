// // Home Page
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:shop/Backend/Bloc/cart_wishlist_Bloc.dart';
// import 'package:shop/Elements/baseAppbar.dart';
// import 'package:shop/Elements/button.dart';
// import 'package:shop/Elements/imgScr.dart';
// import 'package:shop/common/order_cart_item.dart';
// import 'package:shop/utils/common.dart';
// import 'package:shop/utils/shared_helper.dart';
// import 'package:shop/utils/style.dart';

// import 'CheckOutScr.dart';

// class DemoPage extends StatefulWidget {
//   const DemoPage({Key? key}) : super(key: key);

//   @override
//   _DemoPageState createState() => _DemoPageState();
// }

// class _DemoPageState extends State<DemoPage> {
//   List<Map<String, dynamic>> _items = [];

//   final _shoppingBox = Hive.box('shopping_box');

//   @override
//   void initState() {
//     super.initState();
//     _refreshItems(); // Load data when app starts
//   }

//   // // Get all items from the database
//   void _refreshItems() {
//     final data = _shoppingBox.keys.map((key) {
//       final value = _shoppingBox.get(key);
//       return {
//         "key": key,
//         "id":value["id"],
//         "name":value["name"],
//         "fullPrice": value["fullPrice"],
//         "quantity": value['quantity'],
//         "price": value['price']
//       };
//     }).toList();

//     setState(() {
//       _items = data.reversed.toList();
//       // we use "reversed" to sort items in order from the latest to the oldest
//     });

//     print(_items);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('KindaCode.com'),
//       ),
//       body: ListView.builder(
//           // the list of items
//           itemCount: _items.length,
//           itemBuilder: (_, index) {
//             final currentItem = _items[index];
//             return Card(
//               color: Colors.orange.shade100,
//               margin: const EdgeInsets.all(10),
//               elevation: 3,
//               child: ListTile(
//                   title: Row(
//                     children: [
//                       Text('id $index'),
//                       Text('name' + currentItem['name'].toString()),
//                     ],
//                   ),
//                   subtitle: Column(
//                     children: [
//                       Text(currentItem['quantity'].toString()),
//                       CartBtn2(
//                   // onPressed1: cartItem > 1
//                   //     ? () async {
//                   //         setState(() {
//                   //           cartItem -= 1;


//                             // update an existing item
//                             // if (itemKey != null) {
//                             //   updateItem(itemKey, {
//                             //     'name': _nameController.text.trim(),
//                             //     'quantity': _quantityController.text.trim()
//                             //   });
//                             // }

                           
//                 //           });
//                 //         }
//                 //       : null,
//                 //   cartItem: cartItem,
//                 //   onPressed2: () {
//                 //     setState(() {
//                 //       cartItem += 1;
//                 //     });
//                 //   },
//                 // ),
//                 //     ],
//                 //   ),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       // Edit button
//                       // IconButton(
//                       //     icon: const Icon(Icons.edit),
//                       //     onPressed: () =>
//                       //         _showForm(context, currentItem['key'])),
//                       // Delete button
//                       IconButton(
//                         icon: const Icon(Icons.delete),
//                         onPressed: () => deleteItem(currentItem['key']),
//                       ),
//                     ],
//                   ));
            
//           }),
//     );
//   }
// }
