import 'dart:convert';

import 'package:flutter_mental_health/models/psychological_test/question.dart';

class QuestionDetail {
  final Question question;
  int point;
  QuestionDetail({
    required this.question,
    required this.point,
  });

  QuestionDetail copyWith({
    Question? question,
    int? point,
  }) {
    return QuestionDetail(
      question: question ?? this.question,
      point: point ?? this.point,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question.toMap(),
      'point': point,
    };
  }

  factory QuestionDetail.fromMap(Map<String, dynamic> map) {
    return QuestionDetail(
      question: Question.fromMap(map['question']),
      point: map['point'],
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionDetail.fromJson(String source) =>
      QuestionDetail.fromMap(json.decode(source));

  @override
  String toString() => 'QuestionDetail(question: $question, point: $point)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuestionDetail &&
        other.question == question &&
        other.point == point;
  }

  @override
  int get hashCode => question.hashCode ^ point.hashCode;
}
