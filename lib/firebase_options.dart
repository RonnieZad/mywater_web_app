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
    apiKey: 'AIzaSyCiNhrN6CT4yCm9siZcZTi_brtKp1lLihk',
    appId: '1:991621591966:web:376656ac477648936a5c8f',
    messagingSenderId: '991621591966',
    projectId: 'mywater-abc',
    authDomain: 'mywater-abc.firebaseapp.com',
    storageBucket: 'mywater-abc.appspot.com',
    measurementId: 'G-7L6JEEZ7KH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBA6taOYaQiPKr_8CM_Nf8d6pxhECGJYkg',
    appId: '1:991621591966:android:846d90ff3d4af52f6a5c8f',
    messagingSenderId: '991621591966',
    projectId: 'mywater-abc',
    storageBucket: 'mywater-abc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCuvzF7taskOn7hNmUUd-Sw1qD3fm0ItoA',
    appId: '1:991621591966:ios:1f81dc218f822cfd6a5c8f',
    messagingSenderId: '991621591966',
    projectId: 'mywater-abc',
    storageBucket: 'mywater-abc.appspot.com',
    iosClientId: '991621591966-hjfnm6ls9qsegh30l91cvsuhg073nhh5.apps.googleusercontent.com',
    iosBundleId: 'com.example.mywaterWebApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCuvzF7taskOn7hNmUUd-Sw1qD3fm0ItoA',
    appId: '1:991621591966:ios:1f81dc218f822cfd6a5c8f',
    messagingSenderId: '991621591966',
    projectId: 'mywater-abc',
    storageBucket: 'mywater-abc.appspot.com',
    iosClientId: '991621591966-hjfnm6ls9qsegh30l91cvsuhg073nhh5.apps.googleusercontent.com',
    iosBundleId: 'com.example.mywaterWebApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCiNhrN6CT4yCm9siZcZTi_brtKp1lLihk',
    appId: '1:991621591966:web:4f80807cd3fe65536a5c8f',
    messagingSenderId: '991621591966',
    projectId: 'mywater-abc',
    authDomain: 'mywater-abc.firebaseapp.com',
    storageBucket: 'mywater-abc.appspot.com',
    measurementId: 'G-WQQN98W7GT',
  );

}