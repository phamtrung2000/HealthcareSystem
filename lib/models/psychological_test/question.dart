import 'dart:convert';

class Question {
  final String content;
  Question({
    required this.content,
  });

  Question copyWith({
    String? content,
  }) {
    return Question(
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      content: map['content'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));

  @override
  String toString() => 'Question(content: $content)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Question && other.content == content;
  }

  @override
  int get hashCode => content.hashCode;
}
