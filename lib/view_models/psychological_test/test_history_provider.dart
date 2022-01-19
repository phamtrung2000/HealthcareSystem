import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mental_health/models/psychological_test/psychological_test.dart';
import 'package:flutter_mental_health/services/data_provider.dart';

class TestHistoryProvider extends ChangeNotifier {
  bool isViewDetail = false;

  List<PsychologicalTest> _psychologicalTestList = [];

  List<PsychologicalTest> get psychologicalTestList {
    return _psychologicalTestList;
  }

  Future getAllQuestionForTest() async {
    try {
      _psychologicalTestList = await DataProvider().getAllPsychologicalTest();
    } on DioError catch (e) {
      print(e.response?.data);
    }

    notifyListeners();
  }
}
