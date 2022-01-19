import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_mental_health/app.dart';
import 'package:flutter_mental_health/view_models/app_provider.dart';
import 'package:flutter_mental_health/view_models/app_started/app_started_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupBackgroundNotification();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppProvider(
            channel,
            flutterLocalNotificationsPlugin,
          ),
        ),
        ChangeNotifierProvider(create: (_) => AppStartedProvider(prefs)),
      ],
      builder: (context, _) {
        return const MentalHealthApp();
      },
    ),
  );
}

//region setup background notification handler

Future setupBackgroundNotification() async {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    ),
  );
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  /**
   * Hàm này được gọi khi nhận được notification mà app ĐANG CHẠY Ở BACKGROUND
   * TODO: Làm gì đó với notification nhận được
   * Ở đây ví dụ bằng việc show notification đó lên
   */
  await Firebase.initializeApp();
  print('Handling a background message ${message.data}');
  flutterLocalNotificationsPlugin.show(
      message.data.hashCode,
      message.data["title"] ?? "Empty Title",
      message.data["body"] ?? "Empty Body",
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: "@mipmap/ic_launcher",
        ),
      ));
}

AndroidNotificationChannel channel = const AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.high,
);
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
//endregion
