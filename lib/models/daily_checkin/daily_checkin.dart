import 'dart:convert';
import 'package:flutter/foundation.dart';

class DailyCheckin {
  DateTime date;
  String feel;
  String description;
  DailyCheckin({
    required this.date,
    required this.feel,
    required this.description,
  });

  DailyCheckin copyWith({
    String? userID,
    DateTime? date,
    String? feel,
    String? description,
  }) {
    return DailyCheckin(
      date: date ?? this.date,
      feel: feel ?? this.feel,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'feel': feel,
      'description': description,
    };
  }

  factory DailyCheckin.fromMap(Map<String, dynamic> map) {
    return DailyCheckin(
      date: DateTime.parse(map['date']),
      feel: map['feel'],
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DailyCheckin.fromJson(String source) =>
      DailyCheckin.fromMap(json.decode(source));

  @override
  String toString() =>
      'DailyCheckin(date: $date, feel: $feel, description: $description)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DailyCheckin &&
        other.date == date &&
        other.feel == feel &&
        other.description == description;
  }

  @override
  int get hashCode => date.hashCode ^ feel.hashCode ^ description.hashCode;
}
