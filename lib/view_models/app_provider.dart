import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AppProvider extends ChangeNotifier {
  AppProvider(AndroidNotificationChannel channel,
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
    initNotificationServices(channel, flutterLocalNotificationsPlugin);
  }

  //region multi-languages
  Locale _locale = const Locale("en");

  Locale get locale => _locale;
  String deviceToken = "";
  void toggleLocale() {
    if (_locale.languageCode == "vi") {
      _locale = const Locale("en");
    } else {
      _locale = const Locale("vi");
    }
    notifyListeners();
  }
  //endregion

  //region Notification

  void initNotificationServices(AndroidNotificationChannel channel,
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
    this.channel = channel;
    this.flutterLocalNotificationsPlugin = flutterLocalNotificationsPlugin;
    getDeviceToken();
    setupNotification();
  }

  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  StreamSubscription? onForegroundMessageSubscription;
  void setupNotification() async {
    onForegroundMessageSubscription =
        FirebaseMessaging.onMessage.listen(_firebaseMessagingForegroundHandler);
  }

  void getDeviceToken() async {
    final String? token = await FirebaseMessaging.instance.getToken();
    //TODO: gửi token của máy về server hoặc lấy token này bỏ vào testDeviceToken ở BE để test
    print("This device token is $token");
    deviceToken = token ?? "";
  }

  void _firebaseMessagingForegroundHandler(RemoteMessage message) {
    /**
     * Hàm này được gọi khi nhận được notification mà app ĐANG MỞ
     * TODO: Làm gì đó với notification nhận được
     * Ở đây ví dụ bằng việc show notification đó lên
     */
    flutterLocalNotificationsPlugin.show(
        message.data.hashCode,
        message.data["title"] ?? "Empty Title",
        message.data["body"] ?? "Empty Body",
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: "@mipmap/ic_launcher",
          ),
        ));
  }
  //endregion

  @override
  void dispose() {
    if (onForegroundMessageSubscription != null) {
      onForegroundMessageSubscription!.cancel();
    }
    super.dispose();
  }
}
