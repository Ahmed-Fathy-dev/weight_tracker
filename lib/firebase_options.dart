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
    apiKey: 'AIzaSyCfXMgVHkvqkFFVZTqbCmhVPgDk9ITa_pw',
    appId: '1:915640011670:web:4a5ecffb5a56b64716abb7',
    messagingSenderId: '915640011670',
    projectId: 'weight-tracker-361b0',
    authDomain: 'weight-tracker-361b0.firebaseapp.com',
    storageBucket: 'weight-tracker-361b0.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDB3HAC_iKsqYQGQotarYEvSSKNo95l44Q',
    appId: '1:915640011670:android:da604d0a7294756c16abb7',
    messagingSenderId: '915640011670',
    projectId: 'weight-tracker-361b0',
    storageBucket: 'weight-tracker-361b0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC64pxoq2RHB7iCbGOt1NgEGAMJyqniy-0',
    appId: '1:915640011670:ios:3f5e7202ce0d3b8716abb7',
    messagingSenderId: '915640011670',
    projectId: 'weight-tracker-361b0',
    storageBucket: 'weight-tracker-361b0.appspot.com',
    iosClientId: '915640011670-mkf4p12udn5kdnr4p4udqahon50fh1jh.apps.googleusercontent.com',
    iosBundleId: 'com.212solutionsllc.weightTracker',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC64pxoq2RHB7iCbGOt1NgEGAMJyqniy-0',
    appId: '1:915640011670:ios:3f5e7202ce0d3b8716abb7',
    messagingSenderId: '915640011670',
    projectId: 'weight-tracker-361b0',
    storageBucket: 'weight-tracker-361b0.appspot.com',
    iosClientId: '915640011670-mkf4p12udn5kdnr4p4udqahon50fh1jh.apps.googleusercontent.com',
    iosBundleId: 'com.212solutionsllc.weightTracker',
  );
}
