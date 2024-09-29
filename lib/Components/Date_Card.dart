import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:freshwavelaundry/providers/Dateprovider.dart';
import 'package:freshwavelaundry/providers/timeprovider.dart';
import 'package:provider/provider.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  int selectedIndex = 0;
  int currentIndex = 0;
  DateTime now = DateTime.now();
  late DateTime lastDayOfMonth;
  late DateTime startDayOfMonth;
  List<DateTime> dateList = [];

  @override
  void initState() {
    super.initState();
    lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    startDayOfMonth = DateTime(now.year, now.month, 1);
    currentIndex = now.day - 1;

    // Generate list of dates from currentIndex to last day of month
    dateList = List.generate(
      15,
      (index) => startDayOfMonth.add(Duration(days: currentIndex + index)),
    );
  }

  void printSelectedDate(DateTime selectedDate) {
    print("Selected date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}");
  }

  void handleDateSelection(int index) async {
    setState(() {
      selectedIndex = index;
      currentIndex = index;
    });

    final dateProvider = Provider.of<DateProvider>(context, listen: false);
    print(dateList[index]);
    dateProvider.setSelectedDate(dateList[index]);
    final timeSlotProvider =
        Provider.of<TimeSlotProvider>(context, listen: false);
    await timeSlotProvider.fetchSlots(context);
    print(timeSlotProvider.getSlots);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const ClampingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              dateList.length,
              (index) {
                final currentDate = dateList[index];
                final dayName = DateFormat('E').format(currentDate);
                final formattedDate = DateFormat('dd MMM').format(currentDate);

                return Padding(
                  padding: EdgeInsets.only(
                      left: index == 0 ? 16.0 : 0.0, right: 16.0),
                  child: GestureDetector(
                    onTap: () => handleDateSelection(index),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 30.0,
                          width: 30.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: selectedIndex == index
                                ? Colors.orange
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(44.0),
                          ),
                          child: Text(
                            dayName.substring(0, 1),
                            style: TextStyle(
                              fontSize: 14.0,
                              color: selectedIndex == index
                                  ? Colors.white
                                  : Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          "${formattedDate}",
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Container(
                          height: 2.0,
                          width: 28.0,
                          color: selectedIndex == index
                              ? Colors.orange
                              : Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
