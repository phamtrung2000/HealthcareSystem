import 'package:flutter_mental_health/models/authentication/otp_verify_model.dart';
import 'package:flutter_mental_health/models/authentication/reset_password_model.dart';
import 'package:flutter_mental_health/models/authentication/user.dart';
import 'package:flutter_mental_health/models/commutity/comment.dart';
import 'package:flutter_mental_health/models/commutity/post.dart';
import 'package:flutter_mental_health/models/commutity/post_topic.dart';
import 'package:flutter_mental_health/models/commutity/react.dart';
import 'package:flutter_mental_health/models/feedback_model.dart';
import 'package:flutter_mental_health/models/notification/notification_of_user.dart';
import 'package:flutter_mental_health/models/help_center/help_center.dart';
import 'package:flutter_mental_health/models/psychological_test/psychological_test.dart';
import 'package:flutter_mental_health/models/psychological_test/question.dart';
import 'package:flutter_mental_health/models/psychological_test/question_detail.dart';
import 'package:flutter_mental_health/models/reports/problem_report.dart';
import 'package:flutter_mental_health/models/reports/user_report.dart';
import 'package:flutter_mental_health/services/data_repository.dart';
import 'package:flutter_mental_health/models/authentication/user.dart';
import 'dart:convert';

import 'package:flutter/cupertino.dart';

class DataProvider {
  static final DataProvider _singleton = DataProvider._internal();

  factory DataProvider() {
    return _singleton;
  }

  DataProvider._internal();

  Future<List<String>> getProblemReportType() async {
    final response = await DataRepository().getProblemReportType();

    final result = (response.data["data"] as List)
        .map((e) => e["name"] as String)
        .toList();

    return result;
  }

  Future<void> submitProblemReport(
      {required ProblemReportType problemReportType,
      required String description,
      required List<Map<String, dynamic>> files,
      required String userID}) async {
    final response = await DataRepository().submitProblemReport(
        problemReportType: problemReportType.value,
        description: description,
        files: files,
        userID: userID);
  }

  //User Report
  Future<void> submitUserReport({
    required UserReportType userReportType,
    required bool? receiveEmail,
    required String reportedUserID,
    required String userID,
  }) async {
    final response = await DataRepository().submitUserReport(
        userReportType: userReportType.value,
        receiveEmail: receiveEmail,
        reportedUserID: reportedUserID,
        userID: userID);
  }

  // Question
  Future<List<Question>> getAllQuestion() async {
    final response = await DataRepository().getAllQuestion();

    final jsonResultList = (response.data["data"] as List);
    List<Question> questionList = jsonResultList
        .map((questionJson) => Question.fromMap(questionJson))
        .toList();
    return questionList;
  }

  //Psychological Test
  Future<List<PsychologicalTest>> getAllPsychologicalTest() async {
    final response = await DataRepository().getAllPsychologicalTest();

    final jsonResultList = (response.data["data"] as List);
    List<PsychologicalTest> psychologicalTestList = jsonResultList
        .map((psychologicalTestJson) =>
            PsychologicalTest.fromMap(psychologicalTestJson))
        .toList();
    return psychologicalTestList;
  }

  //Psychological Test
  Future<void> submitPsychologicalTest({
    required int point,
    required List<QuestionDetail> questionDetailList,
    required String userID,
  }) async {
    final response = await DataRepository().submitPsychologicalTest(
      point: point,
      questionDetailList: questionDetailList,
      userID: userID,
    );
  }

  //Post
  Future<List<Post>> getAllPost() async {
    final response = await DataRepository().getAllPost();

    final jsonResultList = (response!.data["data"] as List);
    List<Post> postList =
        jsonResultList.map((postList) => Post.fromMap(postList)).toList();
    return postList;
  }

  //Post
  Future<void> submitPost(
      {required String title,
      required String content,
      required String topicId,
      required bool allowComment,
      required List<String> imageUrls}) async {
    final response = await DataRepository().submitPost(
        title: title,
        content: content,
        topicId: topicId,
        imageUrls: imageUrls,
        allowComment: allowComment
        //imageUrls: imageUrls
        );
  }

  //Post Topic
  Future<List<PostTopic>> getAllPostTopic() async {
    final response = await DataRepository().getAllPostTopic();

    final jsonResultList = (response!.data["data"] as List);
    List<PostTopic> postTopicList = jsonResultList
        .map((postTopic) => PostTopic.fromMap(postTopic))
        .toList();
    return postTopicList;
  }

  //Post Topic
  Future<List<Comment>> getAllPostComment(String postId) async {
    final response = await DataRepository().getAllPostComment(postId);

    final jsonResultList = (response!.data["data"] as List);
    List<Comment> commentList =
        jsonResultList.map((postTopic) => Comment.fromMap(postTopic)).toList();
    return commentList;
  }

  // delete comment by id
  Future<void> deleteCommentById(String postId, String commentId) async {
    await DataRepository().deleteCommentById(postId, commentId);
  }

  // update comment by id
  Future<void> updateCommentById(
      String postId, String commentId, String comment) async {
    await DataRepository().updateCommentById(postId, commentId, comment);
  }

  // get all comment reply
  Future<List<Comment>> getAllCommentReply(
      String postId, String commentId) async {
    final response =
        await DataRepository().getAllCommentReply(postId, commentId);

    var commentReplyList = (response!.data["data"] as List)
        .map((e) => Comment.fromMap(e))
        .toList();
    return commentReplyList;
  }

  //Post React
  Future<void> updatePostReact(String postId) async {
    final response = await DataRepository().updatePostReact(postId);
  }

  //HelpCenterTopic
  Future<List<HelpCenterTopic>> getAllHelpCenterTopics() async {
    final response = await DataRepository().getHelpCenterTopic();
    final jsonHelpCenterTopic = (response.data["data"] as List);
    List<HelpCenterTopic> helpCenterTopicList = jsonHelpCenterTopic
        .map((helpCenterTopic) => HelpCenterTopic.fromMap(helpCenterTopic))
        .toList();
    return helpCenterTopicList;
  }

  Future<void> resetPassword(String email, String password) async {
    final response = await DataRepository()
        .resetPassword(ResetPasswordModel(email: email, password: password));
  }

  Future<String> sendOTP(String email) async {
    final response = await DataRepository().sendOTP(email: email);

    final result = (response.data["hash"] as String);
    return result;
  }

  Future<String> verifyOTP(String email, String otp, String hash) async {
    final response = await DataRepository()
        .verifyOTP(OtpVerifyRequestModel(email: email, otp: otp, hash: hash));

    final result = (response.data["data"] as String);
    return result;
  }

  Future<List<User>> getUsersByKeyword(String keyword) async {
    final response = await DataRepository().getUsersByKeyword(keyword: keyword);

    final jsonAllUser = (response.data["data"] as List);
    List<User> users =
        jsonAllUser.map((users) => User.fromJson(users)).toList();
    return users;
  }

  Future<List<NotificationOfUser>> getAllNotification(String userID) async {
    final response = await DataRepository().getAllNotification(userID);
    final jsonNotification = (response.data["data"] as List);
    List<NotificationOfUser> notificationList = jsonNotification
        .map((notification) => NotificationOfUser.fromMap(notification))
        .toList();
    return notificationList;
  }

  Future<void> submitDailyCheckin({
    required String userID,
    required DateTime date,
    required String feel,
    required String description,
  }) async {
    final response = await DataRepository().submitDailyCheckin(
      userID: userID,
      date: date,
      feel: feel,
      description: description,
    );
  }

  //delte post by id
  Future<void> deletePostById(String postId) async {
    await DataRepository().deletePostById(postId);
  }

  //update post comment state
  Future updatePostCommentState(String postId, bool allowComment) async {
    await DataRepository().updatePostCommentState(postId, allowComment);
  }

  Future<List<User>> getAllUsers() async {
    final response = await DataRepository().getAllUser();
    final jsonAllUser = (response.data["data"] as List);
    List<User> allUser =
        jsonAllUser.map((users) => User.fromJson(users)).toList();
    //print(allUser);
    return allUser;
  }

  Future<List<FeedbackModel>> getFeedbackHistory(String userID) async {
    final response = await DataRepository().getFeedbackHistory(userID: userID);

    final result = (response.data["data"] as List);

    List<FeedbackModel> data =
        result.map((e) => FeedbackModel.fromMap(e)).toList();
    return data;
  }

  Future<FeedbackModel> getFeedback(String id) async {
    final response = await DataRepository().getFeedback(id: id);

    final result = response.data["data"];

    FeedbackModel data = FeedbackModel.fromMap(result);
    return data;
  }

  Future<bool> addFeedback(FeedbackModel model) async {
    final response = await DataRepository().addFeedback(model: model);

    final result = (response.data["success"] as bool);
    return result;
  }

  Future<bool> editFeedback(String id, FeedbackModel model) async {
    final response = await DataRepository().editFeedback(id: id, model: model);

    final result = (response.data["success"] as bool);
    return result;
  }

  Future<bool> deleteFeedback(String id) async {
    final response = await DataRepository().deleteFeedback(id: id);

    final result = (response.data["success"] as bool);
    return result;
  }

  //change password
  Future<bool> changePw({
    required String email,
    required String currentPassword,
    required String password,
    required String retypePassword,
  }) async {
    final response = await DataRepository().changePw(
        email: email,
        currentPassword: currentPassword,
        password: password,
        retypePassword: retypePassword);

    final result = (response.data['success'] as bool);
    return result;
  }

  Future<void> updateUserById(
      {required String userId,
      required String gender,
      required String avatar}) async {
    final response = await DataRepository()
        .updateUserById(userId: userId, gender: gender, avatar: avatar);
  }
}
