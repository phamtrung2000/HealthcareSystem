class RegisterRequestModel {
  RegisterRequestModel({
    required this.fullname,
    required this.email,
    required this.gender,
    required this.password,
    required this.dateOfBirth,
  });
  late final String fullname;
  late final String email;
  late final String gender;
  late final String password;
  late final String dateOfBirth;

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    email = json['email'];
    gender = json['gender'];
    password = json['password'];
    dateOfBirth = json['dateOfBirth'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['fullname'] = fullname;
    _data['email'] = email;
    _data['gender'] = gender;
    _data['password'] = password;
    _data['dateOfBirth'] = dateOfBirth;
    return _data;
  }
}
