import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> payload = {};
    final data = ModalRoute.of(context)!.settings.arguments;

    if (data is String) {
      payload = jsonDecode(data);
    } else if (data is RemoteMessage) {
      payload = data.data;
    }
    print(payload);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 25,
              ),
        ),
      ),
      body: payload.isEmpty
          ? _buildNoNotificationsWidget()
          : ListView.builder(
              itemCount: 1, // Assuming single notification for simplicity
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  child: ListTile(
                    leading: Icon(
                      Icons.notifications,
                      size: 40,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(
                      payload['text'] ?? 'No Title',
                      style: GoogleFonts.nunito(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18,
                            ),
                    ),
                    subtitle: Text(
                      payload['important'] ?? 'No Body',
                      style: GoogleFonts.nunito(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 15,
                            ),
                    ),
                    trailing: Text(
                      _formatDateTime(DateTime
                          .now()), // Replace with actual time if available
                      style: GoogleFonts.nunito(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildNoNotificationsWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/No_Notification.png',
            width: 250,
            height: 250,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 20),
          Text(
            'No notifications yet',
            style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20,
                ),
          ),
          SizedBox(height: 10),
          Text(
            'Check back later for updates',
            style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 15,
                ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
}
