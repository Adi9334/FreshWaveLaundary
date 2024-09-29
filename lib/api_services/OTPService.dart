import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:freshwavelaundry/Constants/Dialogs.dart';
import 'package:freshwavelaundry/Screens/AddDetailsScreen.dart';
import 'package:freshwavelaundry/Screens/home_main.dart';
import 'dart:convert';

import 'package:freshwavelaundry/api_services/global.dart';
import 'package:freshwavelaundry/providers/UserDataProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPServices {
  static const KEYUSERID = "";

  static Future<void> verifyOTP(
      enteredOTP, user_mobile_no, refrence_id, BuildContext context) async {
    final apiUrl = APIservice.address + '/verify-otp';
    try {
      // final headers = <String, String>{
      //   'Content-Type': 'application/json',
      //   'iv': iv.base64,
      // };

      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'refrence_id': refrence_id.toString(),
          'otp_value': enteredOTP,
          'phone_number': user_mobile_no,
        },
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        //loader(false, context);
        //print(response.statusCode);
        //print(response);
        final userData = Provider.of<UserDataProvider>(context, listen: false);
        final responseBody = jsonDecode(response.body);
        var sharedPref = await SharedPreferences.getInstance();
        sharedPref.setString(
            KEYUSERID, responseBody['data']['user_record_id'].toString());
        userData.setUserId(responseBody['data']['user_record_id'].toString());
        final isNewUser = responseBody['data']['isNewUser'];
        print(isNewUser);

        if (isNewUser == false) {
          SuccessDialog(context, 'Verification Successful',
              'OTP has been successfully verified', home_main());
        } else {
          SuccessDialog(
              context,
              'Verification Successful',
              'OTP has been successfully verified',
              AddDetailsScreen(
                phone_number: user_mobile_no,
              ));
        }
      } else {
        //loader(false, context);
        //final body = jsonDecode(response.body);

        ErrorDialog(context, "Verification Failed",
            'The entered OTP is incorrect or expired. Please try again');
      }
    } catch (error) {
      //loader(false, context);
      print(error);
      ErrorDialog(
          context, "Alert", 'Something went wrong. Please try again later');
    }
  }

  //resendOTP

  static Future<String?> resendOTPapi(
      String user_mobile_no, String refrence_id, BuildContext context) async {
    //final iv = IV.fromLength(16);
    final apiUrl = APIservice.address + '/resend-otp';

    // final headers = <String, String>{
    //   'Content-Type': 'application/json',
    //   'iv': iv.base64
    // };

    final resendOTPBody = {
      'refrence_id': refrence_id,
      'phone_number': user_mobile_no
    };

    print(resendOTPBody);

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        //headers: headers,
        body: resendOTPBody,
      );
      if (response.statusCode == 200) {
        print(response.body);
        final responseData = jsonDecode(response.body);
        print(responseData);
        final userData = Provider.of<UserDataProvider>(context, listen: false);
        userData.setReferenceId(responseData['data']['refrence_id'].toString());
        showDialog(
          context: context,
          builder: (BuildContext context) {
            Future.delayed(Duration(seconds: 1), () {
              Navigator.of(context).pop();
            });
            return AlertDialog(
              title: Text(' OTP Resend Successful'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image.asset('assets/images/righttick.png')),
                  Text('OTP has been successfully'),
                ],
              ),
            );
          },
        );
        return userData.referenceId;
      } else {
        Text('Failed to generate OTP. Status code: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print(error);
      return null;
    }
  }
}
