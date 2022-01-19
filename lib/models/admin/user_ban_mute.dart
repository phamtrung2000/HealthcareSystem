// To parse this JSON data, do
//
//     final userBanMute = userBanMuteFromJson(jsonString);

import 'dart:convert';

UserBanMute userBanMuteFromJson(String str) =>
    UserBanMute.fromJson(json.decode(str));

String userBanMuteToJson(UserBanMute data) => json.encode(data.toJson());

class UserBanMute {
  UserBanMute({
    required this.userId,
    required this.reason,
    required this.banTime,
    this.notBan,
    required this.type,
  });

  String? userId;
  String reason;
  DateTime banTime;
  String? notBan;
  String type;

  factory UserBanMute.fromJson(Map<String, dynamic> json) => UserBanMute(
        userId: json["userID"],
        reason: json["reason"],
        banTime: DateTime.parse(json["banTime"]),
        notBan: json["notBan"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "userID": userId,
        "reason": reason,
        "banTime": banTime.toIso8601String(),
        "notBan": notBan,
        "type": type,
      };
}
