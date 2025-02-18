// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDJTLsrcSeeDOoB7VKK8qcdeDDRafRo_I0',
    appId: '1:814074843325:web:9dfdb0a9bfc2c6160f27d4',
    messagingSenderId: '814074843325',
    projectId: 'laundry-app-38179',
    authDomain: 'laundry-app-38179.firebaseapp.com',
    storageBucket: 'laundry-app-38179.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyClPotsZevcMAaCymBK-DBVvAg60q58MH4',
    appId: '1:814074843325:android:8a395ab70cd0bc0f0f27d4',
    messagingSenderId: '814074843325',
    projectId: 'laundry-app-38179',
    storageBucket: 'laundry-app-38179.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBC64ZNCrlA61jCHXi_xkRmKBlO6ioLKeo',
    appId: '1:814074843325:ios:6d0201867212aa360f27d4',
    messagingSenderId: '814074843325',
    projectId: 'laundry-app-38179',
    storageBucket: 'laundry-app-38179.appspot.com',
    iosBundleId: 'com.example.laundryApplication',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBC64ZNCrlA61jCHXi_xkRmKBlO6ioLKeo',
    appId: '1:814074843325:ios:6d0201867212aa360f27d4',
    messagingSenderId: '814074843325',
    projectId: 'laundry-app-38179',
    storageBucket: 'laundry-app-38179.appspot.com',
    iosBundleId: 'com.example.laundryApplication',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDJTLsrcSeeDOoB7VKK8qcdeDDRafRo_I0',
    appId: '1:814074843325:web:bdb2e270694876690f27d4',
    messagingSenderId: '814074843325',
    projectId: 'laundry-app-38179',
    authDomain: 'laundry-app-38179.firebaseapp.com',
    storageBucket: 'laundry-app-38179.appspot.com',
  );
}
