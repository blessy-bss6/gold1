import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {
  void setString(
    String key,
    String value,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(key, value);
  }

  Future<String> getString(
    String key,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(key)!;
  }

  Future<bool> containsKey(String key) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.containsKey(key);
  }

  Future<bool> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  // // ! Geeting User Type
  void setUserTypeScr(String idkey, int idvalue) async {
    final iduserType = await SharedPreferences.getInstance();
    await iduserType.setInt(idkey, idvalue);
  }

  Future<int> getUserTypeScr(String idkey) async {
    final iduserType = await SharedPreferences.getInstance();
    // return iduserType.getString(idkey)!;
    return iduserType.getInt(idkey)!;
  }

  Future<bool> usercontainsKey(String idkey) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(idkey);
  }
}

// 1 Cart With Local DataBase

class ShopC {
  final shoppingBox = Hive.box('shopping_box');

  refreshItems() {
    final data = shoppingBox.keys.map((key) {
      final value = shoppingBox.get(key);
      return {
        "key": key,
        "id": value["id"],
        "name": value["name"],
        "pic": value["pic"],
        "quantity": value['quantity'],
        "Fixedsale_price": value["Fixedsale_price"],
        "Fixedregular_price": value["Fixedregular_price"],
        "sale_price": value["sale_price"],
        "regular_price": value["regular_price"]
      };
    }).toList();

    final orderData = shoppingBox.keys.map((key) {
      final value = shoppingBox.get(key);
      return {
        "key": key,
        "product_id": value["id"],
        "quantity": value['quantity'],
      };
    }).toList();

    // ! Price Logic
    final subPriceList = [];
    final mrpPriceList = [];
    dynamic subPrice = 0;
    dynamic mrpPrice = 0;
    dynamic shipPrice = 0;

    for (var i in data) {
      subPriceList.add(i['sale_price']);
      mrpPriceList.add(i['regular_price']);
    }

    if (subPriceList.isNotEmpty && mrpPriceList.isNotEmpty) {
      subPrice = subPriceList.reduce((a, b) => a + b);

      mrpPrice = mrpPriceList.reduce((a, b) => a + b);
    } else {
      subPrice = 0;
      mrpPrice = 0;
    }

    // if (subPrice < 500) {
    //   shipPrice = 0;
    // }
    // return data.reversed.toList();

    return {
      "data": data.reversed.toList(),
      "subPrice": subPrice,
      "mrpPrice": mrpPrice,
      "shipPrice": shipPrice,
      "orderData": orderData
    };
  }

// Create new item
  Future<void> createItem(Map<String, dynamic> newItem) async {
    await shoppingBox.add(newItem);
  }

  Map<String, dynamic> readItem(int key) {
    final item = shoppingBox.get(key);
    return item;
  }

// Update a single item
  Future<void> updateItem(int itemKey, Map<String, dynamic> item) async {
    await shoppingBox.put(itemKey, item);
  }

// Delete a single item
  Future deleteItem(int itemKey) async {
    await shoppingBox.delete(itemKey);
  }
}
