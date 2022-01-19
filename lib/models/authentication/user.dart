import 'dart:convert';

import 'package:flutter_mental_health/services/data_repository.dart';

// username: nghiath@gmail.com
// password: 12345678@

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.phoneNumber,
    required this.id,
    required this.role,
    required this.fullname,
    required this.dateOfBirth,
    required this.email,
    required this.gender,
    required this.isVerifyEmail,
    required this.isVerifyPhone,
    required this.emailToken,
    required this.lastLogin,
    required this.lastLogout,
    required this.createdAt,
    required this.updatedAt,
    required this.avatar,
  });
  String id;
  int role;
  String fullname;
  DateTime dateOfBirth;
  String phoneNumber;
  String email;
  String gender;
  bool isVerifyEmail;
  bool isVerifyPhone;
  String emailToken;
  DateTime lastLogin;
  DateTime lastLogout;
  DateTime createdAt;
  DateTime updatedAt;
  String avatar;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        role: json["role"] ?? -1,
        avatar: (json["avatar"].toString().contains("https://") == true)
            ? json["avatar"]
            : "${DataRepository().baseUrl}/" + json["avatar"],
        fullname: json["fullname"],
        dateOfBirth:
            DateTime.parse(json["dateOfBirth"] ?? DateTime.now().toString()),
        email: ((json["email"] == null) ? "" : json["email"]) ?? "",
        phoneNumber:
            (json["phoneNumber"] == null) ? "" : json["phoneNumber"] ?? "",
        gender: json["gender"] ?? "",
        isVerifyEmail: json["isVerifyEmail"] ?? true,
        isVerifyPhone: json["isVerifyPhone"] ?? true,
        emailToken: json["emailToken"] ?? "",
        lastLogin:
            DateTime.parse(json["lastLogin"] ?? DateTime.now().toString()),
        lastLogout:
            DateTime.parse(json["lastLogout"] ?? DateTime.now().toString()),
        createdAt:
            DateTime.parse(json["createdAt"] ?? DateTime.now().toString()),
        updatedAt:
            DateTime.parse(json["updatedAt"] ?? DateTime.now().toString()),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "role": role,
        "fullname": fullname,
        "dateOfBirth": dateOfBirth.toIso8601String(),
        "email": email,
        "gender": gender,
        "isVerifyEmail": isVerifyEmail,
        "isVerifyPhone": isVerifyPhone,
        "emailToken": emailToken,
        "lastLogin": lastLogin.toIso8601String(),
        "lastLogout": lastLogout.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "avatar": avatar,
      };
}
