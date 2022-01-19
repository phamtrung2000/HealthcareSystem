import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mental_health/models/authentication/user.dart';
import 'package:flutter_mental_health/models/reports/user_report.dart';
import 'package:flutter_mental_health/services/data_provider.dart';

class ReportUserProvider extends ChangeNotifier {
  UserReportType _userReportType = UserReportType.abuse;
  User _reportedUser;
  bool? isCheck = false;
  void set(value) {
    _userReportType = value;
    notifyListeners();
  }

  ReportUserProvider(this._reportedUser);

  UserReportType get() {
    return _userReportType;
  }

  User get reportedUser {
    return _reportedUser;
  }

  Future submitUserReport(Function onComplete, String user) async {
    try {
      await DataProvider().submitUserReport(
        userReportType: _userReportType,
        receiveEmail: isCheck,
        reportedUserID: _reportedUser.id,
        userID: user,
      );

      // show success dialog
      onComplete();
    } on DioError catch (e) {
      print(e.response?.data);
    }

    notifyListeners();
  }
}
