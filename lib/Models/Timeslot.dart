import 'package:intl/intl.dart';

class Slot {
  final DateTime startTime;
  final DateTime endTime;
  bool isSelected;

  Slot({
    required this.startTime,
    required this.endTime,
    this.isSelected = false,
  });

  factory Slot.fromJson(Map<String, dynamic> json) {
    final DateFormat timeFormat = DateFormat('HH:mm:ss');
    return Slot(
      startTime: timeFormat.parse(json['start_time']),
      endTime: timeFormat.parse(json['end_time']),
    );
  }
}
