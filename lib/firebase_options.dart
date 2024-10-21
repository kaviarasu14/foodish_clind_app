import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

FirebaseOptions firebaseOptions = Platform.isAndroid
    ? const FirebaseOptions(
        apiKey: 'AIzaSyDIFfan5plUnuhiVGGQ36t6kbQs9ZnbX84',
        appId: '1:886270077397:android:bcdc7023ec5667adedb55c',
        messagingSenderId: '886270077397',
        projectId: 'fooddelivery-9f962',
        storageBucket: 'fooddelivery-9f962.appspot.com',
      )
    : const FirebaseOptions(
        apiKey: 'AIzaSyDE8-ESkD2z7YcN6sjmxGQWMxJmuZ9qzhE',
        appId: '1:886270077397:ios:0c81474ec4a4ec7cedb55c',
        messagingSenderId: '886270077397',
        projectId: 'fooddelivery-9f962',
        storageBucket: 'fooddelivery-9f962.appspot.com',
        iosBundleId: 'com.example.foodDeliveryClindApp',
      );
