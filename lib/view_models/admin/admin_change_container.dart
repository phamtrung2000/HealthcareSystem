import 'package:flutter/material.dart';
import 'package:flutter_mental_health/models/commutity/post.dart';
import 'package:flutter_mental_health/services/data_repository.dart';
import 'package:flutter_mental_health/views/admin/widgets/show_snack_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangeContainer extends ChangeNotifier {
  bool _isPost = true;
  bool _isCollapsed = false;
  bool _isAscending = true;
  double _height = 156.h;
  String _selectDay = 'Ascending';
  List<Post> _postList = [];
  List<Post> _mainList = [];

  bool get isPost => _isPost;
  bool get isCollapsed => _isCollapsed;
  bool get isAscending => _isAscending;
  double get height => _height;
  String get selectDay => _selectDay;
  List<Post> get postList => _postList;

  void changeToPost(change) {
    _isPost = change;
    notifyListeners();
  }

  void collapsed() {
    _isCollapsed = true;
    _height = 30.0.h;
    notifyListeners();
  }

  void expand() {
    _isCollapsed = false;
    _height = 156.0.h;
    notifyListeners();
  }

  Future<void> deletePost(String id) async {
    _postList.removeWhere((element) => element.id == id);
    await DataRepository().deletePost(id);

    notifyListeners();
  }

  Future<void> acceptPost(String id) async {
    _postList.removeWhere((element) => element.id == id);

    await DataRepository().acceptPost(id, "1");

    notifyListeners();
  }

  void filterPostByTopic(String topicId) {
    if (topicId.isNotEmpty) {
      _postList = _mainList
          .where((element) => element.topic.topicID == topicId)
          .toList();
    } else {
      _postList = _mainList;
    }
    notifyListeners();
  }

  void filterPostByAscending() {
    _selectDay = "Ascending";
    _isAscending = true;
    _postList = _postList.reversed.toList();
    notifyListeners();
  }

  void filterPostByDescending() {
    _selectDay = "Descending";
    _isAscending = false;
    _postList = _postList.reversed.toList();
    notifyListeners();
  }

  Future<void> getAllPostPending() async {
    _selectDay = "Ascending";
    _isAscending = true;
    _postList = await DataRepository().getAllPostPending();
    _mainList = _postList;

    notifyListeners();
  }
}
