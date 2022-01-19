import 'package:flutter/material.dart';
import 'package:flutter_mental_health/models/authentication/user.dart';
import 'package:flutter_mental_health/models/commutity/post.dart';
import 'package:flutter_mental_health/services/data_repository.dart';
import 'package:flutter_mental_health/views/admin/widgets/show_snack_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminProvider extends ChangeNotifier {
  String _searchUser = "";

  bool _isAdd = false;
  List<String> _listUserId = [];
  String get SearchUser => _searchUser;
  bool get isAdd => _isAdd;
  List<String> get listUserId => _listUserId;

  void OnChange(change) {
    _searchUser = change;
    notifyListeners();
  }

  //find user
  Future<List<User>>? Fututure() {
    if (_searchUser.isEmpty) {
      return DataRepository().fetchAllUser();
    } else if (_searchUser
        .contains(RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'))) {
      return DataRepository().SearchUser("", _searchUser);
    } else {
      return DataRepository().SearchUser(_searchUser, "");
    }
  }
}
