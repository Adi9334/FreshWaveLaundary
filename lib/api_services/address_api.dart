import 'package:http/http.dart' as http;
import 'package:freshwavelaundry/Models/address_model.dart';
import 'dart:convert';
import 'package:freshwavelaundry/api_services/global.dart';

class address_api {
  static Future<List<address_model>> fetchaddress(id) async {
    final url = APIservice.address + "/Address/AddressDetail/$id";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    //final json = jsonDecode(body);
    final results = jsonDecode(body);
    final data = results['data'];

    //final results = json['results'] as List<dynamic>;
    List<address_model> addresslist = [];
    for (var item in data) {
      addresslist.add(address_model.fromJson(item));
    }
    return addresslist;
  }
}
