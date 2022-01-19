import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mental_health/models/commutity/comment.dart';
import 'package:flutter_mental_health/models/commutity/post.dart';
import 'package:flutter_mental_health/services/data_provider.dart';
import 'package:flutter_mental_health/utils/socket_helper.dart';

class FullPostProvider extends ChangeNotifier {
  Post post;
  List<Comment> _commentList = [];
  bool isDisposed = false;
  bool isEditComment = false;
  String editCommentId = "";
  String editCommentContent = "";
  String postState = "Normal";
  TextEditingController commentPost = TextEditingController();

  FullPostProvider(this.post) {
    loadPostComment();
    SocketHelper().postSocket.emit("joinPost", post.id);
    SocketHelper().postSocket.on("commentReceived", receiveComment);
  }

  Future<void> deletePostById() async {
    try {
      await DataProvider().deletePostById(post.id);
    } on DioError catch (e) {
      print(e.response);
    }
  }

  Future updatePostCommentState(String postId, bool allowComment) async {
    try {
      await DataProvider().updatePostCommentState(postId, allowComment);
      post.allowComment = allowComment;
      notifyListeners();
    } on DioError catch (e) {
      print(e.response);
    }
  }

  @override
  void dispose() {
    SocketHelper().postSocket.emit("leavePost");
    isDisposed = true;
    super.dispose();
  }

  Future loadPostComment() async {
    try {
      _commentList = await DataProvider().getAllPostComment(post.id);
      notifyListeners();
    } on DioError catch (e) {
      print(e.response);
    }
  }

  List<Comment> get commentList {
    return _commentList;
  }

  Future sendComment() async {
    if (commentPost.text.isEmpty) return;
    SocketHelper()
        .postSocket
        .emit("commentSent", {"comment": commentPost.text.trim()});
    commentPost.clear();
  }

  receiveComment(dynamic comment) {
    if (isDisposed) return;
    final newComment = Comment.fromMap(comment as Map<String, dynamic>);
    if (newComment.parent.isEmpty) {
      _commentList.add(newComment);
    }
    //print("Comment: " + comment.toString());
    notifyListeners();
  }

  Future<void> deleteCommentById(String commentId) async {
    try {
      await DataProvider().deleteCommentById(post.id, commentId);
      _commentList.removeWhere((element) => element.commentId == commentId);
      notifyListeners();
    } on DioError catch (e) {
      print(e.response);
    }
  }

  Future<void> updateCommentById(String commentId, String comment) async {
    try {
      await DataProvider().updateCommentById(post.id, commentId, comment);
      isEditComment = false;
      editCommentId = "";
      editCommentContent = "";
      _commentList
          .firstWhere((element) => element.commentId == commentId)
          .comment = comment;
      notifyListeners();
    } on DioError catch (e) {
      print(e.response);
    }
  }
}
