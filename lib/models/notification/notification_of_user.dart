import 'dart:convert';

import 'package:flutter_mental_health/models/authentication/user.dart';

class NotificationOfUser {
  final String senderAvatar;
  final int type;
  final String body;
  final String screen_id;
  final String title;
  NotificationOfUser({
    required this.senderAvatar,
    required this.type,
    required this.body,
    required this.screen_id,
    required this.title,
  });

  NotificationOfUser copyWith({
    String? senderAvatar,
    int? type,
    String? body,
    String? screen_id,
    String? title,
  }) {
    return NotificationOfUser(
      senderAvatar: senderAvatar ?? this.senderAvatar,
      type: type ?? this.type,
      body: body ?? this.body,
      screen_id: screen_id ?? this.screen_id,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderAvatar': senderAvatar,
      'type': type,
      'body': body,
      'screen_id': screen_id,
      'title': title,
    };
  }

  factory NotificationOfUser.fromMap(Map<String, dynamic> map) {
    return NotificationOfUser(
      senderAvatar: map['senderAvatar'],
      type: map['type'],
      body: map['body'],
      screen_id: map['screen_id'],
      title: map['title'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationOfUser.fromJson(String source) =>
      NotificationOfUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Comment(senderAvatar: $senderAvatar, type: $type, body: $body, screen_id: $screen_id, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationOfUser &&
        other.senderAvatar == senderAvatar &&
        other.type == type &&
        other.body == body &&
        other.screen_id == screen_id &&
        other.title == title;
  }

  @override
  int get hashCode {
    return senderAvatar.hashCode ^
        type.hashCode ^
        body.hashCode ^
        screen_id.hashCode ^
        title.hashCode;
  }
}
