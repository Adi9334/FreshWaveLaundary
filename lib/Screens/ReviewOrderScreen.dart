import 'package:flutter/material.dart';
import 'package:freshwavelaundry/ui_helper/util.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewOrderScreen extends StatefulWidget {
  final String orderId;
  final String deliveryDate;

  const ReviewOrderScreen({
    Key? key,
    required this.orderId,
    required this.deliveryDate,
  }) : super(key: key);

  @override
  _ReviewOrderScreenState createState() => _ReviewOrderScreenState();
}

class _ReviewOrderScreenState extends State<ReviewOrderScreen> {
  int? _selectedRating;
  final TextEditingController _feedbackController = TextEditingController();

  void _submitReview() {
    if (_selectedRating != null) {
      // Handle review submission logic here
      print('Order ID: ${widget.orderId}');
      print('Delivery Date: ${widget.deliveryDate}');
      print('Rating: $_selectedRating');
      print('Feedback: ${_feedbackController.text}');

      // Clear feedback after submission
      _feedbackController.clear();

      // Show a confirmation message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Review submitted successfully!', style: GoogleFonts.nunito(
      color: Colors.black,
      fontSize: 15,
    ),)),
      );
      Navigator.pop(context);
    } else {
      // Show an error message if rating is not selected
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a rating.', style: GoogleFonts.nunito(
      color: Colors.black,
      fontSize: 15,
    ),)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Review Order',
          style: GoogleFonts.nunito(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 25,
            ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Details',
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('Order ID: ${widget.orderId}', style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontSize: 15,
                        ),),
                      Text('Delivery Date: ${widget.deliveryDate}', style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontSize: 15,
                        ),),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Rate our service:',
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < (_selectedRating ?? 0)
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.amber,
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        _selectedRating = index + 1;
                      });
                    },
                  );
                }),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _feedbackController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Leave a feedback',
                  labelStyle: GoogleFonts.nunito(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                  hintText: 'Share your experience...',
                  hintStyle: GoogleFonts.nunito(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12),
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitReview,
                  child: Text(
                    'Submit Review',
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18,
                        ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
