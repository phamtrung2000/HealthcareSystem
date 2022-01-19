import 'package:flutter/material.dart';
import 'package:flutter_mental_health/models/authentication/user.dart';
import 'package:flutter_mental_health/models/authentication/user.dart';
import 'package:flutter_mental_health/services/data_provider.dart';
import 'package:flutter_mental_health/services/data_repository.dart';
import 'package:flutter_mental_health/utils/socket_helper.dart';

class AuthProvider extends ChangeNotifier {
  late User _user;
  late String _token;
  late bool _isLoginWithFb;
  User get user => _user;
  String get token => _token;
  bool get isLoginWithFb => _isLoginWithFb;

  setUser(User user, String token) {
    _user = user;
    _token = token;
    DataRepository().accessToken = token;
    SocketHelper().connectPostSocket(token);
    SocketHelper().connectChatSocket(token);
    notifyListeners();
  }

  TextEditingController currentPassword = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController retypePassword = TextEditingController();

  onChange(change) {
    _isLoginWithFb = change;
    notifyListeners();
  }

  void changePw(
      Function showDialog,
      Function showDialog1,
      Function showDialog2,
      Function showDialog3,
      Function showDialog4,
      Function showDialog5,
      Function showDialog6) async {
    bool success = false;

    if (currentPassword.text.length < 1 ||
        password.text.length < 1 ||
        retypePassword.text.length < 1) {
      showDialog1();
    } else if (currentPassword.text == password.text) {
      showDialog4();
    } else if (!password.text.contains(RegExp('@')) &&
        !password.text.contains(RegExp('!')) &&
        !password.text.contains(RegExp('#')) &&
        !password.text
            .contains(RegExp('%')) /*&&!password.text.contains(RegExp(''))*/ &&
        !password.text.contains(RegExp('&')) &&
        !password.text.contains(RegExp('_')) &&
        !password.text.contains(RegExp('/')) &&
        !password.text.contains(RegExp('~'))) {
      showDialog5();
    } else if (password.text != retypePassword.text) {
      showDialog2();
    } else if (password.text.length < 8) {
      showDialog3();
    } else {
      success = await DataProvider().changePw(
          email: user.email,
          currentPassword: currentPassword.text,
          password: password.text,
          retypePassword: retypePassword.text);

      currentPassword.clear();
      password.clear();
      retypePassword.clear();
      showDialog();
      notifyListeners();
    }

    if (success) {
      print('Changed password');
    } else {
      showDialog6();
    }
  }
}
