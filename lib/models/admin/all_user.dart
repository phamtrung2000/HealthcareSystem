import 'dart:convert';

import 'package:flutter_mental_health/models/authentication/user.dart';

AllUser allUserFromJson(String str) => AllUser.fromJson(json.decode(str));

String allUserToJson(AllUser data) => json.encode(data.toJson());

class AllUser {
  AllUser({
    required this.data,
    required this.message,
  });

  List<User> data;
  String message;

  factory AllUser.fromJson(Map<String, dynamic> json) => AllUser(
        data: List<User>.from(json["data"].map((x) => User.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}
