class OtpVerifyRequestModel {
  OtpVerifyRequestModel({
    required this.email,
    required this.otp,
    required this.hash,
  });
  late final String email;
  late final String otp;
  late final String hash;
  
  OtpVerifyRequestModel.fromJson(Map<String, dynamic> json){
    email = json['email'];
    otp = json['otp'];
    hash = json['hash'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['otp'] = otp;
    _data['hash'] = hash;
    return _data;
  }
}