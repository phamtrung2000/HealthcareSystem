import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mental_health/services/data_provider.dart';

class DailyCheckinProvider extends ChangeNotifier {
  Future submitDailyCheckin(
    Function onComplete,
    String userID,
    DateTime date,
    String feel,
    String description,
  ) async {
    try {
      await DataProvider().submitDailyCheckin(
        userID: userID,
        date: date,
        feel: feel,
        description: description,
      );
      onComplete();
    } on DioError catch (e) {
      print(e.response!.data);
    }
  }
}
