import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';
import 'package:freshwavelaundry/Screens/LoginPageScreen.dart';
import 'package:google_fonts/google_fonts.dart';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  final PageController _pageController = PageController();

  final List<OnBoardModel> _onBoardData = [
    const OnBoardModel(
      title: "Professional Laundry Services",
      description: "High-quality cleaning for your clothes",
      imgUrl: 'assets/images/flutterphoto1.png',
    ),
    const OnBoardModel(
      title: "Convenient Pickup",
      description: "Choose a pickup time that suits your schedule.",
      imgUrl: 'assets/images/pickup.png',
    ),
    const OnBoardModel(
      title: "Bulk Services",
      description:
          "Get your bulk laundry done efficiently with our reliable services.",
      imgUrl: 'assets/images/washing4.png',
    ),
    const OnBoardModel(
      title: "Loading Your Laundry Preferences",
      description:
          "We’re getting everything set up based on your preferences. Hang tight for a fresh start!",
      imgUrl: 'assets/images/Summer.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoard(
        imageWidth: double.infinity,
        imageHeight: double.infinity,
        pageController: _pageController,
        onSkip: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPageScreen()),
          );
        },
        onDone: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPageScreen()),
          );
        },
        onBoardData: _onBoardData,
        titleStyles: GoogleFonts.nunito(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 25,
            ),
        descriptionStyles: GoogleFonts.nunito(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            color: Colors.grey.shade600,
            ),
        pageIndicatorStyle: const PageIndicatorStyle(
          width: 100,
          inactiveColor: Colors.grey,
          activeColor: Colors.blueAccent,
          inactiveSize: Size(8, 8),
          activeSize: Size(12, 12),
        ),
        skipButton: TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPageScreen()),
            );
          },
          child: Text(
            "Skip",
            style: GoogleFonts.nunito(
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
              fontSize: 15,
            ),
          ),
        ),
        nextButton: OnBoardConsumer(
          builder: (context, ref, child) {
            final state = ref.watch(onBoardStateProvider);
            return InkWell(
              onTap: () => _onNextTap(state),
              child: Container(
                width: 230,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [Colors.blueAccent, Colors.lightBlueAccent],
                  ),
                ),
                child: Text(
                  state.isLastPage ? "Done" : "Next",
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onNextTap(OnBoardState onBoardState) {
    if (!onBoardState.isLastPage) {
      _pageController.animateToPage(
        onBoardState.page + 1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutSine,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPageScreen()),
      );
    }
  }
}
