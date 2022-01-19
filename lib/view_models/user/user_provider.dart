import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mental_health/models/notification/notification_of_user.dart';
import 'package:flutter_mental_health/services/data_provider.dart';
import 'package:flutter_mental_health/models/authentication/user.dart';
import 'package:flutter_mental_health/utils/socket_helper.dart';
import 'package:flutter_mental_health/view_models/auth/auth_provider.dart';
import 'package:image_picker/image_picker.dart';

class UserProvider extends ChangeNotifier {
  Future updateUserProfile(
      Function onComplete, String userId, String gender, String avatar) async {
    try {
      await DataProvider()
          .updateUserById(userId: userId, gender: gender, avatar: avatar);
      notifyListeners();
      onComplete();
    } on DioError catch (e) {
      print(e.response!.data);
    }
  }
}
