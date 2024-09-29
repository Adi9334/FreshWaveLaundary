import 'package:flutter/material.dart';
import 'package:freshwavelaundry/Models/item_model.dart';
import 'package:freshwavelaundry/api_services/booking_item_api.dart';

class CounterModel with ChangeNotifier {
  // int _counter = 0;

  // List<int> _counter = [];
  //   List<int> get counter => _counter;

  List<Map<String, dynamic>> _booking_items = [];

  List<Map<String, dynamic>> get booking_items => _booking_items;

  List<Map<String, dynamic>> _selected_items = [];
  List<Map<String, dynamic>> get selected_tems => _selected_items;

  double _totalprice = 0;
  double get total_price => _totalprice;

  Future<void> generateList() async {
    List<item_model> itemData = await item_api.fetchitems();
    print(itemData);
    _booking_items = List.generate(
        itemData.length,
        (index) => {
              "item_id": itemData[index].id,
              "item_image": itemData[index].image,
              "item_name": itemData[index].name,
              "item_price": itemData[index].price,
              "quantity": 0,
              "cost": 0
            });
    print("item_0");
    print(_booking_items[0]);
  }

  // void getListLength(int length, String itemName, double itemPrice) {
  //   _booking_items = List.generate(
  //       length,
  //       (index) => {
  //             "item_name": itemName,
  //             "item_price": itemPrice,
  //             "quantity": 0,
  //             "cost": 0
  //           });

  //   print(booking_items);
  // }

  // void increment(int index) {
  //   if (_counter[index] < 10) {
  //     _counter[index]++;
  //     notifyListeners();
  //   }
  // }

  void increment(int index, double item_price) {
    if (_booking_items[index]['quantity'] < 10) {
      _booking_items[index]['quantity']++;
      print('Dec value' + _booking_items[index]['quantity'].toString());
      getCost(index, item_price);

      print(booking_items);
      notifyListeners();
    }
  }

  // void decrement(int index) {
  //   if (_counter[index] > 0) {
  //     _counter[index]--;
  //     notifyListeners();
  //   }
  // }

  void decrement(int index, double item_price) {
    if (_booking_items[index]['quantity'] > 0) {
      _booking_items[index]['quantity']--;
      getCost(index, item_price);
      // totalcostfordecrement(_booking_items[index]['cost']);
      print('Dec value' + _booking_items[index]['quantity'].toString());
      notifyListeners();
    }
  }

  void getCost(int index, double item_price) {
    _booking_items[index]['cost'] =
        _booking_items[index]['quantity'] * item_price;
    print('Cost' + _booking_items[index]['cost'].toString());
    notifyListeners();
  }

  void addBookingItems() {
    selected_tems.clear();
    for (int index = 0; index < _booking_items.length; index++) {
      if (_booking_items[index]['quantity'] != 0) {
        selected_tems.add({
          'item_id': _booking_items[index]['item_id'],
          'item_name': _booking_items[index]['item_name'],
          'item_price': _booking_items[index]['item_price'],
          'item_quantity': _booking_items[index]['quantity'],
          'item_image': _booking_items[index]['item_image'],
          'item_cost': _booking_items[index]['cost'],
        });
      }
    }
  }

  double calculateTotalCost() {
    double totalCost = 0.0;
    for (var item in _booking_items) {
      totalCost += item['cost'];
    }
    return totalCost;
  }

  void resetState() {
    _booking_items = [];
    _selected_items = [];

    notifyListeners();
  }
}
