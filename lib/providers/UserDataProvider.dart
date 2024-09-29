import 'package:flutter/material.dart';

class UserDataProvider with ChangeNotifier {
  late String _referenceId = '';
  late String _userId = '';

  String get referenceId => _referenceId;
  String get userId => _userId;

  void setReferenceId(String referenceId) {
    _referenceId = referenceId;
    notifyListeners();
  }

  void setUserId(String userId) {
    _userId = userId;
    notifyListeners();
  }

  void clearData() {
    _referenceId = '';
    _userId = '';
    notifyListeners();
  }
}
