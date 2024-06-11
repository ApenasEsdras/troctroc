import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('flutter_logo');

    final initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {},
    );

    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {},
    );
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channelId',
        'channelName',
        importance: Importance.max,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future<void> showNotification({String? title, String? body}) async {
    await notificationsPlugin.show(0, title, body, notificationDetails());
  }

  late Stream<QuerySnapshot<Map<String, dynamic>>> firebaseDataStream;

  final List<String> previousDocumentIds = [];

  void initState() {
    firebaseDataStream = getFirebaseDataStream();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getFirebaseDataStream() {
    return FirebaseFirestore.instance
        .collection('pedidos')
        .orderBy('emissao', descending: true)
        .snapshots();
  }

  void checkAndSendNotifications(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final String documentId = doc.id;
    final Map<String, dynamic> data = doc.data();

    if (!previousDocumentIds.contains(documentId)) {
      final int? status = data['status'] as int?;

      if (status == 1 || status == 3) {
        showNotification(
          title: 'Novo Pedido',
          body: 'Um novo pedido foi registrado.',
        );
      }

      previousDocumentIds.add(documentId);
    }
  }
}
