// onboarding_config.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OnboardingService {
  Future<Map<String, dynamic>> readDataFirebase(
    TextEditingController chaveController,
  ) async {
    final DocumentReference docRef = FirebaseFirestore.instance
        .collection('licenciamento')
        .doc(chaveController.text);
    final DocumentSnapshot docSnapshot = await docRef.get();
    if (docSnapshot.exists) {
      final Map<String, dynamic> data =
          docSnapshot.data() as Map<String, dynamic>;
      final Map<String, dynamic> firebaseData = {
        'android': {
          'apiKey': data['android']['apiKey'],
          'appId': data['android']['appId'],
          'messagingSenderId': data['android']['messagingSenderId'],
          'projectId': data['android']['projectId'],
          'storageBucket': data['android']['storageBucket'],
        },
        'web': {
          'apiKey': data['web']['apiKey'],
          'appId': data['web']['appId'],
          'authDomain': data['web']['authDomain'],
          'measurementId': data['web']['measurementId'],
          'messagingSenderId': data['web']['messagingSenderId'],
          'projectId': data['web']['projectId'],
          'storageBucket': data['web']['storageBucket'],
        },
        'ios': {
          'apiKey': data['ios']['apiKey'],
          'appId': data['ios']['appId'],
          'messagingSenderId': data['ios']['messagingSenderId'],
          'projectId': data['ios']['projectId'],
          'storageBucket': data['ios']['storageBucket'],
        },
      };
      if (kDebugMode) {
        print('dados do firebase ');
        print(firebaseData);
      }
      return firebaseData;
    } else {
      if (kDebugMode) {
        print('Documento não encontrado.');
      }
      return {};
    }
  }
}
