import 'dart:io';

class LoginRequestModel {
  LoginRequestModel({
    required this.token,
    required this.email,
    required this.password,
  });
  late final String email;
  late final String password;
  late final String token;
  final String platform = Platform.isAndroid ? "android" : "ios";

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    token = json["token"];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['password'] = password;
    _data["platform"] = platform;
    _data["token"] = token;
    return _data;
  }
}
