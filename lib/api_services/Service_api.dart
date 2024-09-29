import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:freshwavelaundry/Models/AppBannerModel.dart';
import 'package:freshwavelaundry/Models/service_model.dart';
import 'package:freshwavelaundry/api_services/global.dart';

Future<List<Service>> fetchData() async {
  const url = APIservice.address + "/Service/allService";
  print(url);
  final response = await http.get(Uri.parse('${url}'));
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    List<Service> services =
        data.map((json) => Service.fromJson(json)).toList();
    print(services);
    return services;
  } else {
    print(response.statusCode);
    throw Exception('Failed to load data');
  }
}

Future<List<AppBanner>> fetchBanner() async {
  const url = APIservice.address + "/Banner/allBanner";
  print(url);
  final response = await http.get(Uri.parse('${url}'));
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    List<AppBanner> banner =
        data.map((json) => AppBanner.fromJson(json)).toList();
    print(banner);
    return banner;
  } else {
    print(response.statusCode);
    throw Exception('Failed to load data');
  }
}
