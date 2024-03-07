//modul 4

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
    apiKey: 'AIzaSyBXr3Wg5KhHTa2jrV4b0i4uU7BHUh-8BrM',
    appId: '1:314640814353:web:d07023530d7a3543967cb0',
    messagingSenderId: '314640814353',
    projectId: 'modul4-56613',
    authDomain: 'modul4-56613.firebaseapp.com',
    storageBucket: 'modul4-56613.appspot.com',
    measurementId: 'G-FWNVF0RL7G',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDggQHw2BoG0OYlGJ3BJAl_dtA9VYUwjBY',
    appId: '1:314640814353:android:42096c849ae7f039967cb0',
    messagingSenderId: '314640814353',
    projectId: 'modul4-56613',
    storageBucket: 'modul4-56613.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDIJX2bZwdA7duGbGmvnlBCISUkQ_Rv6Hc',
    appId: '1:314640814353:ios:a624c742f68812d8967cb0',
    messagingSenderId: '314640814353',
    projectId: 'modul4-56613',
    storageBucket: 'modul4-56613.appspot.com',
    iosBundleId: 'com.example.celendar',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDIJX2bZwdA7duGbGmvnlBCISUkQ_Rv6Hc',
    appId: '1:314640814353:ios:4ef7a469e6b777e0967cb0',
    messagingSenderId: '314640814353',
    projectId: 'modul4-56613',
    storageBucket: 'modul4-56613.appspot.com',
    iosBundleId: 'com.example.celendar.RunnerTests',
  );
}