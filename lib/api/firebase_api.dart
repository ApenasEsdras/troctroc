// // // ignore_for_file: avoid_print

// import 'package:firebase_messaging/firebase_messaging.dart';
// import '../src/pages/notifi_page.dart';

// class FirebaseMessage {
//   FirebaseMessaging messaging = FirebaseMessaging.instance;

//   Future<void> initNotifications() async {
//     await messaging.requestPermission();
//     final token = await messaging.getToken();
//     // ignore: avoid_print
//     print('Token do FCM: $token');

//     // Subscrever a um tópico (se necessário)
//     await messaging.subscribeToTopic('pedido_updates');

//     // Configurar os listeners para diferentes cenários de notificações
//     messaging.configure(
//       onMessage: (RemoteMessage message) async {
//         print('Notificação recebida em primeiro plano: ${message.notification?.body}');
//         // Chamar uma função para lidar com a notificação em primeiro plano
//         NotifiPage.handleNotification(message);
//       },
//       onLaunch: (RemoteMessage message) async {
//         print('Aplicativo aberto a partir de uma notificação: ${message.notification?.body}');
//         // Chamar uma função para lidar com a notificação quando o aplicativo é aberto a partir de uma notificação
//         NotifiPage.handleNotification(message);
//       },
//       onResume: (RemoteMessage message) async {
//         print('Aplicativo retomado a partir de segundo plano: ${message.notification?.body}');
//         // Chamar uma função para lidar com a notificação quando o aplicativo é retomado a partir de segundo plano
//         NotifiPage.handleNotification(message);
//       },
//     );
//   }
// }
