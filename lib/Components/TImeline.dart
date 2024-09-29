import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Timeline_Chart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTimelineTile("Address", true),
              _buildTimelineConnector(),
              _buildTimelineTile("Order Summary", true),
              _buildTimelineConnector(),
              _buildTimelineTile("Payment", false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineTile(String title, bool isActive) {
    return Column(
      children: [
        CircleAvatar(
          radius: 10,
          backgroundColor: isActive ? Colors.blue : Colors.grey,
          child: Icon(
            Icons.check,
            size: 12,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 10,
            color: isActive ? Colors.blue : Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineConnector() {
    return Expanded(
      child: Container(
        height: 1,
        color: Colors.grey,
      ),
    );
  }
}
