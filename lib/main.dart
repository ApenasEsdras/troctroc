import 'src/app_module.dart';
import 'src/app_widget.dart';
import 'src/config/hive_config.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'inital_firebase_options_config.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'src/config/firebase_options_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'src/repo_testes_widgets/notifi_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Hive.initFlutter();
  final appSettings = AppSettings();
  await appSettings.startSettings();

  FirebaseOptions? firebaseOptions;

  if (appSettings.box.isEmpty) {
    firebaseOptions = InitialFirebaseOptionsConfiguration.defaultOptions;
  } else {
    await DefaultFirebaseOptions.configureFirebaseOptionsFromBox();
    firebaseOptions = DefaultFirebaseOptions.currentPlatform;
  }

  await Firebase.initializeApp(
    options: firebaseOptions,
  );

  runApp(
    ModularApp(
      module: AppModule(appSettings),
      child: const AppWidget(),
    ),
  );
}
