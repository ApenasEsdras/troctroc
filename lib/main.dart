// ignore_for_file: avoid_print, always_declare_return_types, require_trailing_commas, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'src/app_module.dart';
import 'src/app_widget.dart';
import 'src/config/hive_config.dart';
import 'inital_firebase_options_config.dart';
import 'src/repo_testes_widgets/notifi_service.dart';
import 'src/config/firebase_options_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeApp();
}

Future<void> _initializeApp() async {
  NotificationService().initNotification();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Hive.initFlutter();
  final appSettings = AppSettings();
  await appSettings.startSettings();

  final firebaseOptions = await _getFirebaseOptions(appSettings);
  await Firebase.initializeApp(options: firebaseOptions);

  runApp(
    ModularApp(
      module: AppModule(appSettings),
      child: const AppWidget(),
    ),
  );
}

Future<FirebaseOptions> _getFirebaseOptions(AppSettings appSettings) async {
  if (appSettings.box.isEmpty) {
    return InitialFirebaseOptionsConfiguration.defaultOptions;
  } else {
    await DefaultFirebaseOptions.configureFirebaseOptionsFromBox(appSettings);
    return DefaultFirebaseOptions.currentPlatform!;
  }
}
