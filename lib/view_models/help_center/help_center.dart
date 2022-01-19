import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

//import 'package:flutter_mental_health/models/help_center/help_ceter.dart';
import 'package:flutter_mental_health/services/data_provider.dart';
import 'package:flutter_mental_health/models/help_center/help_center.dart';

class HelpCenterProvider extends ChangeNotifier {
  bool isLoad = true;

  List<HelpCenterTopic> helpCenterTP = <HelpCenterTopic>[];

  HelpCenterTopic _helpCenterTopic =
      HelpCenterTopic(topicID: '', tittle: '', listQuestions: []);

  HelpCenterProvider() {
    getAllHelpCenterTopic();
  }

  Future getAllHelpCenterTopic() async {
    List<HelpCenterTopic> helpCenterTopic =
        await DataProvider().getAllHelpCenterTopics();
    for (HelpCenterTopic topic in helpCenterTopic) {
    }
    helpCenterTP = helpCenterTopic;
    //print(helpCenterTP);
  }

  List<HelpCenterTopic>? get helpAllHelpCenterTopic{
    return helpCenterTP;
  }
  /*List<HelpCenterQuestion>? get helpCenterQuestion {
    return _helpCenterTopic.listQuestions;*/

}
