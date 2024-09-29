import 'package:flutter/material.dart';

class ChatBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      height: 400.0, // Adjust the height as needed
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        children: [
          Text(
            'Chat with Us',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          Divider(),
          Expanded(
            child: Card(
              child: ListView(
                children: [
                  // Add chat messages here
                  Card(
                    surfaceTintColor: Colors.white,

                    child: Row(
                      children: [
                        Icon(Icons.person_2_outlined),
                        SizedBox(width: 5,),
                        Text('Hello! How can we help you today?'),
                      ],
                    ))
                    
                    ,
                ],
              ),
            ),
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Type your message',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              
              ),
            ),
          ),
        ],
      ),
    );
  }
}
