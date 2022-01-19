import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/app_configs.dart';
import 'package:flutter_mental_health/constants/format_date.dart';

class FeedbackModel {
  late final String feedbackID;
  late final String title;
  late final String description;
  late final String userID;
  late final List<String>? files;
  late final DateTime date;

  FeedbackModel({
    required this.feedbackID,
    required this.title,
    required this.description,
    required this.userID,
    required this.date,
    this.files,
  });

  factory FeedbackModel.fromMap(Map<String, dynamic> map) {
    return FeedbackModel(
        feedbackID: map['_id'],
        title: map['title'],
        description: map['description'],
        userID: map['user'],
        date: DateTime.parse(map['date']),
        files: map['images'] == null ? [] : List<String>.from(map['images'])
          .map((e) => AppConfigs.apiUrl + e)
          .toList()
    );
  }

  Map<String, dynamic> toMap() {
    final _data = <String, dynamic>{};
    _data['_id'] = feedbackID;
    _data['title'] = title;
    _data['description'] = description;
    _data['user'] = userID;
    _data['images'] = files;
    _data['date'] = date.toIso8601String();
    return _data;
  }

  factory FeedbackModel.fromJson(String j) => FeedbackModel.fromMap(json.decode(j));

  String toJson() => json.encode(toMap());
}
