import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:freshwavelaundry/Components/Row_itemCustom.dart';
import 'package:freshwavelaundry/Models/orderlist_model.dart';
import 'package:freshwavelaundry/Screens/ReviewOrderScreen.dart';
import 'package:freshwavelaundry/api_services/global.dart';
import 'package:freshwavelaundry/ui_helper/util.dart';

class view_oreder_details_screen extends StatefulWidget {
  List<orderlist_model>? orders;

  view_oreder_details_screen({required this.orders});

  @override
  State<view_oreder_details_screen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<view_oreder_details_screen> {
  @override
  Widget build(BuildContext context) {
    final order = widget.orders?.isNotEmpty == true ? widget.orders![0] : null;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Order Details",
            style: GoogleFonts.nunito(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 25,
            ),
          ),
          // backgroundColor: Colors.blue,
        ),
        backgroundColor: Colors.grey[300],
        body: order != null
            ? SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Order Summary', style: GoogleFonts.nunito(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 20,
                              ),),
                              Text('Arrived at ${order.order_delivery_slot}', style: GoogleFonts.nunito(
                                color: Colors.black,
                                fontSize: 15,
                              ),),
                              InkWell(
                                onTap: () {
                                  // Handle download invoice
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'Download Invoice',
                                      style: GoogleFonts.nunito(
                                        color: Colors.green,
                                      ),
                                    ),
                                    Icon(
                                      color: Colors.green,
                                      size: 18,
                                      Icons.file_download,
                                    ),
                                  ],
                                ),
                              ),
                              Text("${order.item!.length} items in this order", style: GoogleFonts.nunito(
                                color: Colors.black,
                                fontSize: 15,
                              ),),
                              ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: order.item!.length,
                                itemBuilder: (context, index) {
                                  final item = order.item![index];
                                  return ListTile(
                                    leading: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 0.5,
                                          color: Colors.grey.shade500,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 100,
                                      width: 75,
                                      child: Image.network(
                                        "${APIservice.address}${item.itemImage}",
                                      ),
                                    ),
                                    title: Text(item.itemName.toString()),
                                    subtitle:
                                        Text(item.itemQuantity.toString()),
                                    trailing: Text(
                                      '₹ ${item.itemAmount}',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return Divider(color: Colors.grey[400]);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(10),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Bill Details",
                              style: GoogleFonts.nunito(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            Divider(color: Colors.grey[400]),
                            Column(children: [
                              Row_itemCustom(
                                name: "MRP",
                                value: "₹ ${order.order_mrp.toString()}",
                              ),
                              Row_itemCustom(
                                name: "Promocode",
                                value: order.order_promocode.toString(),
                              ),
                              Row_itemCustom(
                                name: "Discount",
                                value: "₹ ${order.order_discount.toString()}",
                                Color: TextStyle(
                                  color: secondary(),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row_itemCustom(
                                name: "Total",
                                value:
                                    "₹ ${order.order_total_afterdis.toString()}",
                              ),
                              Row_itemCustom(
                                name: "Tax",
                                value: "₹ ${order.order_tax.toString()}",
                              ),
                              Row_itemCustom(
                                name: "Handling Charges",
                                value:
                                    "₹ ${order.order_handling_charges.toString()}",
                              ),
                              Row_itemCustom(
                                name: "Delivery Charges",
                                value:
                                    "₹ ${order.order_delivery_charges.toString()}",
                              ),
                            ]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Bill Total",
                                  style: GoogleFonts.nunito(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  "₹ ${order.order_total_price.toString()}",
                                  style: GoogleFonts.nunito(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(10),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order Details",
                              style: GoogleFonts.nunito(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                            ),
                            Divider(color: Colors.grey[400]),
                            Row_itemCustom(
                              name: "Order ID",
                              value: order.order_id.toString(),
                            ),
                            Row_itemCustom(
                              name: "Payment Mode",
                              value: order.order_payment_mode,
                            ),
                            Row_itemCustom(
                              name: "Delivery Type",
                              value: order.order_delivery_type,
                            ),
                            Row_itemCustom(
                              name: "Delivered at",
                              value: order.order_delivered_at.toString(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        color: Colors.white,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(vertical: 15),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReviewOrderScreen(
                                  orderId: order.order_id.toString(),
                                  deliveryDate: DateFormat('dd-MM-yyyy HH:mm')
                                      .format(DateTime.parse(
                                          order.order_delivered_at)),
                                ),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.rate_review, color: Colors.white),
                              SizedBox(width: 10),
                              Text(
                                "Review Order",
                                style: GoogleFonts.nunito(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Center(child: Text("No order details available",
              style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 15,
                ),
            )),
      ),
    );
  }
}
