import 'package:firebase_core/firebase_core.dart';

class InitialFirebaseOptionsConfiguration {
  static String? tokenAccess;
  static FirebaseOptions get defaultOptions {
    // firebase de licenciamento
    return const FirebaseOptions(
      apiKey: 'AIzaSyA3lpM9MiA26oTkhmpipc2vBB4QHHyHf0U',
      appId: '1:290339376139:web:e5348ec8aca18b8b3b8b0e',
      messagingSenderId: '290339376139',
      projectId: 'licenciador-c33e2',
      authDomain: 'licenciador-c33e2.firebaseapp.com',
      storageBucket: 'licenciador-c33e2.appspot.com',
      measurementId: 'G-QS6ZY1R1RW',
    );
  }
}
