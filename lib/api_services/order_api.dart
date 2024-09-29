import 'package:http/http.dart' as http;
import 'package:freshwavelaundry/Models/orderlist_model.dart';
import 'dart:convert';
import 'package:freshwavelaundry/api_services/global.dart';

// class order_api {
//   static Future<List<orderlist_model>> fetchorders(id) async {
//     final url = APIservice.address + "/Orders/OrderDetail/$id";
//     final uri = Uri.parse(url);
//     final response = await http.get(uri);
//     final body = response.body;
//     //final json = jsonDecode(body);
//     final results = jsonDecode(body);
//     final data = results['data'];
//     //final results = json['results'] as List<dynamic>;
//     List<orderlist_model> orderlist = [];

//     for (var item in data) {
//       orderlist.add(orderlist_model.fromJson(item));
//     }
//     return orderlist;
//   }
// }

class order_api {
  static Future<List<orderlist_model>> fetchorders(id) async {
    try {
      final url = APIservice.address + "/Orders/OrderDetail/$id";
      final uri = Uri.parse(url);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final body = response.body;
        final results = jsonDecode(body);
        final data = results['data'];

        List<orderlist_model> orderlist = [];

        for (var item in data) {
          orderlist.add(orderlist_model.fromJson(item));
        }

        return orderlist;
      } else {
        // Handle non-200 status codes
        throw Exception('Failed to load orders: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exceptions
      print('An error occurred while fetching orders: $error');
      // Optionally, you can rethrow the error or return an empty list
      return [];
    }
  }
}
