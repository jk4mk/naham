// Firebase configuration for the Naham Admin app.
// Project: naham-6d9bb

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      default:
        return web; // fallback to web for other platforms
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDNWxghkXHn2n85Q2FJpYiGe23i8dBwoM4',
    appId: '1:519850470590:web:naham6d9bb00000001',
    messagingSenderId: '519850470590',
    projectId: 'naham-6d9bb',
    authDomain: 'naham-6d9bb.firebaseapp.com',
    storageBucket: 'naham-6d9bb.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDNWxghkXHn2n85Q2FJpYiGe23i8dBwoM4',
    appId: '1:519850470590:android:nahamadmin00000001',
    messagingSenderId: '519850470590',
    projectId: 'naham-6d9bb',
    storageBucket: 'naham-6d9bb.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDNWxghkXHn2n85Q2FJpYiGe23i8dBwoM4',
    appId: '1:519850470590:ios:nahamadmin00000002',
    messagingSenderId: '519850470590',
    projectId: 'naham-6d9bb',
    authDomain: 'naham-6d9bb.firebaseapp.com',
    storageBucket: 'naham-6d9bb.firebasestorage.app',
    iosBundleId: 'com.naham.admin',
  );
}
