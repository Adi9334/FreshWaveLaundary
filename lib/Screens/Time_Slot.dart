import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:freshwavelaundry/Components/Time_Card.dart';
import 'package:freshwavelaundry/Components/Date_Card.dart';
import 'package:freshwavelaundry/Models/service_model.dart';
import 'package:freshwavelaundry/Screens/myorder_summary_screen.dart';
import 'package:freshwavelaundry/providers/timeprovider.dart';
import 'package:freshwavelaundry/ui_helper/util.dart';
import 'package:provider/provider.dart';

class TimeSlotPicker extends StatefulWidget {
  final serviceID;
  TimeSlotPicker({
    Key? key,
    required this.serviceID,
  });

  @override
  State<TimeSlotPicker> createState() => _TimeSlotState();
}

class _TimeSlotState extends State<TimeSlotPicker> {
  @override
  Widget build(BuildContext context) {
    TimeSlotProvider dataProvider = Provider.of<TimeSlotProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PickUp Slot",
          style: GoogleFonts.nunito(
          fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 25,
            ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  DatePicker(),
                  TimeSlotSelector(),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: secondary(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => myorder_summary_screen(
                              serviceID: widget.serviceID,
                            )));
              },
              child: Text(
                'Proceed to Pay',
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
