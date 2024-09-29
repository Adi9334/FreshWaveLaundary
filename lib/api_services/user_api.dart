import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:freshwavelaundry/Models/user_model.dart';
import 'package:freshwavelaundry/api_services/global.dart';
import 'package:freshwavelaundry/providers/UserDataProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class user_api {
  static Future<String> fetchUserID() async {
    String KEYUSERID = "";
    var sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString(KEYUSERID) ?? "0";
  }

  static Future<List<user_model>> fetchuser() async {
    try {
      final id = await fetchUserID();
      print(id);

      final url = APIservice.address + '/User/OneUser/$id';
      final uri = Uri.parse(url);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final body = response.body;
        print(body);

        final jsonData = jsonDecode(body);
        user_model user = user_model.fromJson(jsonData);
        return [user];
      } else {
        // Handle non-200 status code
        print('Failed to load user: ${response.statusCode}');
        return Future.error('Failed to load user');
      }
    } catch (error) {
      // Handle exceptions
      print('An error occurred: $error');
      return Future.error('An error occurred');
    }
  }
}
