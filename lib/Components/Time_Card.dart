import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:freshwavelaundry/Models/Timeslot.dart';
import 'package:freshwavelaundry/providers/timeprovider.dart';
import 'package:provider/provider.dart';

class TimeSlotSelector extends StatefulWidget {
  @override
  _TimeSlotSelectorState createState() => _TimeSlotSelectorState();
}

class _TimeSlotSelectorState extends State<TimeSlotSelector> {
  List<Slot> timeSlots = [];

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void generateTimeSlots() async {
    timeSlots =
        await Provider.of<TimeSlotProvider>(context, listen: false).getSlots;
  }

  Future<void> _initialize() async {
    final timeSlotProvider =
        Provider.of<TimeSlotProvider>(context, listen: false);
    await timeSlotProvider.fetchSlots(context);
    generateTimeSlots();
  }

  void selectTimeSlot(int selectedIndex) {
    setState(() {
      for (int i = 0; i < timeSlots.length; i++) {
        if (i == selectedIndex) {
          timeSlots[i].isSelected =
              !timeSlots[i].isSelected; // Toggle selected slot
        } else {
          timeSlots[i].isSelected = false; // Deselect other slots
        }
      }
    });
  }

  // String formatTime(DateTime time) {
  //   return DateFormat('h a').format(time); // Format time as 8 AM, 9 PM etc.
  // }

  @override
  Widget build(BuildContext context) {
    return timeSlots.isNotEmpty
        ? GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(16.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
            ),
            itemCount: timeSlots.length,
            itemBuilder: (context, index) {
              Slot slot = timeSlots[index];
              String startTime = TimeSlotProvider().formatTime(slot.startTime);
              String endTime = TimeSlotProvider().formatTime(slot.endTime);

              return GestureDetector(
                onTap: () {
                  selectTimeSlot(index); // Select the tapped slot
                  Slot selectedSlot = timeSlots[index];
                  Provider.of<TimeSlotProvider>(context, listen: false)
                      .setSelectedTimeSlot(selectedSlot);
                },
                child: Chip(
                  backgroundColor:
                      slot.isSelected ? Colors.orange : Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey.shade300, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  label: Text(
                    "$startTime - $endTime",
                    style: TextStyle(
                      color: slot.isSelected ? Colors.white : Colors.black87,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          )
        : Expanded(child: Center(child: Text('No Slots Available')));
  }
}
