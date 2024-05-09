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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyC7QU_Q6fXXV2AE2fJmOhNgDKxSi-u0usU',
    appId: '1:697234845456:web:4aa7a70bacbb97a8977f95',
    messagingSenderId: '697234845456',
    projectId: 'chat-app-44ed7',
    authDomain: 'chat-app-44ed7.firebaseapp.com',
    storageBucket: 'chat-app-44ed7.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC6JxXcWRRvuryOMjOYuTPQcgGV5lv2lDE',
    appId: '1:697234845456:android:e0123cd671131d5c977f95',
    messagingSenderId: '697234845456',
    projectId: 'chat-app-44ed7',
    storageBucket: 'chat-app-44ed7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA-T7rQfr59qdJNmpmaSWX0Oor76UEOaA4',
    appId: '1:697234845456:ios:b10fdae7ec4c0d22977f95',
    messagingSenderId: '697234845456',
    projectId: 'chat-app-44ed7',
    storageBucket: 'chat-app-44ed7.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );
}
