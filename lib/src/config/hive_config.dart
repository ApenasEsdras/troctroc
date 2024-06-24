// ignore_for_file: avoid_print, always_declare_return_types, require_trailing_commas, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

/// Esta classe `AppSettings` gerencia a configuração do Firebase
/// usando dados armazenados localmente no Hive.
///
/// Para configurar os valores automaticamente no Firebase:
/// 1. Em qualquer diretório, execute o comando:
///    ```
///    dart pub global activate flutterfire_cli
///    ```
/// 2. Em seguida, na raiz do diretório do seu projeto Flutter, execute o comando:
///    ```
///    flutterfire configure --project=app-innovaro
///    ```
/// 3. Preencha os dados nos campos corretos no Firebase de homologação.

class AppSettings extends ChangeNotifier {
  late Box _box;

  Box get box => _box;

  /// Inicializa as configurações do aplicativo.
  Future<void> startSettings() async {
    await _startPreferences();
  }

  /// Abre a caixa do Hive para armazenar dados do Firebase.
  Future<void> _startPreferences() async {
    _box = await Hive.openBox('FirebaseLicensingData');
  }

  /// Lê e imprime os dados do Firebase armazenados na caixa do Hive.
  void readLocale() {
    final apiKey_android = box.get('apiKey_android') ?? '';
    final appId_android = box.get('appId_android') ?? '';
    final messagingSenderId_android =
        box.get('messagingSenderId_android') ?? '';
    final projectId_android = box.get('projectId_android') ?? '';
    final storageBucket_android = box.get('storageBucket_android') ?? '';

    final apiKey_web = box.get('apiKey_web') ?? '';
    final appId_web = box.get('appId_web') ?? '';
    final authDomain_web = box.get('authDomain_web') ?? '';
    final measurementId_web = box.get('measurementId_web') ?? '';
    final messagingSenderId_web = box.get('messagingSenderId_web') ?? '';
    final projectId_web = box.get('projectId_web') ?? '';
    final storageBucket_web = box.get('storageBucket_web') ?? '';

    final apiKey_ios = box.get('apiKey_ios') ?? '';
    final appId_ios = box.get('appId_ios') ?? '';
    final messagingSenderId_ios = box.get('messagingSenderId_ios') ?? '';
    final projectId_ios = box.get('projectId_ios') ?? '';
    final storageBucket_ios = box.get('storageBucket_ios') ?? '';

    print('Android:');
    print('apiKey: $apiKey_android');
    print('appId: $appId_android');
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
    print('messagingSenderId: $messagingSenderId_ios');
    print('projectId: $projectId_ios');
    print('storageBucket: $storageBucket_ios');

    notifyListeners();
  }

  /// Define os dados do Firebase na caixa do Hive.
  Future<void> setFirebaseData(Map<String, dynamic> firebaseData) async {
    // Dados do Android
    await box.put('apiKey_android', firebaseData['android']['apiKey']);
    await box.put('appId_android', firebaseData['android']['appId']);
    await box.put('messagingSenderId_android',
        firebaseData['android']['messagingSenderId']);
    await box.put('projectId_android', firebaseData['android']['projectId']);
    await box.put(
        'storageBucket_android', firebaseData['android']['storageBucket']);

    // Dados do Web
    await box.put('apiKey_web', firebaseData['web']['apiKey']);
    await box.put('appId_web', firebaseData['web']['appId']);
    await box.put('authDomain_web', firebaseData['web']['authDomain']);
    await box.put('measurementId_web', firebaseData['web']['measurementId']);
    await box.put(
        'messagingSenderId_web', firebaseData['web']['messagingSenderId']);
    await box.put('projectId_web', firebaseData['web']['projectId']);
    await box.put('storageBucket_web', firebaseData['web']['storageBucket']);

    // Dados do iOS
    await box.put('apiKey_ios', firebaseData['ios']['apiKey']);
    await box.put('appId_ios', firebaseData['ios']['appId']);
    await box.put(
        'messagingSenderId_ios', firebaseData['ios']['messagingSenderId']);
    await box.put('projectId_ios', firebaseData['ios']['projectId']);
    await box.put('storageBucket_ios', firebaseData['ios']['storageBucket']);

    readLocale();
  }
}
