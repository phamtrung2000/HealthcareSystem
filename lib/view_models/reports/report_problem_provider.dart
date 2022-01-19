import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mental_health/models/authentication/user.dart';
import 'package:flutter_mental_health/models/reports/problem_report.dart';
import 'package:flutter_mental_health/services/data_provider.dart';

class ReportProblemProvider extends ChangeNotifier {
  List<PlatformFile> pickedFiles = [];
  TextEditingController descriptionController = TextEditingController();
  ProblemReportType _problemReportType = ProblemReportType.Bug;

  void set(value) {
    _problemReportType = value;
    notifyListeners();
  }

  ProblemReportType get() {
    return _problemReportType;
  }

  Future pickFiles() async {
    final result = (await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'png'],
          allowMultiple: true,
        ))
            ?.files ??
        [];

    pickedFiles.addAll([...result]);

    pickedFiles = [
      ...{...pickedFiles}
    ];
    notifyListeners();
  }

  void delete(PlatformFile file) {
    pickedFiles.removeWhere((element) => element.identifier == file.identifier);
    notifyListeners();
  }

  Future submitProblemReport(Function onComplete, String user) async {
    try {
      await DataProvider().submitProblemReport(
        problemReportType: _problemReportType,
        description: descriptionController.text,
        files: pickedFiles
            .map((e) => {
                  "url": e.toString(),
                  "name": e.name,
                  "type": e.name.split('.').last
                })
            .toList(),
        userID: user,
      );

      // show success dialog
      onComplete();
    } on DioError catch (e) {
      print(e.response?.data);
    }
    descriptionController.clear();
    pickedFiles.clear();
    notifyListeners();
  }
}
