import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:freshwavelaundry/Models/orderlist_model.dart';
import 'package:freshwavelaundry/Screens/ReviewOrderScreen.dart';
import 'package:freshwavelaundry/Screens/view_oreder_details_screen.dart';
import 'package:freshwavelaundry/ui_helper/util.dart';

class Myorder_card extends StatelessWidget {
  final orderlist_model order;

  Myorder_card({required this.order});

  @override
  Widget build(BuildContext context) {
    DateTime orderDate = DateTime.parse(order.order_date);
    return Card(
      elevation: 1,
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        color: order.order_status == "delivered"
                            ? Colors.green
                            : Colors.red,
                        order.order_status == "delivered"
                            ? Icons.check_circle_rounded
                            : Icons.cancel_rounded,
                      ),
                      SizedBox(width: 10),
                      Text(
                        order.name,
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: primary(),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => view_oreder_details_screen(
                            orders: [order],
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.arrow_right_alt),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Id : ${order.order_id.toString()}',
                          style: GoogleFonts.nunito(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: basic2(),
                          ),
                      ),
                      Text(
                        '${DateFormat('dd-MMM-yy').format(orderDate)} ',
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: basic2(),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Total Rs. ${order.order_total_price.toString()}',
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: basic2(),
                      ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
