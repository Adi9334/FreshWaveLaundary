import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:freshwavelaundry/Models/CouponModel.dart';
import 'dart:convert';

import 'package:freshwavelaundry/Models/user_model.dart';
import 'package:freshwavelaundry/api_services/global.dart';
import 'package:freshwavelaundry/providers/UserDataProvider.dart';
import 'package:provider/provider.dart';

class CouponApi {
  static Future<List<CouponModel>> fetchcoupon() async {
    final url = APIservice.address + '/Coupon/allcoupon';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final jsonData = jsonDecode(body);

    List<CouponModel> couponlist = [];

    for (var item in jsonData) {
      couponlist.add(CouponModel.fromJson(item));
    }
    return couponlist;
  }
}
