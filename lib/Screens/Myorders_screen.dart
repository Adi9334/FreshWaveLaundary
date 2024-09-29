import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freshwavelaundry/Components/Myorder_card.dart';
import 'package:freshwavelaundry/Models/orderlist_model.dart';
import 'package:freshwavelaundry/Screens/home_main.dart';
import 'package:freshwavelaundry/api_services/order_api.dart';
import 'package:freshwavelaundry/api_services/user_api.dart';
import 'package:freshwavelaundry/providers/UserDataProvider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Myorder_screen extends StatefulWidget {
  const Myorder_screen({super.key});

  @override
  State<Myorder_screen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Myorder_screen> {
  List<orderlist_model> orderDataList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fecthData(); 
  }

  Future<void> fecthData() async {
    //final userdata = Provider.of<UserDataProvider>(context, listen: false);
    final id = await user_api.fetchUserID();
    print(id);
    List<orderlist_model> orderData = await order_api.fetchorders(id);
    if (mounted) {
      setState(() {
        orderDataList = orderData;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading ? Center(
        child:CircularProgressIndicator(),
      ):
      orderDataList.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromARGB(
                              255, 171, 224, 255), // Light blue shade (top)
                          Colors.white, // White (bottom)
                        ],
                        stops: [0.3, 1.0],
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 51, 217, 242)
                                      .withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.search, // Changed icon to search
                              size: 100,
                              color: const Color.fromARGB(255, 72, 185, 241),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'No order has been placed yet.',
                            style: GoogleFonts.nunito(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 14, 14, 14),
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Looks like you haven't made your order yet.",
                            style: GoogleFonts.nunito(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => home_main()));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        // Rectangle button shape
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      backgroundColor: Color.fromARGB(
                          255, 84, 197, 253), // Darker button color
                      padding:
                          EdgeInsets.symmetric(horizontal: 80, vertical: 18),
                    ),
                    child: Text(
                      'Back To Menu',
                      style: GoogleFonts.nunito(
                        color: Color.fromARGB(255, 14, 14, 14),
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: orderDataList.length,
              itemBuilder: (context, index) {
                return Myorder_card(
                  order: orderDataList[index],
                );
              },
            ),
    );
  }
}
