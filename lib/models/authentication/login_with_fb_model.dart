class LoginWithFbRequestModel {
  LoginWithFbRequestModel({
    required this.fullname,
    required this.email,
    required this.gender,
    required this.dateOfBirth,
    required this.avatar,
  });
  late final String fullname;
  late final String email;
  late final String gender;
  late final String avatar;
  late final String dateOfBirth;

  LoginWithFbRequestModel.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    email = json['email'];
    gender = json['gender'];
    avatar = json['avatar'];
    dateOfBirth = json['dateOfBirth'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['fullname'] = fullname;
    _data['email'] = email;
    _data['gender'] = gender;
    _data['avatar'] = avatar;
    _data['dateOfBirth'] = dateOfBirth;
    return _data;
  }
}



