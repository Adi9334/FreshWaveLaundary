import 'package:flutter/material.dart';
import 'package:freshwavelaundry/Models/CouponModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:freshwavelaundry/api_services/global.dart';

class CouponCard extends StatelessWidget {
  final CouponModel coupon;

  const CouponCard({
    Key? key,
    required this.coupon,
  }) : super(key: key);

  String formatDate(String dateStr) {
    try {
      final dateTime = DateTime.parse(dateStr);
      final formattedDate = DateFormat('dd - MMM - yy').format(dateTime);
      return formattedDate;
    } catch (e) {
      return dateStr; // Return the original string if parsing fails
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        color: Color.fromARGB(255, 247, 247, 247),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              if (coupon.imagePath !=
                  null) // Display image if imagePath is provided
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: NetworkImage(
                            '${APIservice.address}${coupon.imagePath!}'),
                        fit: BoxFit.fill),
                  ),
                ),
              SizedBox(width: 10),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (coupon.imagePath !=
                        null) // Add a divider line if there is an image
                      Container(
                        height: 110,
                        width: 1,
                        color: Colors.grey, // Adjust color as needed
                        margin: EdgeInsets.symmetric(vertical: 8),
                      ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${coupon.discounttype} ${coupon.discount != 0 ? "${coupon.discount}% OFF" : ''}",
                            style: GoogleFonts.nunito(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 4, 4, 4),
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            //coupon.minimumorder,
                            "${coupon.ordertype} Rs.${coupon.minimumorder}",
                            style: GoogleFonts.nunito(
                              color: Color.fromARGB(255, 4, 4, 4),
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Code: ${coupon.code}",
                            style: GoogleFonts.nunito(
                              color: Color.fromARGB(255, 4, 4, 4),
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Expiry: ${formatDate(coupon.expirydate)}",
                            style: GoogleFonts.nunito(
                              color: Color.fromARGB(255, 4, 4, 4),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ])));
  }
}
