import 'dart:convert';

import 'package:flutter_mental_health/models/authentication/user.dart';

class Comment {
  String commentId;
  User user;
  String comment;
  String parent;
  String postOriginal;
  DateTime createdAt;
  List<Comment> childCommentList;
  int childrenCount;
  Comment({
    required this.commentId,
    required this.childCommentList,
    required this.user,
    required this.childrenCount,
    required this.comment,
    required this.parent,
    required this.postOriginal,
    required this.createdAt,
  });

  Comment copyWith({
    User? user,
    String? comment,
    String? postOriginal,
    DateTime? createdAt,
    String? parent,
    String? commentId,
    int? childrenCount,
    List<Comment>? childCommentList,
  }) {
    return Comment(
      user: user ?? this.user,
      comment: comment ?? this.comment,
      childCommentList: childCommentList ?? this.childCommentList,
      childrenCount: childrenCount ?? this.childrenCount,
      parent: parent ?? this.parent,
      postOriginal: postOriginal ?? this.postOriginal,
      createdAt: createdAt ?? this.createdAt,
      commentId: comment ?? this.commentId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user.toJson(),
      'comment': comment,
      'parent': parent,
      'postOriginal': postOriginal,
      'createdAt': createdAt.millisecondsSinceEpoch,
      '_id': commentId,
      'children': childCommentList,
      'childrenCount': childrenCount
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      user: User.fromJson(map['user']),
      comment: map['comment'],
      postOriginal: map['postOriginal'],
      childrenCount: map['childrenCount'] ?? 0,
      childCommentList: List<Comment>.from(
          map['children']?.map((x) => Comment.fromMap(x)) ?? []),
      createdAt: DateTime.parse(map['createdAt']),
      commentId: map['_id'],
      parent: map['parent'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
}
