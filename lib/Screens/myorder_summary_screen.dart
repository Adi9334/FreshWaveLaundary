import 'dart:convert';
import 'package:freshwavelaundry/Screens/Myorders_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:freshwavelaundry/Components/Animatedbox.dart';
import 'package:freshwavelaundry/Components/Row_itemCustom.dart';
import 'package:freshwavelaundry/Components/TImeline.dart';
import 'package:freshwavelaundry/Models/Timeslot.dart';
import 'package:freshwavelaundry/Components/customListTile.dart';
import 'package:freshwavelaundry/Models/counter_model.dart';
import 'package:freshwavelaundry/Models/orderlist_model.dart';
import 'package:freshwavelaundry/Screens/Booking_item_screen.dart';
import 'package:freshwavelaundry/Screens/Home_screen.dart';
import 'package:freshwavelaundry/Screens/address_screen.dart';
import 'package:freshwavelaundry/Screens/home_main.dart';
import 'package:freshwavelaundry/api_services/global.dart';
import 'package:freshwavelaundry/api_services/user_api.dart';
import 'package:freshwavelaundry/providers/Dateprovider.dart';
import 'package:freshwavelaundry/providers/UserDataProvider.dart';
import 'package:freshwavelaundry/providers/address_provider.dart';
import 'package:freshwavelaundry/providers/timeprovider.dart';
import 'package:freshwavelaundry/ui_helper/util.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:provider/provider.dart';

class myorder_summary_screen extends StatefulWidget {
  final int serviceID;
  myorder_summary_screen({
    Key? key,
    required this.serviceID,
  });
  @override
  State<myorder_summary_screen> createState() => _MyWidgetState();
}

enum PaymentMethod { UPI, CashOnDelivery }

// double calculateTotalCost(int quantity, double cost) {
//   return quantity * cost;
// }

double tax = 10;
double Handling = 15;
double Delivery = 15;
double calculateOrderTotal(List<Map<String, dynamic>> items) {
  double totalCost = 0;
  items.forEach((item) {
    int quantity = item['item_quantity'];
    double cost = item['item_cost'];
    totalCost += cost;
    //totalCost += calculateTotalCost(quantity, cost);
  });
  print(totalCost);
  return totalCost;
}

double calculateEighteenPercent(double total) {
  double eighteenPercent = total * 0.18;
  eighteenPercent = total - eighteenPercent;
  return eighteenPercent;
}

double calculateBill(double total, double tax, double hc, double dc) {
  double totalbill = total + tax + hc + dc;
  return totalbill;
}

class _MyWidgetState extends State<myorder_summary_screen> {
  late Razorpay _razorpay;
  var paymentstatus = false;
  bool _isButtonDisabled = false;

  @override
  void initState() {
    super.initState();
    _isButtonDisabled = false;
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Handle payment success
    print("Payment success: ${response.paymentId}");
    paymentstatus = true;
    //_saveOrderDetails(); // Call your order saving function after successful payment
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle payment failure
    print("Payment error: ${response.code.toString()}");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Payment Error"),
          content: Text("Payment failed. Please try again."),
          actions: <Widget>[
            TextButton(
              child: Text("OK",
                style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 15,
              ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet
    print("External wallet: ${response.walletName}");
  }

  void _openCheckout(double amount) async {
    var options = {
      'key': 'rzp_test_WkI8v3F39MV091',
      'amount': calculateBill(
              calculateEighteenPercent(calculateOrderTotal(
                  Provider.of<CounterModel>(context, listen: false)
                      .selected_tems)),
              tax,
              Handling,
              Delivery) *
          100,
      'name': 'Laundry Application',
      'description': 'Order Payment',
      'prefill': {
        'contact': '920123654',
        'email': 'LaundaryMsL@gmail.com',
      },
      'external': {
        'wallets': ['paytm', 'freecharge', 'mobikwik', 'phonepe', 'amazonpay']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: ${e.toString()}');
    }
  }

  void _initiatePayment(totalBill) {
    _openCheckout(totalBill);
  }

  void _resetAndShowDialog({required String title, required String content}) {
    Provider.of<CounterModel>(context, listen: false).resetState();
    Provider.of<address_provider>(context, listen: false).resetState();
    Provider.of<DateProvider>(context, listen: false).resetState();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title,
          style: GoogleFonts.nunito(
                color: Colors.black,
                fontSize: 15,
              ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),
              Text(
                content,
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 18,
                  ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("OK", 
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 15,
              ),),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => home_main()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  PaymentMethod _selectedPaymentMethod = PaymentMethod.CashOnDelivery;

  @override
  Widget build(BuildContext context) {
    final booking_items =
        Provider.of<CounterModel>(context, listen: false).selected_tems;
    final selectedAddress =
        Provider.of<address_provider>(context).selectedAddress;
    final selectedtimeslot =
        Provider.of<TimeSlotProvider>(context, listen: false).selectedTimeSlot;
    //final userdata = Provider.of<UserDataProvider>(context, listen: false);

    double mrp = calculateOrderTotal(booking_items);
    double discount = 18; // Example discount
    double totalAfterDiscount =
        calculateEighteenPercent(calculateOrderTotal(booking_items));
    double totalBill =
        calculateBill(totalAfterDiscount, tax, Handling, Delivery);

    Future<void> _saveOrderDetails() async {
      try {
        final id = await user_api.fetchUserID();
        // Calculate order totals

        // Collect order data
        final orderData = {
          'user_id': id,
          'service_id': widget.serviceID,
          'order_item_quantity': booking_items.length,
          'order_mrp': mrp,
          'order_item_price':
              calculateEighteenPercent(calculateOrderTotal(booking_items))
                  .toStringAsFixed(2),
          'order_tax': tax,
          'order_discount': discount,
          'order_total_afterdis': totalAfterDiscount,
          'order_promocode': 'promo 18',
          'order_delivery_charges': Delivery,
          'order_handling_charges': Handling,
          'order_total_price': totalBill,
          'order_address_id': selectedAddress?.id ?? 0,
          'order_payment_mode':
              _selectedPaymentMethod.toString().split('.').last,
          'order_status': 'delivered',
          'order_delivered_at': DateTime.now().toIso8601String(),
          'order_delivery_slot': selectedtimeslot,
          'order_delivery_type': 'home_delivery',
          'created_by': 'admin',
          'is_active': true
        };
        print(orderData);
        // Send POST request to save order
        final response = await http.post(
          Uri.parse('${APIservice.address}/Orders/addOrder'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode(orderData),
        );

        if (response.statusCode != 200) {
          throw Exception('Failed to save order: ${response.body}');
        }

        // Extract order ID from response
        final orderId = json.decode(response.body)['id'];

        // Collect order item data and send POST requests
        List<Future<http.Response>> futures = [];
        for (var item in booking_items) {
          final orderItemData = {
            'order_id': orderId,
            'order_item_id': item['item_id'],
            'order_item_quantity': item['item_quantity'],
            'order_item_price': item['item_cost'],
            'created_by': 'admin',
            'is_active': true
          };

          futures.add(http.post(
            Uri.parse('${APIservice.address}/Order/Item/addOrderItem'),
            headers: {
              'Content-Type': 'application/json',
            },
            body: json.encode(orderItemData),
          ));
        }

        // Await all futures
        final itemResponses = await Future.wait(futures);

        // Check if any of the item responses failed
        if (itemResponses.any((response) => response.statusCode != 200)) {
          // Rollback - delete the created order
          await http.delete(
            Uri.parse('${APIservice.address}/Orders/deleteOrder/$orderId'),
            headers: {
              'Content-Type': 'application/json',
            },
          );
          setState(() {
            _isButtonDisabled = false;
          });

          throw Exception(
              'Failed to save one or more order items. Transaction rolled back.');
        }

        print('Order and all items saved successfully');
      } catch (e) {
        print('Failed to save order: $e');
      }
    }

    print('final data');
    print(booking_items);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Order Summary",
            style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 15,
              ),
          ),
          // backgroundColor: Colors.blue,
        ),
        backgroundColor: Colors.grey[300],
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Container(color: Colors.white, child: Timeline_Chart()),
                      Container(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Delivery Address:',
                                style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            if (selectedAddress != null) ...[
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: BorderSide(
                                      color: Colors.grey[300]!, width: 2.0),
                                ),
                                margin: EdgeInsets.all(10),
                                surfaceTintColor: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Text(
                                            '${selectedAddress.full_name}',
                                            style: GoogleFonts.nunito(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 15,
                                            ),
                                         ),
                                          Spacer(),
                                          Expanded(
                                            child: Text(
                                              'Arriving at ${selectedtimeslot}',
                                              style: GoogleFonts.nunito(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        '${selectedAddress.street} ${selectedAddress.area}${selectedAddress.city}, ${selectedAddress.state} - ${selectedAddress.pincode}\nPhone: ${selectedAddress.phone_number}',
                                        style: GoogleFonts.nunito(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                      ),
                                      Divider(),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    address_screen(
                                                      canselect: true,
                                                      serviceID:
                                                          widget.serviceID,
                                                    )),
                                          );
                                        },
                                        child: Text(
                                          'Change Address',
                                          style: GoogleFonts.nunito(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue,
                                            fontSize: 15,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Total Items:',
                                    style: GoogleFonts.nunito(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text('${booking_items.length}',
                                      style: GoogleFonts.nunito(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: booking_items.length,
                              itemBuilder: (context, index) {
                                return customListTile(
                                  leading:
                                      "${APIservice.address}${booking_items[index]['item_image']}"
                                          .toString(),
                                  title: booking_items[index]['item_name']
                                      .toString(),
                                  subtitle:
                                      "Quantity : ${booking_items[index]['item_quantity'].toString()}",
                                  trailing: Text(
                                    "₹ ${booking_items[index]['item_cost'].toStringAsFixed(2)}",
                                    //"₹ ${calculateTotalCost(booking_items[index]['item_quantity'], booking_items[index]['item_cost']).toStringAsFixed(2)}",
                                    style: GoogleFonts.nunito(
                                          color: Colors.black,
                                          fontSize: 15,
                                       ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
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
                                value:
                                    '₹ ${calculateOrderTotal(booking_items).toStringAsFixed(2)}',
                              ),
                              Row_itemCustom(
                                  name: "Promocode", value: 'Promo 18'),
                              Row_itemCustom(
                                name: "Discount",
                                value: '18%',
                                Color: GoogleFonts.nunito(
                                  fontWeight: FontWeight.bold,
                                  color: secondary(),
                                  fontSize: 15,
                                ),
                              ),
                              Row_itemCustom(
                                  name: "Total",
                                  value:
                                      '₹ ${calculateEighteenPercent(calculateOrderTotal(booking_items)).toStringAsFixed(2)}'),
                              Row_itemCustom(name: "Tax", value: '₹ ${tax}'),
                              Row_itemCustom(
                                  name: "Handling Charges",
                                  value: '₹ ${Handling.toStringAsFixed(2)}'),
                              Row_itemCustom(
                                  name: "Delivery Charges",
                                  value: '₹ ${Delivery.toStringAsFixed(2)}'),
                            ]),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Bill",
                                    style: GoogleFonts.nunito(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    '₹  ${totalBill
                                        //calculateBill(calculateOrderTotal(booking_items), tax, Handling, Delivery)
                                        .toStringAsFixed(2)}',
                                      style: GoogleFonts.nunito(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                  )
                                ])
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        color: Colors.white,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Payment Method:',
                                  style: GoogleFonts.nunito(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Divider(),
                              // ListTile(
                              //   title: Text('Debit Card'),
                              //   leading: Radio(
                              //     value: PaymentMethod.DebitCard,
                              //     groupValue: _selectedPaymentMethod,
                              //     onChanged: (PaymentMethod? value) {
                              //       setState(() {
                              //         _selectedPaymentMethod = value!;
                              //       });
                              //     },
                              //   ),
                              // ),
                              Divider(),
                              ListTile(
                                title: Text('UPI',
                                  style: GoogleFonts.nunito(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                                ),
                                leading: Radio(
                                  value: PaymentMethod.UPI,
                                  groupValue: _selectedPaymentMethod,
                                  onChanged: (PaymentMethod? value) {
                                    setState(() {
                                      _selectedPaymentMethod = value!;
                                    });
                                  },
                                ),
                              ),
                              Divider(),
                              ListTile(
                                title: Text('Cash on Delivery',
                                  style: GoogleFonts.nunito(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                                leading: Radio(
                                  value: PaymentMethod.CashOnDelivery,
                                  groupValue: _selectedPaymentMethod,
                                  onChanged: (PaymentMethod? value) {
                                    setState(() {
                                      _selectedPaymentMethod = value!;
                                    });
                                  },
                                ),
                              )
                            ]),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              color: Colors.white,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor:
                      _isButtonDisabled ? Colors.grey : Colors.blueAccent,
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: _isButtonDisabled
                    ? null
                    : () async {
                        if (mounted) {
                          setState(() {
                            _isButtonDisabled = true;
                          });
                        }
                        await Future.delayed(Duration(seconds: 2));

                        if (_selectedPaymentMethod == PaymentMethod.UPI) {
                          _initiatePayment(calculateBill(
                              calculateOrderTotal(booking_items),
                              tax,
                              Handling,
                              Delivery));
                          if (await paymentstatus) {
                            await _saveOrderDetails();
                            _resetAndShowDialog(
                              title: "Payment Success",
                              content:
                                  "Your payment has been successfully processed.",
                            );
                          } else {
                            setState(() {
                              _isButtonDisabled = false;
                            });
                          }
                        } else if (_selectedPaymentMethod ==
                            PaymentMethod.CashOnDelivery) {
                          await _saveOrderDetails();
                          _resetAndShowDialog(
                            title: "Order Placed",
                            content:
                                "Your order has been placed successfully. Please keep the cash ready upon delivery.",
                          );
                        }
                      },
                child: Text(
                  "Place Order",
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
