import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateProvider extends ChangeNotifier {
  late DateTime _selectedDate;
  late String _selectedDay;

  // Constructor to initialize with the present day
  // DateProvider() {
  //   _selectedDate = DateTime.now();
  //   _selectedDay =
  //       DateFormat('EEEE').format(_selectedDate); // Format: Mon, Tue, etc.
  // }

  DateTime get selectedDate => _selectedDate;
  String get selectedDay => _selectedDay;

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    _selectedDay = DateFormat('EEEE').format(_selectedDate);
    notifyListeners();
    print(_selectedDay);
  }

  void resetState() {
    _selectedDate = DateTime.now();
    _selectedDay = DateFormat('EEEE').format(_selectedDate);
    notifyListeners();
  }
}
