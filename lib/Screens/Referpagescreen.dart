import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:freshwavelaundry/Screens/home_main.dart';

class Referpagescreen extends StatefulWidget {
  const Referpagescreen({super.key});

  @override
  State<Referpagescreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Referpagescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        color: Color.fromRGBO(241, 241, 242, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16.0),
              child: Text(
                '🥳  Exciting News from Freshwave!',
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 3, 3, 3),
                  fontSize: 20,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Now, enjoy even faster service, real-time order tracking, and exclusive discounts for our loyal customers!',
                style: GoogleFonts.nunito(
                  color: Color.fromARGB(255, 3, 3, 3),
                  fontSize: 15,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Refer our services or App to your friends and family on WhatsApp or any other platform.',
                style: GoogleFonts.nunito(
                  color: Color.fromARGB(255, 3, 3, 3),
                  fontSize: 15,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Enjoying our services? Make sure your friends and family ',
                style: GoogleFonts.nunito(
                  color: Color.fromARGB(255, 3, 3, 3),
                  fontSize: 15,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Here's how it works:",
                style: GoogleFonts.nunito(
                  color: Color.fromARGB(255, 3, 3, 3),
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '✅  Share the given link with your network',
                style: GoogleFonts.nunito(
                  color: Color.fromARGB(255, 3, 3, 3),
                  fontSize: 15,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 14,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                ' 🎁  Give the laundry free weekends to your family and friends',
                style: GoogleFonts.nunito(
                  color: Color.fromARGB(255, 3, 3, 3),
                  fontSize: 15,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 14,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                ' 🙏 Thank you for being an amazing part of our family',
                style: GoogleFonts.nunito(
                  color: Color.fromARGB(255, 3, 3, 3),
                  fontSize: 15,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 14,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.5),
              child: Text(
                'The Freshwave\ Team❤️',
                style: GoogleFonts.nunito(
                  color: Color.fromARGB(255, 3, 3, 3),
                  fontSize: 15,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: SizedBox(
                width: double.infinity, // Make button full width
                child: ElevatedButton(
                  onPressed: () async {
                    await Share.share(
                        '🎉 Youve been invited! Join us and unlock exclusive benefits. Sign up now using your invitation link!');
                  },
                  child: Text(
                    'Invite your Friend',
                    style: GoogleFonts.nunito(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    textStyle: GoogleFonts.nunito(
                        color: Color.fromARGB(255, 3, 3, 3),
                        fontSize: 15,
                      ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
