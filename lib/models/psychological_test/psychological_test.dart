import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:flutter_mental_health/models/psychological_test/question.dart';
import 'package:flutter_mental_health/models/psychological_test/question_detail.dart';

class PsychologicalTest {
  int point;
  List<QuestionDetail> questionDetailList;
  DateTime createdAt;
  PsychologicalTest({
    required this.point,
    required this.questionDetailList,
    required this.createdAt,
  });

  PsychologicalTest copyWith({
    int? point,
    List<QuestionDetail>? questionDetailList,
    DateTime? createAt,
  }) {
    return PsychologicalTest(
      point: point ?? this.point,
      questionDetailList: questionDetailList ?? this.questionDetailList,
      createdAt: createAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'point': point,
      'questions': questionDetailList.map((x) => x.toMap()).toList(),
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory PsychologicalTest.fromMap(Map<String, dynamic> map) {
    return PsychologicalTest(
      point: map['point'],
      questionDetailList: List<QuestionDetail>.from(
          map['questions']?.map((x) => QuestionDetail.fromMap(x))),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PsychologicalTest.fromJson(String source) =>
      PsychologicalTest.fromMap(json.decode(source));

  @override
  String toString() =>
      'PsychologicalTest(point: $point, questions: $questionDetailList, createdAt: $createdAt)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PsychologicalTest &&
        other.point == point &&
        listEquals(other.questionDetailList, questionDetailList) &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode =>
      point.hashCode ^ questionDetailList.hashCode ^ createdAt.hashCode;
}
