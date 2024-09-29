import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:freshwavelaundry/api_services/global.dart';
import 'package:freshwavelaundry/api_services/user_api.dart';
import 'package:freshwavelaundry/providers/UserDataProvider.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  String? _selectedPincode;
  List<String> _pincodeList = [];

  @override
  void initState() {
    super.initState();
    _fetchPincodes();
  }

  Future<void> _fetchPincodes() async {
    final response = await http.get(
      Uri.parse('${APIservice.address}/Pincode/allPincode'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        // Assuming each object in the response has a "pincode" field
        _pincodeList = data.map((item) => item['pincode'].toString()).toList();
      });
    } else {
      print(response.statusCode);
      // Handle error
      print('Failed to fetch pincodes');
    }
  }

  Future<void> _saveAddress(id) async {
    if (_formKey.currentState!.validate()) {
      // Collect address data
      final addressData = {
        'user_id': id,
        'full_name': _fullNameController.text,
        'phone_number': _phoneNumberController.text,
        'state': _stateController.text,
        'city': _cityController.text,
        'street': _streetController.text,
        'pincode': _selectedPincode,
        'area': _areaController.text,
        'created_by': 'admin',
        'is_active': 'true'
      };

      // Send POST request to save address
      final response = await http.post(
        Uri.parse('${APIservice.address}/Address/addAddress'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(addressData),
      );

      if (response.statusCode == 200) {
        // Address saved successfully
        Navigator.pop(context, true);
      } else {
        // Handle error
        print('Failed to save address');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Address',
          style: GoogleFonts.nunito(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 25,
        ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _fullNameController,
                decoration: InputDecoration(labelText: 'Full Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _stateController,
                      decoration: InputDecoration(labelText: 'State'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your state';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _cityController,
                      decoration: InputDecoration(labelText: 'City'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your city';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _streetController,
                      decoration: InputDecoration(labelText: 'Street'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your street';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedPincode,
                      items: _pincodeList.map((pincode) {
                        return DropdownMenuItem(
                          value: pincode,
                          child: Text(pincode),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedPincode = value;
                        });
                      },
                      decoration: InputDecoration(labelText: 'Pincode'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select your pincode';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _areaController,
                decoration: InputDecoration(labelText: 'Area'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your area';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final id = await user_api.fetchUserID();
                  _saveAddress(id);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent.shade400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text('Save Address',
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
    );
  }
}
