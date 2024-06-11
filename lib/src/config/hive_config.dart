// ignore_for_file: avoid_print, always_declare_return_types, require_trailing_commas, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

/// Os dados precisão estar exatamente iquais para poder dar certo
/// vc pode obter os valores altomaticamente no firebase
/// barra de conectar projeto ao flutter.
///
/// Em qualquer diretório, execute o comando:
///! [dart pub global activate flutterfire_cli]
/// Em seguida, na raiz do diretório do seu projeto do Flutter, execute o comando:
///! [flutterfire configure --project=app-innovaro]
/// depois é so preencher os dados nos campos corretos la no firebase de homologação

class AppSettings extends ChangeNotifier {
  late Box box;

  startSettings() async {
    await _startPreferences();
    // await readLocale();
  }

  Future<void> _startPreferences() async {
    box = await Hive.openBox('FirebaseLicensingData');
  }

  readLocale() {
    final apiKey_android = box.get('apiKey_android');
    final appId_android = box.get('appId_android');
    // final authDomain_android = box.get('authDomain_android');
    // final measurementId_android = box.get('measurementId_android');
    final messagingSenderId_android = box.get('messagingSenderId_android');
    final projectId_android = box.get('projectId_android');
    final storageBucket_android = box.get('storageBucket_android');

    final apiKey_web = box.get('apiKey_web');
    final appId_web = box.get('appId_web');
    final authDomain_web = box.get('authDomain_web');
    final measurementId_web = box.get('measurementId_web');
    final messagingSenderId_web = box.get('messagingSenderId_web');
    final projectId_web = box.get('projectId_web');
    final storageBucket_web = box.get('storageBucket_web');

    final apiKey_ios = box.get('apiKey_ios');
    final appId_ios = box.get('appId_ios');
    // final authDomain_ios = box.get('authDomain_ios');
    // final measurementId_ios = box.get('measurementId_ios');
    final messagingSenderId_ios = box.get('messagingSenderId_ios');
    final projectId_ios = box.get('projectId_ios');
    final storageBucket_ios = box.get('storageBucket_ios');

    print('Android:');
    print('apiKey: $apiKey_android');
    print('appId: $appId_android');
    // print('authDomain: $authDomain_android');
    // print('measurementId: $measurementId_android');
    print('messagingSenderId: $messagingSenderId_android');
    print('projectId: $projectId_android');
    print('storageBucket: $storageBucket_android');

    print('Web:');
    print('apiKey: $apiKey_web');
    print('appId: $appId_web');
    print('authDomain: $authDomain_web');
    print('measurementId: $measurementId_web');
    print('messagingSenderId: $messagingSenderId_web');
    print('projectId: $projectId_web');
    print('storageBucket: $storageBucket_web');

    print('iOS:');
    print('apiKey: $apiKey_ios');
    print('appId: $appId_ios');
    // print('authDomain: $authDomain_ios');
    // print('measurementId: $measurementId_ios');
    print('messagingSenderId: $messagingSenderId_ios');
    print('projectId: $projectId_ios');
    print('storageBucket: $storageBucket_ios');


    notifyListeners();
  }

  setFirebaseData(Map<String, dynamic> firebaseData) async {
    //__________________________________________________________________________//
    //android
    await box.put('apiKey_android', firebaseData['android']['apiKey']);
    await box.put('appId_android', firebaseData['android']['appId']);
    // await box.put('authDomain_android', firebaseData['android']['authDomain']);
    // await box.put(
    //     'measurementId_android', firebaseData['android']['measurementId']);
    await box.put('messagingSenderId_android',
        firebaseData['android']['messagingSenderId']);
    await box.put('projectId_android', firebaseData['android']['projectId']);
    await box.put(
        'storageBucket_android', firebaseData['android']['storageBucket']);
    //__________________________________________________________________________//

    //web
    await box.put('apiKey_web', firebaseData['web']['apiKey']);
    await box.put('appId_web', firebaseData['web']['appId']);
    await box.put('authDomain_web', firebaseData['web']['authDomain']);
    await box.put('measurementId_web', firebaseData['web']['measurementId']);
    await box.put(
        'messagingSenderId_web', firebaseData['web']['messagingSenderId']);
    await box.put('projectId_web', firebaseData['web']['projectId']);
    await box.put('storageBucket_web', firebaseData['web']['storageBucket']);
    //__________________________________________________________________________//

    //IOS
    await box.put('apiKey_ios', firebaseData['ios']['apiKey']);
    await box.put('appId_ios', firebaseData['ios']['appId']);
    // await box.put('authDomain_ios', firebaseData['ios']['authDomain']);
    // await box.put('measurementId_ios', firebaseData['ios']['measurementId']);
    await box.put(
        'messagingSenderId_ios', firebaseData['ios']['messagingSenderId']);
    await box.put('projectId_ios', firebaseData['ios']['projectId']);
    await box.put('storageBucket_ios', firebaseData['ios']['storageBucket']);
    //__________________________________________________________________________//

    await readLocale();
  }
}
