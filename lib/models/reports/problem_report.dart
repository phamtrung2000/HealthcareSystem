import 'package:equatable/equatable.dart';

class ProblemReport {
  final ProblemReportType type;
  final String description;
  final List<String> fileUrls;

//<editor-fold desc="Data Methods">

  const ProblemReport({
    required this.type,
    required this.description,
    required this.fileUrls,
  });

  @override
  String toString() {
    return 'ProblemReport{' +
        ' type: $type,' +
        ' description: $description,' +
        ' fileUrls: $fileUrls,' +
        '}';
  }

  ProblemReport copyWith({
    ProblemReportType? type,
    String? description,
    List<String>? fileUrls,
  }) {
    return ProblemReport(
      type: type ?? this.type,
      description: description ?? this.description,
      fileUrls: fileUrls ?? this.fileUrls,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': this.type,
      'description': this.description,
      'fileUrls': this.fileUrls,
    };
  }

  factory ProblemReport.fromMap(Map<String, dynamic> map) {
    return ProblemReport(
      type: map['type'] as ProblemReportType,
      description: map['description'] as String,
      fileUrls: map['fileUrls'] as List<String>,
    );
  }

//</editor-fold>
}

enum ProblemReportType { Bug, Other }

extension ProblemReportTypeExtension on ProblemReportType {
  int get value {
    final values = {
      ProblemReportType.Bug: 1,
      ProblemReportType.Other: 2,
    };
    return values[this]!;
  }
}
