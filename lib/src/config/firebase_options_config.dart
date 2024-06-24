// ignore_for_file: avoid_print, always_declare_return_types, require_trailing_commas, non_constant_identifier_names

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'hive_config.dart';

class FirebasePlatformOptions {
  final FirebaseOptions web;
  final FirebaseOptions android;
  final FirebaseOptions ios;

  FirebasePlatformOptions({
    required this.web,
    required this.android,
    required this.ios,
  });

  FirebaseOptions? getOptionsForPlatform() {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        return web;
    }
  }
}

class DefaultFirebaseOptions {
  static FirebasePlatformOptions? _platformOptions;
  static FirebaseOptions? get currentPlatform => _platformOptions?.getOptionsForPlatform();

  static void setPlatformOptions(FirebasePlatformOptions options) {
    _platformOptions = options;
  }

  static Future<void> configureFirebaseOptionsFromBox(AppSettings appSettings) async {
    final webOptions = FirebaseOptions(
      apiKey: appSettings.box.get('apiKey_web'),
      appId: appSettings.box.get('appId_web'),
      messagingSenderId: appSettings.box.get('messagingSenderId_web'),
      projectId: appSettings.box.get('projectId_web'),
      storageBucket: appSettings.box.get('storageBucket_web'),
    );

    final androidOptions = FirebaseOptions(
      apiKey: appSettings.box.get('apiKey_android'),
      appId: appSettings.box.get('appId_android'),
      messagingSenderId: appSettings.box.get('messagingSenderId_android'),
      projectId: appSettings.box.get('projectId_android'),
      storageBucket: appSettings.box.get('storageBucket_android'),
    );

    final iosOptions = FirebaseOptions(
      apiKey: appSettings.box.get('apiKey_ios'),
      appId: appSettings.box.get('appId_ios'),
      messagingSenderId: appSettings.box.get('messagingSenderId_ios'),
      projectId: appSettings.box.get('projectId_ios'),
      storageBucket: appSettings.box.get('storageBucket_ios'),
    );

    DefaultFirebaseOptions.setPlatformOptions(
      FirebasePlatformOptions(
        web: webOptions,
        android: androidOptions,
        ios: iosOptions,
      ),
    );
  }
}
  