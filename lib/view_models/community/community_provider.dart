import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mental_health/models/commutity/post.dart';
import 'package:flutter_mental_health/models/commutity/post_topic.dart';
import 'package:flutter_mental_health/models/commutity/react.dart';
import 'package:flutter_mental_health/services/data_provider.dart';

class CommunityProvider extends ChangeNotifier {
  List<Post> _mainList = [];
  List<Post> _postList = [];
  List<PostTopic> _postTopicList = [];
  late List<PostTopic> _postTopicListNoAll;
  String _searchString = "";

  UnmodifiableListView<PostTopic> get postTopicList => _searchString.isEmpty
      ? UnmodifiableListView(_postTopicList)
      : UnmodifiableListView(_postTopicList.where((postTopic) =>
          postTopic.title.toLowerCase().contains(_searchString)));

  void changeSearchString(String searchString) {
    _searchString = searchString.toLowerCase();
    notifyListeners();
  }

  List<PostTopic> get postTopicListNoAll {
    return _postTopicListNoAll;
  }

  Future updatePostReact(String postId, String userId) async {
    try {
      await DataProvider().updatePostReact(postId);
      updateLocalPostReact(postId, userId);
    } on DioError catch (e) {
      print(e.message);
    }
  }

  Future updatePostCommentState(String postId, bool allowComment) async {
    try {
      postList
          .firstWhere((element) => element.id == postId)
          .copyWith(allowComment: allowComment);
      notifyListeners();
    } on DioError catch (e) {
      print(e.response);
    }
  }

  void updateLocalPostReact(String postId, String userId) {
    final post = _postList.firstWhere((element) => element.id == postId);
    if (checkReact(post.reacts, userId)) {
      post.reacts.removeWhere((element) => element.user == userId);
    } else {
      post.reacts.add(React(user: userId));
    }
    notifyListeners();
  }

  void filterPostByTopic(String topicId) {
    if (!topicId.isEmpty) {
      _postList = _mainList
          .where((element) => element.topic.topicID == topicId)
          .toList();
    } else {
      _postList = _mainList;
    }
    notifyListeners();
  }

  bool checkReact(List<React> reacts, String userId) {
    return reacts.any((react) => react.user == userId);
  }

  CommunityProvider() {
    getAllPost();
    getAllPostTopic();
  }

  List<Post> get postList {
    return _postList;
  }

  Post getPostById(String postId) {
    late Post post;
    _postList.forEach((element) {
      if (element.id == postId) {
        post = element;
      }
    });
    return post;
  }

  Future<void> refeshPost() async {
    await getAllPost();
  }

  Future getAllPost() async {
    _postList.clear();
    _mainList.clear();
    try {
      _postList = await DataProvider().getAllPost();
      _postList = _postList.reversed.toList();
      _mainList = _postList;
    } on DioError catch (e) {
      print("Get All Post Error + ${e.response}");
    }
    notifyListeners();
  }

  Future getAllPostTopic() async {
    try {
      _postTopicListNoAll = await DataProvider().getAllPostTopic();
      _postTopicList = _postTopicListNoAll.reversed.toList();
      _postTopicList.add(PostTopic(topicID: "", title: "All"));
      _postTopicList = _postTopicList.reversed.toList();
    } on DioError catch (e) {
      print("Get All Post Topic Error + ${e.response}");
    }
    notifyListeners();
  }

  void deletePostById(String postId) {
    _postList.removeWhere((post) => post.id == postId);
    notifyListeners();
  }
}
