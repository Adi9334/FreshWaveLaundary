import 'package:flutter/material.dart';
import 'package:freshwavelaundry/Components/customListTile.dart';
import 'package:freshwavelaundry/Models/counter_model.dart';
import 'package:freshwavelaundry/Models/item_model.dart';
import 'package:freshwavelaundry/Screens/address_screen.dart';
import 'package:freshwavelaundry/api_services/booking_item_api.dart';
import 'package:freshwavelaundry/api_services/global.dart';
import 'package:freshwavelaundry/ui_helper/util.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BookingItemScreen extends StatefulWidget {
  final int serviceID;
  final String serviceName;

  const BookingItemScreen({
    Key? key,
    required this.serviceID,
    required this.serviceName,
  }) : super(key: key);

  @override
  State<BookingItemScreen> createState() => _BookingItemScreenState();
}

class _BookingItemScreenState extends State<BookingItemScreen> {
  // List<Map<String, dynamic>> itemlist = [];
  List<Map<String, dynamic>> filtereditemlist = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      // List<item_model> itemData = await item_api.fetchitems();
      final itemlist = await context.read<CounterModel>().generateList();
      setState(() {
        // this.itemlist = itemlist;
        isLoading = false; // Data fetched, stop loading
      });
    } catch (e) {
      print('Error fetching data: $e');
      // Handle error (show error message or retry mechanism)
      if (mounted) {
        setState(() {
          isLoading = false; // Stop loading even if there's an error
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final counter = context.watch<CounterModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.serviceName,
          style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 25,
              ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loader if loading
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    onChanged: (value) {
                      List<Map<String, dynamic>> filteredData = counter
                          .booking_items
                          .where((element) => element['item_name']
                              .toString()
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                      print(filteredData);
                      setState(() {
                        filtereditemlist = filteredData;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      hintText: 'Search Item',
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: Icon(Icons.mic),
                      border: OutlineInputBorder(borderSide: BorderSide()),
                      hintStyle: GoogleFonts.nunito(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 15,
                    ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 10),
                  child: Text(
                    "Add Item Quantity",
                    style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filtereditemlist.isNotEmpty
                        ? filtereditemlist.length
                        : counter.booking_items.length,
                    itemBuilder: (context, index) {
                      print(filtereditemlist);
                      final item = filtereditemlist.isNotEmpty
                          ? filtereditemlist[index]
                          : counter.booking_items[index];
                      final actualIndex = counter.booking_items.indexOf(item);

                      return customListTile(
                        leading: "${APIservice.address}${item['item_image']}",
                        title: item['item_name'],
                        subtitle:
                            '₹${item['item_price']}/pc ${item['cost'] != 0 ? '\n Price : ₹' + item['cost'].round().toString() : ''} ',
                        trailing: CounterButtons(
                            item_price:
                                double.parse(item['item_price'].toString()),
                            index: actualIndex), // Pass item and index
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(),
                        backgroundColor: secondary(),
                      ),
                      onPressed: counter.calculateTotalCost().round() > 0
                          ? () {
                              counter.addBookingItems();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => address_screen(
                                          canselect: true,
                                          serviceID: widget.serviceID,
                                        )),
                              );
                            }
                          : null,
                      child: Row(
                        children: [
                          Text(
                            "Proceed",
                            style: GoogleFonts.nunito(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          Spacer(),
                          counter.calculateTotalCost().round() > 0
                              ? Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        counter.calculateTotalCost().round() > 0
                                            ? MainAxisAlignment.start
                                            : MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Total Amount :₹${counter.calculateTotalCost().round()}',
                                        style: GoogleFonts.nunito(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                      ),
                                    ],
                                  ),
                                )
                              : Text('')
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class CounterButtons extends StatefulWidget {
  final double item_price;
  final int index; // Index in itemlist

  CounterButtons({required this.item_price, required this.index});

  @override
  _CounterButtonsState createState() => _CounterButtonsState();
}

class _CounterButtonsState extends State<CounterButtons> {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<CounterModel>(context);
    // print(widget.index);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            counter.decrement(widget.index,
                widget.item_price); // Decrement based on index in itemlist
          },
          icon: Icon(Icons.remove),
        ),
        Text('${counter.booking_items[widget.index]["quantity"]}'),
        IconButton(
          onPressed: () {
            counter.increment(widget.index,
                widget.item_price); // Increment based on index in itemlist
          },
          icon: Icon(Icons.add),
        ),
      ],
    );
  }
}
