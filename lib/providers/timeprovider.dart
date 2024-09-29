import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:freshwavelaundry/Models/Timeslot.dart';
import 'package:freshwavelaundry/api_services/global.dart';
import 'package:freshwavelaundry/providers/Dateprovider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

// Model for a time slot
// class TimeSlot {
//   final startTime;
//   final endTime;

//   TimeSlot({required this.startTime, required this.endTime});
// }

// TimeSlot provider using ChangeNotifier
class TimeSlotProvider extends ChangeNotifier {
  String? _selectedTimeSlot;

  String? get selectedTimeSlot => _selectedTimeSlot;

  List<Slot> _getSlots = [];
  List<Slot> get getSlots => _getSlots;

  String formatTime(DateTime time) {
    return DateFormat('h a').format(time); // Format time as 8 AM, 9 PM etc.
  }

  void setSelectedTimeSlot(Slot slot) {
    _selectedTimeSlot =
        "${formatTime(slot.startTime)} - ${formatTime(slot.endTime)}";
    notifyListeners();
  }

  Future<void> fetchSlots(BuildContext context) async {
    try {
      print("Working");
      DateProvider dateProvider =
          Provider.of<DateProvider>(context, listen: false);
      String selectedDay = dateProvider.selectedDay;
      print(selectedDay);
      // String formattedDay = DateFormat('yyyy-MM-dd').format(selectedDay);
      final url =
          Uri.parse('${APIservice.address}/Timeslot/getTimeSlot/$selectedDay');
      final response = await http.get(url);
      print(url);
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        _getSlots.clear(); // Clear existing slots

        // Assuming the response is an array of time slots
        List<Slot> slots = body.map((item) => Slot.fromJson(item)).toList();
        _getSlots.addAll(slots);

        print('Fetched Slots: $getSlots');
        notifyListeners();
      } else {
        throw Exception('Failed to fetch slots');
      }
    } catch (e) {
      throw Exception('Error fetching slots: $e');
    }
  }
}
