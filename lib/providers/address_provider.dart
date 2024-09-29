import 'package:flutter/material.dart';
import 'package:freshwavelaundry/Models/address_model.dart';
import 'package:freshwavelaundry/api_services/address_api.dart';

class address_provider with ChangeNotifier {
  List<address_model> _address = [];
  address_model? _selectedAddress;
  List<address_model> get address => _address;
  address_model? get selectedAddress => _selectedAddress;
  Future<void> fetchData(id) async {
    try {
      List<address_model> addressData = await address_api.fetchaddress(id);
      _address = addressData;
      notifyListeners();
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void setSelectedAddress(address_model address) {
    _selectedAddress = address;
    notifyListeners();
  }

  void resetState() {
    _address = [];
    notifyListeners();
  }
}
