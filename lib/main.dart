import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:freshwavelaundry/Screens/LoginPageScreen.dart';
import 'package:freshwavelaundry/Screens/NotificationScreen.dart';
import 'package:freshwavelaundry/Screens/SettingsScreen.dart';
import 'package:freshwavelaundry/Screens/SplashScreen.dart';
import 'package:freshwavelaundry/Screens/home_main.dart';
import 'package:freshwavelaundry/api_services/FirebaseMessagingApi.dart';
import 'package:freshwavelaundry/firebase_options.dart';
import 'package:freshwavelaundry/providers/Dateprovider.dart';
import 'package:freshwavelaundry/providers/ThemeProvider.dart';
import 'package:freshwavelaundry/providers/UserDataProvider.dart';
import 'package:freshwavelaundry/providers/address_provider.dart';
import 'package:freshwavelaundry/providers/timeprovider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:freshwavelaundry/Models/counter_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final navigatorKey = GlobalKey<NavigatorState>();

// Function to listen to background changes
Future _firebaseBackgroundMessage(RemoteMessage message) async {
  print("background message");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Handle background notification tapped
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      print("message notification ${message.notification!.title}");
      navigatorKey.currentState!.pushNamed("/NotificationScreen",
          arguments: jsonEncode(message.data));
    }
  });

  await PushNotification.localNotiInit();
  await PushNotification.init();
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

  // Handle foreground notification
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("got a message in foreground ");
    if (message.notification != null) {
      // PushNotification.showSimpleNotification(
      //     title: message.notification!.title!,
      //     body: message.notification!.body!,
      //     payload: jsonEncode(message.data));
    }
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const KEYLOGIN = "LOGIN";
  bool _darkModeEnabled = false;
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CounterModel()),
        ChangeNotifierProvider(create: (_) => address_provider()),
        ChangeNotifierProvider(create: (_) => DateProvider()),
        ChangeNotifierProvider(create: (_) => TimeSlotProvider()),
        ChangeNotifierProvider(create: (_) => UserDataProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: FutureBuilder<bool>(
        future: _checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              home: Scaffold(
                body: Center(child: CircularProgressIndicator()),
              ),
            );
          } else {
            final isLoggedIn = snapshot.data ?? false;
            return MaterialApp(
              navigatorKey: navigatorKey,
              initialRoute: '/',
              routes: {
                '/NotificationScreen': (context) => NotificationScreen(),
              },
              debugShowCheckedModeBanner: false,
              title: 'Laundry App',
              theme: ThemeData(
                appBarTheme: const AppBarTheme(
                  iconTheme: IconThemeData(
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.blue,
                ),
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
                useMaterial3: true,
              ),
              darkTheme: ThemeData.dark(),
              themeMode: Provider.of<ThemeProvider>(context).isDarkMode
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: isLoggedIn ? home_main() : Splashscreen(),
            );
          }
        },
      ),
    );
  }

  Future<bool> _checkLoginStatus() async {
    var sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getBool(KEYLOGIN) ?? false;
  }
}
