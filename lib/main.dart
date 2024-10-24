import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:app_liter_art/src/app_liter_art.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runZonedGuarded(() async {
    const FirebaseOptions android = FirebaseOptions(
      apiKey: "AIzaSyBKVTp5h-4PcwMnwsrQPjLsiaYNFocHx3A",
      appId: "1:683476032153:android:74f6fa9e20214225d17608",
      messagingSenderId: "683476032153",
      projectId: "literart-529e2",
      storageBucket: "literart-529e2.appspot.com",
    );

    const FirebaseOptions ios = FirebaseOptions(
        apiKey: "AIzaSyDQG50f9Cg_STtkZ5ZSQEXR3UVn9AqXknQ",
        appId: "1:683476032153:ios:92fd8e01af988bfcd17608",
        messagingSenderId: "683476032153",
        projectId: "literart-529e2",
        storageBucket: "literart-529e2.appspot.com");

    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: Platform.isAndroid ? android : ios);

    runApp(
      const AppLiterArt(),
    );
  }, (error, stack) {
    log('Erro não tratado', error: error, stackTrace: stack);
    throw error;
  });
}
