import 'package:http/http.dart' as http;
import 'package:freshwavelaundry/Models/item_model.dart';
import 'package:freshwavelaundry/Models/orderlist_model.dart';
import 'dart:convert';
import 'package:freshwavelaundry/api_services/global.dart';

class item_api {
  static Future<List<item_model>> fetchitems() async {
    const url = APIservice.address + "/Service/Item/allItem";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    //final json = jsonDecode(body);
    final results = jsonDecode(body);

    //final results = json['results'] as List<dynamic>;
    List<item_model> itemlist = [];

    for (var item in results) {
      itemlist.add(item_model.fromJson(item));
    }
    return itemlist;
  }
}
