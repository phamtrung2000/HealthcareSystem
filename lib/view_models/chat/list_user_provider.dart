import 'package:flutter_mental_health/models/authentication/user.dart';
import 'package:flutter_mental_health/services/data_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ListUserProvider extends ChangeNotifier {
  bool isLoad = true;

  List<User> users = <User>[];

  ListUserProvider() {
    users = <User>[];
    getAllUser();
  }

  Future getAllUser() async {
    List<User> users = await DataProvider().getAllUsers();
    for (User u in users) {
      this.users.add(u);
      // print(u.id);
    }
  }

  List<User>? get allUser {
    return this.users;
  }
}
