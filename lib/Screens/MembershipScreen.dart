import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MembershipScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Membership Plans',
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 20),
              child: Text(
                'Choose your membership plan',
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: MembershipOption(
                title: 'Basic',
                price: '\₹79/month',
                description: 'Up to 10 loads per month',
                backgroundColor: const Color.fromARGB(
                    255, 121, 225, 124), // Background color for Basic plan
                buttonColor: Colors.blue, // Button color for Basic plan
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: MembershipOption(
                title: 'Standard',
                price: '\₹149/month',
                description: 'Up to 20 loads per month',
                backgroundColor: const Color.fromARGB(
                    255, 233, 169, 74), // Background color for Standard plan
                buttonColor: Colors.blue, // Button color for Standard plan
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: MembershipOption(
                title: 'Premium',
                price: '\₹499/month',
                description: 'Unlimited loads per month',
                backgroundColor: const Color.fromARGB(
                    255, 91, 155, 208), // Background color for Premium plan
                buttonColor: Colors.blue, // Button color for Premium plan
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MembershipOption extends StatelessWidget {
  final String title;
  final String price;
  final String description;
  final Color backgroundColor;
  final Color buttonColor;

  const MembershipOption({
    required this.title,
    required this.price,
    required this.description,
    required this.backgroundColor,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: backgroundColor, // Background color for the entire option
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18,
              ),
          ),
          SizedBox(height: 8.0),
          Text(
            price,
            style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 16,
              ),
          ),
          SizedBox(height: 8.0),
          Text(
            description,
            style: GoogleFonts.nunito(
                color: Colors.black,
                fontSize: 14,
              ),
          ),
          SizedBox(height: 16.0), // Increased spacing for better UI
          ElevatedButton(
            onPressed: () {
              // Add functionality here to subscribe to the selected plan
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Subscription',
                      style:GoogleFonts.nunito(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    content: Text('You have subscribed to the $title plan.',
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text('OK',
                          style: GoogleFonts.nunito(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 38, 152, 246),
            ),
            child: Text(
              'Select',
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
