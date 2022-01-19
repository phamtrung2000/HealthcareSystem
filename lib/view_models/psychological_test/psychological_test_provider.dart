import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mental_health/models/authentication/user.dart';
import 'package:flutter_mental_health/models/psychological_test/psychological_test.dart';
import 'package:flutter_mental_health/models/psychological_test/question.dart';
import 'package:flutter_mental_health/models/psychological_test/question_detail.dart';
import 'package:flutter_mental_health/services/data_provider.dart';

class PsychologicalTestProvider extends ChangeNotifier {
  bool isLoad = true;
  bool viewTestHistoryDetail = false;

  PsychologicalTest _psychologicalTest = PsychologicalTest(
      createdAt: DateTime.now(), point: 0, questionDetailList: []);

  PsychologicalTestProvider() {
    getAllQuestionForTest();
  }

  List<QuestionDetail>? get questionDetailList {
    return _psychologicalTest.questionDetailList;
  }

  int? get totalPoint {
    for (int i = 0; i < _psychologicalTest.questionDetailList.length; i++) {
      _psychologicalTest.point +=
          _psychologicalTest.questionDetailList[i].point;
    }
    return _psychologicalTest.point;
  }

  void setQuestionDetail(int position, int point) {
    _psychologicalTest.questionDetailList[position].point = point;
  }

  void setQuestionDetailList(List<QuestionDetail> questionDetailList) {
    _psychologicalTest.questionDetailList = questionDetailList;
  }

  void clearPsychologicalTest(bool clearQuestionPoint) {
    _psychologicalTest.point = 0;

    if (clearQuestionPoint) {
      for (var i = 0; i < _psychologicalTest.questionDetailList.length; i++) {
        _psychologicalTest.questionDetailList[i].point = 0;
      }
    }
  }

  Future getAllQuestionForTest() async {
    try {
      List<Question> questionList = await DataProvider().getAllQuestion();
      for (Question question in questionList) {
        QuestionDetail questionDetail =
            QuestionDetail(point: 0, question: question);
        _psychologicalTest.questionDetailList.add(questionDetail);
      }
    } on DioError catch (e) {
      print(e.response?.data);
    }
    isLoad = false;
    notifyListeners();
  }

  Future submitPsychologicalTest(Function onComplete, String userID) async {
    try {
      await DataProvider().submitPsychologicalTest(
          point: _psychologicalTest.point,
          questionDetailList: _psychologicalTest.questionDetailList,
          userID: userID);

      // show success dialog
      clearPsychologicalTest(true);
      onComplete();
    } on DioError catch (e) {
      print(e.response?.statusCode);
    }
  }
}
