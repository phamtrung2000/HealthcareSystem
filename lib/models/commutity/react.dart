import 'dart:convert';

class React {
  String user;
  React({
    required this.user,
  });

  React copyWith({
    String? user,
  }) {
    return React(
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user,
    };
  }

  factory React.fromMap(Map<String, dynamic> map) {
    return React(
      user: map['user'],
    );
  }

  String toJson() => json.encode(toMap());

  factory React.fromJson(String source) => React.fromMap(json.decode(source));

  @override
  String toString() => 'React(user: $user)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is React && other.user == user;
  }

  @override
  int get hashCode => user.hashCode;
}
