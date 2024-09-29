import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:freshwavelaundry/Constants/Dialogs.dart';
import 'package:freshwavelaundry/Screens/OtpVerificationScreen.dart';
import 'dart:convert';

import 'package:freshwavelaundry/api_services/global.dart';
import 'package:freshwavelaundry/providers/UserDataProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginServices {
  static const KEYLOGIN = "LOGIN";

  static Future<void> login(BuildContext context, String phoneNumber) async {
    final userData = Provider.of<UserDataProvider>(context, listen: false);
    final apiUrl = APIservice.address + '/send-otp';

    try {
      final response = await http.post(Uri.parse(apiUrl), body: {
        'phone_number': phoneNumber,
      });

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        print('Request successful');

        try {
          final responseBody = jsonDecode(response.body);
          print('Decoded response: $responseBody');

          final referenceID = responseBody['refrence_id'];
          print('Reference ID: $referenceID');

          userData.setReferenceId(referenceID.toString());
          print('Updated reference ID: ${userData.referenceId}');

          var sharedPref = await SharedPreferences.getInstance();
          sharedPref.setBool(KEYLOGIN, true);

          SuccessDialog(
            context,
            'Verify OTP for login',
            'OTP Send Successfully.',
            OtpVerificationScreen(phone_number: phoneNumber),
          );
        } catch (decodeError) {
          print('Error decoding response: $decodeError');
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('Failed to decode response. Please try again.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Login'),
              content: Text('Invalid Credentials'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Request error: $e');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Alert'),
            content: Text('Something Went Wrong. Please try again later'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
