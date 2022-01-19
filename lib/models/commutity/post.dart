import 'dart:convert';

import 'package:flutter_mental_health/configs/app_configs.dart';
import 'package:flutter_mental_health/models/authentication/user.dart';
import 'package:flutter_mental_health/models/commutity/post_topic.dart';
import 'package:flutter_mental_health/models/commutity/react.dart';

class Post {
  final String id;
  final String title;
  final String content;
  final int status;
  final User user;
  bool allowComment;
  final List<String> images;
  final PostTopic topic;
  final List<React> reacts;
  final DateTime createdAt;
  final int comments;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.status,
    required this.user,
    required this.allowComment,
    required this.images,
    required this.topic,
    required this.reacts,
    required this.createdAt,
    required this.comments,
  });

  Post copyWith({
    String? id,
    String? title,
    String? content,
    int? status,
    User? user,
    List<String>? images,
    PostTopic? topic,
    List<React>? reacts,
    DateTime? createdAt,
    int? comments,
    bool? allowComment,
  }) {
    return Post(
      id: id ?? this.id,
      allowComment: allowComment ?? this.allowComment,
      title: title ?? this.title,
      content: content ?? this.content,
      status: status ?? this.status,
      user: user ?? this.user,
      images: images ?? this.images,
      topic: topic ?? this.topic,
      reacts: reacts ?? this.reacts,
      createdAt: createdAt ?? this.createdAt,
      comments: comments ?? this.comments,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'status': status,
      'user': user.toJson(),
      'images': images,
      'topic': topic.toMap(),
      'reacts': reacts.map((x) => x.toMap()).toList(),
      'createdAt': createdAt.millisecondsSinceEpoch,
      'comments': comments,
      'allowComment': allowComment,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['_id'],
      allowComment: map['allowComment'] ?? true,
      title: map['title'],
      content: map['content'],
      status: map['status'],
      user: User.fromJson(map['user']),
      images: List<String>.from(map['images'])
          .map((e) => AppConfigs.apiUrl + e)
          .toList(),
      topic: PostTopic.fromMap(map['topic']),
      reacts: List<React>.from(map['reacts']?.map((x) => React.fromMap(x))),
      createdAt: DateTime.parse(map['createdAt']),
      comments: map['commentCount'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));
}
