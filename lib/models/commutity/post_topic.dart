import 'dart:convert';

class PostTopic {
  String topicID;
  String title;
  PostTopic({
    required this.topicID,
    required this.title,
  });

  PostTopic copyWith({
    String? topicID,
    String? title,
  }) {
    return PostTopic(
      topicID: topicID ?? this.topicID,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'topic': topicID,
    };
  }

  factory PostTopic.fromMap(Map<String, dynamic> map) {
    return PostTopic(
      topicID: map['_id'],
      title: map['title'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PostTopic.fromJson(String source) =>
      PostTopic.fromMap(json.decode(source));

  @override
  String toString() => 'PostTopic(topicID: $topicID, title: $title)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostTopic &&
        other.topicID == topicID &&
        other.title == title;
  }

  @override
  int get hashCode => topicID.hashCode ^ title.hashCode;
}
