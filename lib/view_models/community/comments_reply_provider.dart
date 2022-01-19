import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mental_health/models/commutity/comment.dart';
import 'package:flutter_mental_health/models/commutity/post.dart';
import 'package:flutter_mental_health/services/data_provider.dart';
import 'package:flutter_mental_health/utils/socket_helper.dart';

class CommentReplyProvider extends ChangeNotifier {
  final String postId;
  List<Comment> _listCommentReply = [];
  late Comment _parentComment;
  bool isDisposed = false;
  bool isEditChildComment = false;
  bool isEditParentComment = false;
  String editCommentContent = "";
  String editCommentId = "";
  String commentState = "Normal";
  late Post _post;

  TextEditingController commentReply = TextEditingController();

  final String commentId;

  CommentReplyProvider(this.commentId, this.postId) {
    loadCommentDetails();
    SocketHelper().postSocket.on("commentReceived", receiveComment);
  }

  List<Comment> get listCommentReply {
    return _listCommentReply;
  }

  Comment get parentComment {
    return _parentComment;
  }

  set post(Post post) => _post = post;

  Post get post => _post;

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }

  void setParentComment(Comment parent) {
    _parentComment = parent;
  }

  Future loadCommentDetails() async {
    try {
      _listCommentReply =
          await DataProvider().getAllCommentReply(postId, commentId);
      notifyListeners();
    } on DioError catch (e) {
      print(e.response);
    }
  }

  void sendComment() {
    if (commentReply.text.isEmpty) return;
    SocketHelper().postSocket.emit("commentSent",
        {"comment": commentReply.text.trim(), "parent": commentId});
    commentReply.clear();
  }

  receiveComment(dynamic comment) {
    if (isDisposed) return;
    final newComment = Comment.fromMap(comment as Map<String, dynamic>);
    if (newComment.parent == commentId) {
      _listCommentReply.add(newComment);
    }
    //print("Comment: " + comment.toString());
    notifyListeners();
  }

  Future<void> deleteCommentById(String commentId) async {
    try {
      await DataProvider().deleteCommentById(postId, commentId);
      _listCommentReply
          .removeWhere((element) => element.commentId == commentId);
      notifyListeners();
    } on DioError catch (e) {
      print(e.response);
    }
  }

  Future<void> updateCommentById(String commentId, String comment) async {
    try {
      await DataProvider().updateCommentById(postId, commentId, comment);
      isEditChildComment = false;
      editCommentId = "";
      editCommentContent = "";
      _listCommentReply
          .firstWhere((element) => element.commentId == commentId)
          .comment = comment;
      notifyListeners();
    } on DioError catch (e) {
      print(e.response);
    }
  }

  Future<void> updateParentComment(String comment) async {
    await DataProvider().updateCommentById(postId, commentId, comment);
    isEditParentComment = false;
    editCommentId = "";
    editCommentContent = "";
    _parentComment.comment = comment;
    notifyListeners();
  }
}
