import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mental_health/models/notification/notification_of_user.dart';
import 'package:flutter_mental_health/services/data_provider.dart';
import 'package:flutter_mental_health/models/authentication/user.dart';
import 'package:flutter_mental_health/utils/socket_helper.dart';
import 'package:flutter_mental_health/view_models/auth/auth_provider.dart';

class NotificationProvider extends ChangeNotifier {
  List<NotificationOfUser> _notificationList = [];
  final User _user;
  NotificationProvider(this._user) {
    loadNotification();
    SocketHelper().postSocket.emit("joinPost", _user.id);
  }

  Future loadNotification() async {
    try {
      _notificationList = await DataProvider().getAllNotification(_user.id);
      notifyListeners();
    } on DioError catch (e) {
      print(e.response);
    }
  }

  List<NotificationOfUser> get notificationList {
    return _notificationList;
  }
}
