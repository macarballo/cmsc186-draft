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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDwBK29ZYoPc8el8BFr4CjpYIQUdj0WH18',
    appId: '1:393839745754:web:fce98f25a398f6eecee3e3',
    messagingSenderId: '393839745754',
    projectId: 'flutter-3a280',
    authDomain: 'flutter-3a280.firebaseapp.com',
    storageBucket: 'flutter-3a280.appspot.com',
    measurementId: 'G-Y7HS324M1W',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDzccmJz23_dpGX4q1ctubde1D15NfzGC4',
    appId: '1:393839745754:android:0f9db57dac998639cee3e3',
    messagingSenderId: '393839745754',
    projectId: 'flutter-3a280',
    storageBucket: 'flutter-3a280.appspot.com',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD3lBNssoxKTXKiPgfBwdysbVirb0-zM5A',
    appId: '1:393839745754:web:1e2fae14c775af0ccee3e3',
    messagingSenderId: '393839745754',
    projectId: 'flutter-3a280',
    authDomain: 'flutter-3a280.firebaseapp.com',
    storageBucket: 'flutter-3a280.appspot.com',
    measurementId: 'G-E4QTXZFP82',
  );

}