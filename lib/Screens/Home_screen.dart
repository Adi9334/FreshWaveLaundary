import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:freshwavelaundry/Components/Chat_box.dart';
import 'package:freshwavelaundry/Components/CustomRefral.dart';
import 'package:freshwavelaundry/Components/ServicecardSkeleton.dart';
import 'package:freshwavelaundry/Components/Skeleton.dart';
import 'package:freshwavelaundry/Models/AppBannerModel.dart';
import 'package:freshwavelaundry/Models/service_model.dart';
import 'package:freshwavelaundry/Screens/Booking_item_screen.dart';
import 'package:freshwavelaundry/Screens/CouponScreen.dart';
import 'package:freshwavelaundry/Screens/ExploreScreen.dart';
import 'package:freshwavelaundry/Screens/LoginPageScreen.dart';
import 'package:freshwavelaundry/api_services/Service_api.dart';
import 'package:freshwavelaundry/api_services/global.dart';
import 'package:freshwavelaundry/api_services/user_api.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Home_screen extends StatefulWidget {
  const Home_screen({Key? key}) : super(key: key);

  @override
  State<Home_screen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home_screen> {
  late List<Service> _services = [];
  late List<AppBanner> _appBanner = [];
  List<Map<String, String>> imageList = [];
  final CarouselSliderController carouselController =
      CarouselSliderController();
  int currentIndex = 0;
  bool _isLoading = true;
  String username = '';
  Map<int, bool> _hoverStates = {};

  @override
  void initState() {
    super.initState();
    // Initialize _hoverStates with false for each item
    _initializeHoverStates();
    _fetchServices();
    _fetchBanner();
  }

  void _initializeHoverStates() {
    for (int i = 0; i < _services.length; i++) {
      _hoverStates[i] = false;
    }
  }

  @override
  /*void initState() {
    super.initState();
    _fetchServices();
    _fetchBanner();
  }*/

  Future<void> _fetchServices() async {
    try {
      List<Service> services = await fetchData();
      setState(() {
        _services = services;
        _isLoading = false;
      });
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      username = sharedPref.getString('username')!;
    } catch (error) {
      print('Error fetching services: $error');
    }
  }

  Future<void> _fetchBanner() async {
    try {
      List<AppBanner> appBanner = await fetchBanner();
      setState(() {
        _appBanner = appBanner;
        imageList = _appBanner.map((banner) {
          return {
            "id": "${banner.id}",
            "image-path": '${APIservice.address}${banner.bannerImage}',
          };
        }).toList();
        //_isLoading = false;
      });
    } catch (error) {
      print('Error fetching services: $error');
    }
  }

  void _openChatBox() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ChatBox();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: screenHeight,
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue,
                      Colors.white
                    ], // Replace with your gradient colors
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, bottom: 3, top: 10),
                      child: Text(
                        'Welcome $username !!',
                        
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w900, // Adjust font weight as needed
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 10),
                      child: Text(
                        'Order Fast and Save Time',
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600, // Adjust font weight as needed
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    // Carousel Slider with Padding
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: _appBanner.isEmpty
                          ? Container(
                              height: 190,
                              child: Skeleton(
                                  height: double.infinity,
                                  width: double.infinity),
                            )
                          : Stack(
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: CarouselSlider(
                                    items: imageList.map((item) {
                                      return Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            height: double.infinity,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 1,
                                                  blurRadius: 5,
                                                  offset: Offset(0, 3),
                                                ),
                                              ],
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(
                                                  20.0), // Apply same borderRadius
                                              child: CachedNetworkImage(
                                                imageUrl: item['image-path']!,
                                                fit: BoxFit.fill,
                                                placeholder: (context, url) =>
                                                    Image.asset(
                                                        height: 50,
                                                        width: 120,
                                                        fit: BoxFit.fill,
                                                        "assets/images/placeholder.png"),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList(),
                                    carouselController: carouselController,
                                    options: CarouselOptions(
                                      scrollPhysics:
                                          const BouncingScrollPhysics(),
                                      autoPlay: true,
                                      aspectRatio: 2,
                                      viewportFraction: 0.85,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          currentIndex = index;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: imageList.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () =>
                              carouselController.animateToPage(entry.key),
                          child: Container(
                            width: currentIndex == entry.key ? 20 : 13,
                            height: 3.0,
                            margin: const EdgeInsets.symmetric(horizontal: 3.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: currentIndex == entry.key
                                  ? Color.fromARGB(255, 5, 68, 121)
                                  : Colors.grey,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16, bottom: 10),
                    child: Text(
                      'Services',
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w900, // Adjust font weight as needed
                          color: Colors.black,
                          fontSize: 20,
                        ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: _isLoading
                        ? SizedBox(
                            height: 100,
                            // Adjust height to match your items
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Container(
                                    width: 110,
                                    child: Column(children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          height: 50,
                                          child: ServiceCardSkeleton(),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 20,
                                            child: ServiceCardSkeleton(),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                );
                              },
                            ),
                          )
                        : SizedBox(
                            height: 100, // Adjust height to match your items
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _services.length,
                              itemBuilder: (context, index) {
                                Service service = _services[index];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: GestureDetector(
                                    onTap: () async {
                                      var UserId = await user_api.fetchUserID();
                                      print(UserId);
                                      if (UserId == "0") {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Login Required",
                                              style: GoogleFonts.nunito( // Adjust font weight as needed
                                                color: Colors.black,
                                                fontSize: 15,
                                              ),
                                              ),
                                              content: Text(
                                                  "Please log in to use our services.",
                                                  style: GoogleFonts.nunito( // Adjust font weight as needed
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text("Cancel",
                                                  style: GoogleFonts.nunito( // Adjust font weight as needed
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text("Login",
                                                  style: GoogleFonts.nunito( // Adjust font weight as needed
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                  ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            LoginPageScreen(),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                BookingItemScreen(
                                              serviceID: service.id,
                                              serviceName: service.serviceName,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      onEnter: (_) {
                                        setState(() {
                                          _hoverStates[index] = true;
                                        });
                                      },
                                      onExit: (_) {
                                        setState(() {
                                          _hoverStates[index] = false;
                                        });
                                      },
                                      child: Container(
                                        width:
                                            110, // Adjust width to your needs
                                        decoration: BoxDecoration(
                                          color: _hoverStates[index] == true
                                              ? Colors.yellow
                                              : Colors.white,
                                          border: Border.all(
                                              width: 1,
                                              color: Colors.grey.shade300),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            10)),
                                                child: SizedBox(
                                                  height: 50,
                                                  child: Image.network(
                                                      "${APIservice.address}${service.serviceImage}"),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      service.serviceName,
                                                      style: GoogleFonts.nunito(
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: screenHeight * 0.3,
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 8), // Adjust padding as needed
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.blue
                    ], // Example gradient colors
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(
                      10.0), // Optional: round the corners
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 8.0),
                        child: ExploreCard(
                          title: 'Special Offer',
                          description: 'Get 10% off on your first order!',
                          imageUrl: 'assets/images/cashback.png',
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CouponScreen()),
                        );
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Color(0xFF0F4196),
                            ),
                            width:
                                100, // Set a fixed width for better alignment
                            height: 180,
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'See All',
                                  style: GoogleFonts.nunito(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _openChatBox,
      //   child: Icon(Icons.message, color: Colors.white, size: 20),
      //   backgroundColor: Colors.blue,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(30),
      //   ),
      // ),
    );
  }
}
