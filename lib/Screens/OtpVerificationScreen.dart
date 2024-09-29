import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freshwavelaundry/Screens/AddDetailsScreen.dart';
import 'package:freshwavelaundry/api_services/OTPService.dart';
import 'package:freshwavelaundry/providers/UserDataProvider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OtpVerificationScreen extends StatefulWidget {
  final phone_number;
  OtpVerificationScreen({this.phone_number});
  @override
  _OtpVerificationPageState createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  void _verifyOtp() async {
    final otp = _otpController.text.toString();
    if (otp.length == 4) {
      final userData = Provider.of<UserDataProvider>(context, listen: false);
      print('this is the reference id ${userData.referenceId}');
      OTPServices.verifyOTP(
          otp, widget.phone_number, userData.referenceId, context);
    } else {
      // Handle invalid OTP length
      Fluttertoast.showToast(msg: 'Invalid Otp');
    }
  }

  void _resendOtp() {
    final userData = Provider.of<UserDataProvider>(context, listen: false);
    OTPServices.resendOTPapi(
        widget.phone_number, userData.referenceId, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('OTP Verification'),
      // ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'OTP Verification',
                style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 30,
                    ),
              ),
              SizedBox(height: 20),
              Text(
                'We have sent an access code via message for verification on your registered mobile number',
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 15,
                    ),
              ),
              SizedBox(height: 20),
              Pinput(
                length: 4,
                controller: _otpController,
                focusNode: _focusNode,
                androidSmsAutofillMethod:
                    AndroidSmsAutofillMethod.smsUserConsentApi,
                onCompleted: (pin) => _verifyOtp(),
                showCursor: true,
                pinAnimationType: PinAnimationType.fade,
                defaultPinTheme: PinTheme(
                  width: 60,
                  height: 60,
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                ),
                focusedPinTheme: PinTheme(
                  width: 60,
                  height: 60,
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _verifyOtp(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  minimumSize: Size(265, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Verify',
                  style: GoogleFonts.nunito(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Didn't receive the OTP?",
                style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 15,
                    ),
              ),
              TextButton(
                onPressed: _resendOtp,
                child: Text(
                  'Resend OTP',
                  style: GoogleFonts.nunito(
                          color: Colors.blue,
                          fontSize: 15,
                    ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
