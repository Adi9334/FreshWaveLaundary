import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:freshwavelaundry/api_services/global.dart';
import 'package:freshwavelaundry/api_services/user_api.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class feedbackcustom extends StatefulWidget {
  feedbackcustom({super.key});
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<feedbackcustom> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();
  int _rating = 0;
  String _feedback = '';

  Future<void> _submitFeedback() async {
    try {
      final id = await user_api.fetchUserID();
      // Prepare feedback data
      final feedbackData = {
        'user_id': id,
        'user_name': _nameController.text,
        'user_phonenumber': _phonenumberController.text,
        'user_rating': _rating,
        'user_review': _feedback,
        'created_by': 'user',
        'is_active': 1
      };

      // Send POST request to save feedback
      final response = await http.post(
        Uri.parse('${APIservice.address}/UserReview/addreview'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(feedbackData),
      );

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                "Feedback Submitted",
                style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              content: Text(
                "Your feedback has been submitted successfully.",
                style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    "OK",
                    style: GoogleFonts.nunito(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    Navigator.pop(context, true); // Close the previous screen
                  },
                ),
              ],
            );
          },
        );
      } else {
        // Handle error
        print('Failed to submit feedback');
      }
    } catch (e) {
      // Handle error
      print('Error submitting feedback: $e');
    }
  }

  Widget _buildStar(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _rating = index + 1; // Store 1-based rating for simplicity
        });
      },
      child: Icon(
        index < _rating ? Icons.star : Icons.star_border,
        color: Colors.amber,
        size: 40.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Apply circular corners to the upper part of the image
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                  child: Image.asset(
                    'assets/images/feedback.png', // Path to your image
                    height: 130.0, // Adjust height as needed
                    fit: BoxFit.cover, // Adjust fit based on your requirement
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Name TextField with blue border and orange focus
                          TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: 'Name (optional)',
                              labelStyle: GoogleFonts.nunito(
                                color: Colors.brown,
                                fontSize: 15,
                              ),
                              prefixIcon: Icon(Icons.person, color: Colors.brown,),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.brown),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.orange),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),

                          // Phone Number TextField with blue border and orange focus
                          TextField(
                            controller: _phonenumberController,
                            decoration: InputDecoration(
                              labelText: 'Phone Number (optional)',
                              labelStyle: GoogleFonts.nunito(
                                color: Colors.brown,
                                fontSize: 15,
                              ),
                              prefixIcon: Icon(Icons.phone, color: Colors.brown,),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.brown),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.orange),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),

                          Text(
                            'Rate the app:',
                            style: GoogleFonts.nunito(
                              color: Colors.brown,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(5, (index) => _buildStar(index)),
                          ),
                          SizedBox(height: 20.0),

                          // Feedback TextField with blue border and orange focus
                          TextField(
                            onChanged: (value) {
                              setState(() {
                                _feedback = value;
                              });
                            },
                            maxLines: 4,
                            decoration: InputDecoration(
                              labelText: 'Feedback',
                              labelStyle: GoogleFonts.nunito(
                                color: Colors.brown,
                                fontSize: 15,
                              ),
                              prefixIcon: Icon(Icons.feedback, color: Colors.brown,),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.brown),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.orange),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),

                          // Submit button inside the container with fields
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                _submitFeedback();
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10), // Set rounded corners
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    Colors.orange), // Set blue color
                              ),
                              child: Text(
                                'Submit',
                                style: GoogleFonts.nunito(
                                  color: Colors.white, // White text color
                                  fontWeight: FontWeight.bold, // Making text bold
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
