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
    apiKey: 'AIzaSyCTeu9heBw1OHU2F6o2xBSEWIMGAI-fo-Q',
    appId: '1:853709775123:web:500f106cee1f0d0f9ffae6',
    messagingSenderId: '853709775123',
    projectId: 'arotest-ead9e',
    authDomain: 'arotest-ead9e.firebaseapp.com',
    storageBucket: 'arotest-ead9e.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDhtH7UvdUnRIGiLBwiiozz9sOM17yJM4o',
    appId: '1:853709775123:android:704c49ccf5149ba69ffae6',
    messagingSenderId: '853709775123',
    projectId: 'arotest-ead9e',
    storageBucket: 'arotest-ead9e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBw2DhyqyGVQ8L7yd2Z3i14AnKYDHFCnIo',
    appId: '1:853709775123:ios:a33cff25234b66f09ffae6',
    messagingSenderId: '853709775123',
    projectId: 'arotest-ead9e',
    storageBucket: 'arotest-ead9e.appspot.com',
    iosBundleId: 'com.example.test',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBw2DhyqyGVQ8L7yd2Z3i14AnKYDHFCnIo',
    appId: '1:853709775123:ios:a33cff25234b66f09ffae6',
    messagingSenderId: '853709775123',
    projectId: 'arotest-ead9e',
    storageBucket: 'arotest-ead9e.appspot.com',
    iosBundleId: 'com.example.test',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCTeu9heBw1OHU2F6o2xBSEWIMGAI-fo-Q',
    appId: '1:853709775123:web:bd92fbf57cf3afae9ffae6',
    messagingSenderId: '853709775123',
    projectId: 'arotest-ead9e',
    authDomain: 'arotest-ead9e.firebaseapp.com',
    storageBucket: 'arotest-ead9e.appspot.com',
  );
}
