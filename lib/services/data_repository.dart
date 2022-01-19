import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_mental_health/configs/app_configs.dart';
import 'package:flutter_mental_health/constants/endpoints.dart';
import 'package:flutter_mental_health/models/admin/all_user.dart';
import 'package:flutter_mental_health/models/admin/user_ban_mute.dart';
import 'package:flutter_mental_health/models/authentication/login_request_model.dart';
import 'package:flutter_mental_health/models/authentication/login_with_fb_model.dart';
import 'package:flutter_mental_health/models/authentication/otp_signup_model.dart';
import 'package:flutter_mental_health/models/authentication/otp_verify_model.dart';
import 'package:flutter_mental_health/models/authentication/register_request_model.dart';
import 'package:flutter_mental_health/models/authentication/register_with_phone_model.dart';
import 'package:flutter_mental_health/models/authentication/reset_password_model.dart';
import 'package:flutter_mental_health/models/authentication/user.dart';
import 'package:flutter_mental_health/models/chat/room.dart';
import 'package:flutter_mental_health/models/commutity/comment.dart';
import 'package:flutter_mental_health/models/commutity/post.dart';
import 'package:flutter_mental_health/models/feedback_model.dart';
import 'package:flutter_mental_health/models/psychological_test/question_detail.dart';
import 'package:http/http.dart' as http;

class DataRepository {
  static final DataRepository _singleton = DataRepository._internal();

  factory DataRepository() {
    return _singleton;
  }

  DataRepository._internal();

  final baseUrl = AppConfigs.apiUrl;
  String? _accessToken;

  set accessToken(String? val) => _accessToken = val;

  Future<Response> getSomething() async {
    Dio _dio = Dio();
    Response response =
        await _dio.get("$baseUrl${AppEndpoints.exampleEndpoint}");
    return response;
  }

  Future<Response> getProblemReportType() async {
    Dio _dio = Dio();

    Response response =
        await _dio.get("$baseUrl${AppEndpoints.problemReportTypeEndpoint}");
    return response;
  }

  Future<Response> submitProblemReport({
    required int problemReportType,
    required String description,
    required List<Map<String, dynamic>> files,
    required String userID,
  }) async {
    Dio _dio = Dio();

    _dio.options.headers['Authorization'] = 'Bearer ' + _accessToken!;

    final data = {
      "problemReportType": problemReportType,
      "description": description,
      "files": files,
      "user": userID,
    };

    Response response = await _dio.post(
      "$baseUrl${AppEndpoints.submitProblemReport}",
      data: data,
    );
    return response;
  }

  Future<Response> submitUserReport({
    required int userReportType,
    required bool? receiveEmail,
    required String reportedUserID,
    required String userID,
  }) async {
    Dio _dio = Dio();

    _dio.options.headers['Authorization'] = 'Bearer ' + _accessToken!;

    final data = {
      "userReportType": userReportType,
      "receiveEmail": receiveEmail,
      "reportedUserID": reportedUserID,
      "user": userID
    };

    Response response = await _dio.post(
      "$baseUrl${AppEndpoints.submitUserReport}",
      data: data,
    );
    return response;
  }

  //get all the question for the psychological test
  Future<Response> getAllQuestion() async {
    Dio _dio = Dio();

    _dio.options.headers['Authorization'] = 'Bearer ' + _accessToken!;

    Response response = await _dio.get(
      "$baseUrl${AppEndpoints.questionEndpoint}",
    );
    return response;
  }

  var client = http.Client();
  var hash = "";

  Future<Map> login(LoginRequestModel model) async {
    Dio _dio = Dio();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse(AppConfigs.apiUrl + AppEndpoints.loginAPI);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    return jsonDecode(response.body);
  }

  Future<bool> register(RegisterRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse(AppConfigs.apiUrl + AppEndpoints.registerAPI);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> registerPhone(RegisterPhoneRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse(AppConfigs.apiUrl + AppEndpoints.registerAPI);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<Map> otp(OtpRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse(AppConfigs.apiUrl + AppEndpoints.otpAPI);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    return jsonDecode(response.body);
  }

  Future<bool> FindEmail(String email) async {
    Dio _dio = Dio();
    Response response = await _dio
        .post("{$baseUrl${AppEndpoints.findEmail}", data: {'email': email});
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<Map> loginWithFb(LoginWithFbRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse(AppConfigs.apiUrl + AppEndpoints.loginFbAPI);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    return jsonDecode(response.body);
  }

  // Future<List<Datum>> fetchAllTopic() async {
  //   Dio _dio = Dio();

  //   Response response = await _dio.get("$baseUrl${AppEndpoints.getAllTopic}");

  //   TopicModel topic = TopicModel.fromJson(response.data);
  //   return topic.data;
  // }

  Future<void> deletePost(String id) async {
    Dio _dio = Dio();

    await _dio.delete("$baseUrl${AppEndpoints.deletePost}$id");
    // print("$baseUrl${AppEndpoints.deletePost}$id");
  }

  Future<List<Post>> getAllPostPending() async {
    Dio _dio = Dio();

    Response response = await _dio.get("$baseUrl${AppEndpoints.getAllPost}");
    List<Post> postList = (response.data["data"] as List)
        .map((postList) => Post.fromMap(postList))
        .toList();
    // print(postList);

    return postList;
  }

  Future<List<User>> fetchAllUser() async {
    Dio _dio = Dio();

    Response response = await _dio.get("$baseUrl${AppEndpoints.getAllUser}");

    AllUser allUser = AllUser.fromJson(response.data);
    // print(response.data);
    return allUser.data;
  }

  Future<List<User>> SearchUser(String fullname, String email) async {
    Dio _dio = Dio();

    Response response = await _dio.get("$baseUrl${AppEndpoints.searchUser}",
        queryParameters: {'fullname': fullname, 'email': email});

    AllUser allUser = AllUser.fromJson(response.data);

    return allUser.data;
  }

  Future<void> banUser({required UserBanMute userBanMute}) async {
    Dio _dio = Dio();

    await _dio.post(
      "$baseUrl${AppEndpoints.banUser}",
      data: userBanMute.toJson(),
    );

    await _dio.delete(
      "$baseUrl${AppEndpoints.deleteAutoUserExpired}${userBanMute.userId}",
      data: "{\"banTime\": \"${userBanMute.banTime}\"}",
    );
  }

  Future<void> muteUser({required UserBanMute userBanMute}) async {
    Dio _dio = Dio();

    await _dio.post(
      "$baseUrl${AppEndpoints.muteUser}",
      data: userBanMute.toJson(),
    );

    await _dio.delete(
      "$baseUrl${AppEndpoints.deleteAutoUserExpired}${userBanMute.userId}",
      data: "{\"banTime\": \"${userBanMute.banTime}\"}",
    );
  }

  // accept post
  Future<void> acceptPost(String id, String role) async {
    Dio _dio = Dio();

    await _dio.post(
      "$baseUrl${AppEndpoints.acceptPost}",
      data: "{\"id\": \"$id\", \"role\": \"$role\"}",
    );
  }

  //get all the question for the psychological test
  Future<Response> getAllPsychologicalTest() async {
    Dio _dio = Dio();

    _dio.options.headers['Authorization'] = 'Bearer ' + _accessToken!;

    Response response = await _dio.get(
      "$baseUrl${AppEndpoints.psychologicalTestEndpoint}",
    );
    return response;
  }

  //submit Psychological Test
  Future<Response?> submitPsychologicalTest({
    required int point,
    required List<QuestionDetail> questionDetailList,
    required String userID,
  }) async {
    Dio dio = Dio();
    final data = {
      "questions": questionDetailList.map((e) => e.toMap()).toList(),
      "user": userID,
      "point": point,
    };

    Response? response;
    dio.options.headers['Authorization'] = 'Bearer ' + _accessToken!;
    try {
      response = await dio.post(
          "$baseUrl${AppEndpoints.psychologicalTestEndpoint}",
          data: data);
    } on DioError catch (e) {
      print(e);
    }

    return response;
  }

  //get all the Post
  Future<Response?> getAllPost() async {
    Dio _dio = Dio();

    _dio.options.headers['Authorization'] = 'Bearer ' + _accessToken!;

    Response? response;

    response = await _dio.get(
      "$baseUrl${AppEndpoints.postEndpoint}",
    );

    return response;
  }

  //submit the Post
  Future<Response?> submitPost(
      {required String title,
      required String content,
      required String topicId,
      required bool allowComment,
      required List<String> imageUrls}) async {
    Dio dio = Dio();
    final data = FormData.fromMap({
      "content": content,
      "title": title,
      "topic": topicId,
      "allowComment": allowComment,
      "images": imageUrls.map((e) => MultipartFile.fromFileSync(e)).toList(),
    });

    Response? response;
    dio.options.headers['Authorization'] = 'Bearer ' + _accessToken!;
    response =
        await dio.post("$baseUrl${AppEndpoints.postEndpoint}", data: data);

    return response;
  }

  //get all the Post
  Future<Response?> getAllPostTopic() async {
    Dio _dio = Dio();

    _dio.options.headers['Authorization'] = 'Bearer ' + _accessToken!;

    Response response = await _dio.get(
      "$baseUrl${AppEndpoints.postTopicEndpoint}",
    );
    return response;
  }

  //get all the Post Comment
  Future<Response?> getAllPostComment(String postId, {int page = 1}) async {
    Dio _dio = Dio();

    _dio.options.headers['Authorization'] = 'Bearer ' + _accessToken!;

    Response response = await _dio.get(
      "$baseUrl${AppEndpoints.postEndpoint}/$postId/comment?page=$page",
    );

    print(response);

    return response;
  }

  // get all comment reply in each post
  Future<Response?> getAllCommentReply(String postId, String commentId) async {
    Dio _dio = Dio();

    _dio.options.headers['Authorization'] = 'Bearer ' + _accessToken!;

    Response response = await _dio.get(
        "$baseUrl${AppEndpoints.postEndpoint}/$postId/comment/$commentId/children");
    return response;
  }

  // delete post comment by id
  Future<Response?> deleteCommentById(String postId, String commentId) async {
    Dio _dio = Dio();

    _dio.options.headers['Authorization'] = 'Bearer ' + _accessToken!;

    await _dio.delete(
        "$baseUrl${AppEndpoints.postEndpoint}/$postId/comment/$commentId");
  }

  // delete post comment by id
  Future<Response?> updateCommentById(
      String postId, String commentId, String comment) async {
    Dio _dio = Dio();

    _dio.options.headers['Authorization'] = 'Bearer ' + _accessToken!;

    final data = {'comment': comment};

    await _dio.patch(
        "$baseUrl${AppEndpoints.postEndpoint}/$postId/comment/$commentId",
        data: data);
  }

  //update the Post React
  Future<Response?> updatePostReact(String postId) async {
    Dio _dio = Dio();

    _dio.options.headers['Authorization'] = 'Bearer ' + _accessToken!;

    Response response = await _dio.post(
      "$baseUrl${AppEndpoints.postEndpoint}/$postId/react",
    );
    return response;
  }

  //get all help center topics
  Future<Response> getHelpCenterTopic() async {
    Dio _dio = Dio();

    Response response = await _dio.get("$baseUrl${AppEndpoints.getAllTopic}");
    //print(response.data);
    return response;
  }

  Future<Response> resetPassword(ResetPasswordModel model) async {
    Dio _dio = Dio();

    Response _response = await _dio
        .post("$baseUrl${AppEndpoints.resetPasswordAPI}", data: model.toJson());
    return _response;
  }

  Future<Response> sendOTP({required String email}) async {
    Dio _dio = Dio();

    Response _response = await _dio
        .post("$baseUrl${AppEndpoints.sendOTP}", data: {'email': email});
    return _response;
  }

  Future<Response> verifyOTP(OtpVerifyRequestModel model) async {
    Dio _dio = Dio();

    Response _response = await _dio.post("$baseUrl${AppEndpoints.otpVerifyAPI}",
        data: model.toJson());
    return _response;
  }

  Future<Response> getUsersByKeyword({required String keyword}) async {
    Dio _dio = Dio();
    _dio.options.headers['Authorization'] = 'Bearer ' + _accessToken!;

    Response _response = await _dio.get(
        "$baseUrl${AppEndpoints.getUsersByKeyword}",
        queryParameters: {'keyword': keyword});
    return _response;
  }

  Future<List<Room>> getAllRoom() async {
    Dio _dio = Dio();

    Response response = await _dio.get("$baseUrl${AppEndpoints.getAllRoom}");
    List<Room> roomList = (response.data["data"] as List)
        .map((roomList) => Room.fromJson(roomList))
        .toList();
    // print(postList);

    return roomList;
  }

  Future<void> createRoom(String room, int role, File file) async {
    Dio _dio = Dio();
    String fileName = file.path.split('/').last;
    final data = FormData.fromMap({
      "name": room,
      "avatar": await MultipartFile.fromFile(file.path, filename: fileName)
    });

    await _dio.post("$baseUrl${AppEndpoints.createRoom}$role", data: data);
  }

  Future<void> createRoomWithOutAvatar(String room, int role) async {
    Dio _dio = Dio();
    final data = FormData.fromMap({"name": room});

    await _dio.post("$baseUrl${AppEndpoints.createRoom}$role", data: data);
  }

  Future<void> userJoinChatRoom(String idRoom, String idUser) async {
    Dio _dio = Dio();

    await _dio.post("$baseUrl${AppEndpoints.userJoinChatRoom(idRoom, idUser)}");
  }

  Future<void> kickUserChatRoom(String idRoom, String userId) async {
    Dio _dio = Dio();
    final data = {"userID": userId};
    await _dio.delete("$baseUrl${AppEndpoints.kickUserChatRoom(idRoom)}",
        data: data);
  }

  Future<void> addUserToChatRoom(String idRoom, String userId) async {
    Dio _dio = Dio();
    final data = {"userID": userId};
    await _dio.post("$baseUrl${AppEndpoints.addUserToChatRoom(idRoom)}",
        data: data);
  }

  Future<void> userExitChatRoom(String idRoom, String idUser) async {
    Dio _dio = Dio();

    await _dio
        .delete("$baseUrl${AppEndpoints.userExitChatRoom(idRoom, idUser)}");
    // print("$baseUrl${AppEndpoints.userJoinChatRoom(idRoom, idUser)}");
  }

  Future<void> getReactMessage() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MWFkZjBiNmViZjRiZWQ4ZDdlYjJkZDMiLCJpYXQiOjE2Mzg4NjEwOTR9.66oB-qMgcZWcJWqqqb7zf5qT8kpKqkKWWsr0iBSP3BQ'
    };
    var url = Uri.parse(AppConfigs.apiUrl + AppEndpoints.getReactsOfMessage);

    await client.get(
      url,
      headers: requestHeaders,
    );
  }

  Future<List<User>> getListUserOfChatRoom(String id) async {
    Dio _dio = Dio();
    String url = AppEndpoints.getListUserOfChatRoom(id);
    Response response = await _dio.get("$baseUrl${url}");
    List<User> userList = (response.data["data"] as List).map((userList1) {
      return User.fromJson(userList1);
    }).toList();
    return userList;
  }

  //delete post by id
  Future<Response> deletePostById(String postId) async {
    Dio _dio = Dio();

    _dio.options.headers['Authorization'] = 'Bearer ' + _accessToken!;

    Response response =
        await _dio.delete("$baseUrl${AppEndpoints.postEndpoint}/$postId");

    return response;
  }

  Future<Response> getAllUser() async {
    Dio _dio = Dio();
    Response response = await _dio.get("$baseUrl${AppEndpoints.getAllUser}");
    //print(response.data);
    return response;
  }

  Future<Response> getFeedbackHistory({required String userID}) async {
    Dio _dio = Dio();
    _dio.options.headers['Authorization'] = 'Bearer ' + _accessToken!;
    //_dio.options.headers['Authorization'] = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MWFkZWY2YTI0NGQ3MzNlMWRjNGUzYjAiLCJpYXQiOjE2Mzg3ODkwNDF9.rrIrc55Xu8_PKifc2smLTCNQ7dzcNseyMpBhYpktEGA';

    Response _response =
        await _dio.get("$baseUrl${AppEndpoints.feedbackEndpoint}/user/$userID");
    return _response;
  }

  Future<Response> getFeedback({required String id}) async {
    Dio _dio = Dio();
    _dio.options.headers['Authorization'] = 'Bearer ' + _accessToken!;
    //_dio.options.headers['Authorization'] = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MWFkZWY2YTI0NGQ3MzNlMWRjNGUzYjAiLCJpYXQiOjE2Mzg3ODkwNDF9.rrIrc55Xu8_PKifc2smLTCNQ7dzcNseyMpBhYpktEGA';

    Response _response =
        await _dio.get("$baseUrl${AppEndpoints.feedbackEndpoint}/$id");
    return _response;
  }

  Future<Response> addFeedback({required FeedbackModel model}) async {
    Dio _dio = Dio();
    _dio.options.headers['Authorization'] = 'Bearer ' + _accessToken!;
    //_dio.options.headers['Authorization'] = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MWFkZWY2YTI0NGQ3MzNlMWRjNGUzYjAiLCJpYXQiOjE2Mzg3ODkwNDF9.rrIrc55Xu8_PKifc2smLTCNQ7dzcNseyMpBhYpktEGA';

    final _data = FormData.fromMap({
      'title': model.title,
      'description': model.description,
      'date': DateTime.now(),
      'images': model.files?.map((e) => MultipartFile.fromFileSync(e)).toList(),
    });

    Response _response = await _dio.post(
      "$baseUrl${AppEndpoints.feedbackEndpoint}",
      data: _data,
    );
    return _response;
  }

  Future<Response> editFeedback(
      {required String id, required FeedbackModel model}) async {
    Dio _dio = Dio();
    _dio.options.headers['Authorization'] = 'Bearer ' + _accessToken!;
    //_dio.options.headers['Authorization'] = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MWFkZWY2YTI0NGQ3MzNlMWRjNGUzYjAiLCJpYXQiOjE2Mzg3ODkwNDF9.rrIrc55Xu8_PKifc2smLTCNQ7dzcNseyMpBhYpktEGA';

    final _data = FormData.fromMap({
      'title': model.title,
      'description': model.description,
      'date': DateTime.now(),
      'images': model.files?.map((e) => MultipartFile.fromFileSync(e)).toList(),
    });

    Response _response = await _dio.patch(
      "$baseUrl${AppEndpoints.feedbackEndpoint}/$id",
      data: _data,
    );
    return _response;
  }

  Future<Response> deleteFeedback({required String id}) async {
    Dio _dio = Dio();
    _dio.options.headers['Authorization'] = 'Bearer ' + _accessToken!;
    //_dio.options.headers['Authorization'] = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MWFkZWY2YTI0NGQ3MzNlMWRjNGUzYjAiLCJpYXQiOjE2Mzg3ODkwNDF9.rrIrc55Xu8_PKifc2smLTCNQ7dzcNseyMpBhYpktEGA';

    Response _response =
        await _dio.delete("$baseUrl${AppEndpoints.feedbackEndpoint}/$id");
    return _response;
  }

  Future<void> deleteRoom(String id) async {
    Dio _dio = Dio();
    await _dio.delete("$baseUrl${AppEndpoints.deleteRoom}$id");
    //print(response.data);
  }

  Future<Response?> submitDailyCheckin({
    required String userID,
    required DateTime date,
    required String feel,
    required String description,
  }) async {
    Dio dio = Dio();
    final data = {
      "user": userID,
      "date": date.toIso8601String(),
      "feel": feel,
      "description": description,
    };
    Response? response;
    dio.options.headers['Authorization'] = 'Bearer ' + _accessToken!;
    response =
        await dio.post("$baseUrl${AppEndpoints.postDailyCheckin}", data: data);

    return response;
  }

  Future<Response> getAllNotification(String userID) async {
    Dio _dio = Dio();
    _dio.options.headers['Authorization'] = 'Bearer ' + _accessToken!;
    Response response = await _dio.get(
      "$baseUrl${AppEndpoints.notificationEndpoint}$userID",
    );
    return response;
  }

  Future<Response> changePw({
    required String email,
    required String currentPassword,
    required String password,
    required String retypePassword,
  }) async {
    Dio _dio = Dio();

    final data = {
      "email": email,
      "currentpassword": currentPassword,
      "password": password,
      "retypepassword": retypePassword,
    };

    Response response = await _dio.post(
      "$baseUrl${AppEndpoints.changePw}",
      data: data,
    );
    return response;
  }

  Future updatePostCommentState(String postId, bool allowComment) async {
    Dio _dio = Dio();

    _dio.options.headers['Authorization'] = 'Bearer ' + _accessToken!;

    final data = {'allowComment': allowComment};

    await _dio.patch(
        "$baseUrl${AppEndpoints.postEndpoint}/$postId/stateComment",
        data: data);
  }

  Future<Response?> updateUserById(
      {required String userId,
      required String gender,
      required String avatar}) async {
    Dio dio = Dio();

    final data = FormData.fromMap({
      "gender": gender,
      "avatar": MultipartFile.fromFileSync(avatar),
    });
    Response? response;
    dio.options.headers['Authorization'] = 'Bearer ' + _accessToken!;

    response = await dio.patch("$baseUrl${AppEndpoints.userEndpoint}$userId",
        data: data);

    return response;
  }
}
