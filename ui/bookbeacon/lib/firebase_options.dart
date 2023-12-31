// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyC0oozQllmfdQr_vCGF01hBLkUGE3RdmSc',
    appId: '1:385222238446:web:4e9e859e3aa2cb9cd653ff',
    messagingSenderId: '385222238446',
    projectId: 'abis-bookbeacon',
    authDomain: 'abis-bookbeacon.firebaseapp.com',
    storageBucket: 'abis-bookbeacon.appspot.com',
    measurementId: 'G-B6SL6KTK54',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDY0RMhxqAAkxHH91RHgbY4xKzjYjc_UU8',
    appId: '1:385222238446:android:be6111bb5dab2dd1d653ff',
    messagingSenderId: '385222238446',
    projectId: 'abis-bookbeacon',
    storageBucket: 'abis-bookbeacon.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDpofI-BSrs6B0gy2kPNa1v-RLwwJGt74E',
    appId: '1:385222238446:ios:b865894873d5bdaad653ff',
    messagingSenderId: '385222238446',
    projectId: 'abis-bookbeacon',
    storageBucket: 'abis-bookbeacon.appspot.com',
    iosBundleId: 'com.example.bookbeacon',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDpofI-BSrs6B0gy2kPNa1v-RLwwJGt74E',
    appId: '1:385222238446:ios:df73f718f07fe6f2d653ff',
    messagingSenderId: '385222238446',
    projectId: 'abis-bookbeacon',
    storageBucket: 'abis-bookbeacon.appspot.com',
    iosBundleId: 'com.example.bookbeacon.RunnerTests',
  );
}
