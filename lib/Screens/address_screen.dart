import 'package:flutter/material.dart';
import 'package:freshwavelaundry/Models/address_model.dart';
import 'package:freshwavelaundry/Screens/Time_Slot.dart';
import 'package:freshwavelaundry/Screens/add_address_screen.dart';
import 'package:freshwavelaundry/api_services/user_api.dart';
import 'package:freshwavelaundry/providers/Dateprovider.dart';
import 'package:freshwavelaundry/providers/UserDataProvider.dart';
import 'package:freshwavelaundry/providers/address_provider.dart';
import 'package:freshwavelaundry/ui_helper/util.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class address_screen extends StatefulWidget {
  bool canselect;
  final int? serviceID;
  address_screen({
    Key? key,
    required this.canselect,
    this.serviceID,
  });

  @override
  State<address_screen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<address_screen> {
  int? selectedAddressIndex; // Change to nullable int
  bool isLoading = true;

  Future addressfetch() async {
    final id = await user_api.fetchUserID();
    await Provider.of<address_provider>(context, listen: false).fetchData(id);
  }

  @override
  void initState() {
    super.initState();
    addressfetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Address',
          style: GoogleFonts.nunito(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 25,
        ),
        ),
      ),
      body: Consumer<address_provider>(
        builder: (context, addressProvider, child) {
          List<address_model> address = addressProvider.address;

          // Update isLoading when the address list is fetched
          if (address.isNotEmpty && isLoading) {
            isLoading = false;
          }

          return Container(
            width: double.infinity,
            color: Colors.white,
            child: Column(
              children: [
                InkWell(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddAddressScreen()),
                    );
                    print(result);
                    if (result == true) {
                      final userdata =
                          Provider.of<UserDataProvider>(context, listen: false);
                      final id = userdata.userId;
                      // Refresh data if new address was added
                      await addressProvider.fetchData(id);
                      // await Provider.of<address_provider>(context,
                      //         listen: false)
                      //     .fetchData(id);
                    }
                  },
                  child: Card(
                    elevation: 5,
                    surfaceTintColor: Colors.white,
                    child: ListTile(
                      leading: Icon(color: secondary(), Icons.add),
                      title: Text(
                        'Add New Address',
                        style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 15,
                      ),
                                        ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                address.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                            itemCount: address.length,
                            itemBuilder: (context, index) {
                              return widget.canselect
                                  ? RadioListTile<int>(
                                      value: index,
                                      groupValue: selectedAddressIndex,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedAddressIndex = value;
                                        });
                                        addressProvider.setSelectedAddress(
                                            address[value!]);
                                      },
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            address[index].full_name,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '${address[index].street} ${address[index].area} ${address[index].city} ${address[index].state} - ${address[index].pincode}',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            address[index]
                                                .phone_number
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            address[index].full_name,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '${address[index].street} ${address[index].area} ${address[index].city} ${address[index].state} - ${address[index].pincode}',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            address[index]
                                                .phone_number
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                            }),
                      )
                    : Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 0),
                                  child: Image.asset(
                                    'assets/images/Address.jpg', // Adjust path as necessary
                                    fit: BoxFit
                                        .cover, // Adjust the fit as per your needs
                                    height:
                                        270, // Adjust height as per your image
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Text(
                                    'SAVE YOUR ADDRESSES NOW',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Text(
                                    'Add your home and office addresses and enjoy faster checkout',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.nunito(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                address.isNotEmpty && selectedAddressIndex != null
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: secondary(),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 16),
                            ),
                            onPressed: () {
                              if (selectedAddressIndex != null) {
                                // Handle button press here, e.g., submit selected address
                                Provider.of<DateProvider>(context,
                                        listen: false)
                                    .resetState();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TimeSlotPicker(
                                            serviceID: widget.serviceID,
                                          )),
                                );
                              } else {
                                // Handle case where no address is selected
                                print('No address selected');
                              }
                            },
                            child: Text(
                              'Proceed',
                              style: GoogleFonts.nunito(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 15,
                            ),
                            ),
                          ),
                        ),
                      )
                    : Text(''),
              ],
            ),
          );
        },
      ),
    );
  }
}
