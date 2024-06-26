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
    apiKey: 'AIzaSyAfQ_YZCp1EJSkS1S7J0wnqunETdWdWWKA',
    appId: '1:23020200000:web:4073537beff23ed86b3fa5',
    messagingSenderId: '23020200000',
    projectId: 'teamforfilm-74eb8',
    authDomain: 'teamforfilm-74eb8.firebaseapp.com',
    storageBucket: 'teamforfilm-74eb8.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDG_vIwXFZcaChnMHhX0mkWaqrMTN8L5Dg',
    appId: '1:23020200000:android:7cb92f0ba391bc726b3fa5',
    messagingSenderId: '23020200000',
    projectId: 'teamforfilm-74eb8',
    storageBucket: 'teamforfilm-74eb8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDvLey4hAdE3lX3aA-L-GrAYirutHTTZ6M',
    appId: '1:23020200000:ios:a4bef7a69064557f6b3fa5',
    messagingSenderId: '23020200000',
    projectId: 'teamforfilm-74eb8',
    storageBucket: 'teamforfilm-74eb8.appspot.com',
    iosClientId: '23020200000-a2kmertir7tignjq61llijd1a6bomd93.apps.googleusercontent.com',
    iosBundleId: 'com.example.navinProject',
  );

}