import 'package:flutter/material.dart';
import 'package:freshwavelaundry/Components/CouponCard.dart';
import 'package:freshwavelaundry/Models/CouponModel.dart';
import 'package:freshwavelaundry/api_services/CouponApi.dart';
import 'package:google_fonts/google_fonts.dart';

class CouponScreen extends StatefulWidget {
  @override
  _CouponPageState createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponScreen> {
  List<CouponModel> availableCoupons = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCoupons();
  }

  Future<void> _fetchCoupons() async {
    try {
      List<CouponModel> coupons = await CouponApi.fetchcoupon();
      setState(() {
        availableCoupons = coupons;
        _isLoading = false;
      });
    } catch (error) {
      print('Error fetching coupons: $error');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      // Optionally, handle the error state (e.g., show a message to the user)
    }
  }

  //String appliedCoupon = '';
  // List<Coupon> availableCoupons = [
  //   Coupon('Flat 50% off', 'On min. Order above ₹1699', 'Code:SUMMER50',
  //       'Expiry:31 Jul 2024',
  //       imagePath: 'assets/images/Summer.jpg'),
  //   Coupon('Flat 20% off', 'On min. Order above ₹999', 'Code:WELCOME20',
  //       'Expiry:31 Jul 2024',
  //       imagePath: 'assets/images/20discount.jpg'),
  //   Coupon('Flat 50% off', 'On First Order Above ₹299', 'Code:NEW50',
  //       'Expiry:31 AUG 2024',
  //       imagePath: 'assets/images/50discount.jpg'),
  //   Coupon('Flat 5% off', 'On min. Order above ₹399', 'Code:SAVE5',
  //       'Expiry:31 Jul 2024',
  //       imagePath: 'assets/images/5discount.jpg'),
  //   Coupon('Upto 14% off', 'On min. Order above ₹799', 'Code:SAVEMORE14',
  //       'Expiry:31 Jul 2024',
  //       imagePath: 'assets/images/14discount.jpg'),
  //   Coupon('Free Delivery', 'On Order above ₹299', 'Code:FREEDEL',
  //       'Expiry:31 Jul 2024',
  //       imagePath: 'assets/images/free delivery.jpg')
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Offers Page',
         style: GoogleFonts.nunito(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 25,
        ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              'Available Coupons',
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: availableCoupons.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 20),
                        child: CouponCard(
                          coupon: availableCoupons[index],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
