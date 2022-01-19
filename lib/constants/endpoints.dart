class AppEndpoints {
  static const exampleEndpoint = "/user";
  static const problemReportTypeEndpoint = "/report/problem/type2";
  static const String loginAPI = "/auth/login";
  static const String registerAPI = "/auth/register";
  static const String otpAPI = "/auth/otpSignup";
  static const String otpVerifyAPI = "/auth/verifyOTP";
  static const String loginFbAPI = "/auth/loginFb";
  static const String resetPasswordAPI = "/auth/changePass";
  static const String changePw = "/auth/changePw";
  static const String sendOTP = "/auth/sendOTP";
  static const submitProblemReport = "/report/problem";
  static const submitUserReport = "/report/user";
  static const psychologicalTestEndpoint = "/test/psychological";
  static const questionEndpoint = "/test/psychological/question";
  static const getAllTopic = "/topic";
  static const postTopicEndpoint = "/post/topic";
  static const postEndpoint = "/post";
  static const getAllPost = "/admin/getPost";
  static const deletePost = "/admin/delPost/1/";
  static const banUser = "/admin/ban";
  static const muteUser = "/admin/mute";
  static const deleteAutoUserExpired = "/admin/userBan/expired/";
  static const acceptPost = "/admin/acceptPost";
  static const getAllUser = "/admin/getUser";
  static const searchUser = "/admin/getUsersByFilter?";
  static const findEmail = "/auth/FindEmail";
  static const fetchUser = "/auth/getUserByEmail/";
  static const String getUsersByKeyword = "/user/search";
  static const String feedbackEndpoint = "/feedback";
  static const getAllRoom = "/chatroom/getAllRoom";
  static const createRoom = "/chatRoom/createRoom/";
  static String userJoinChatRoom(String idRoom, String idUser) =>
      '/chatRoom/$idRoom/join/$idUser';

  static String userExitChatRoom(String idRoom, String idUser) =>
      "/chatroom/$idRoom/exit/$idUser";
  static String kickUserChatRoom(String idRoom) =>
      "/chatroom/$idRoom/1/deleteUser";
  static String addUserToChatRoom(String idRoom) => "/chatroom/$idRoom/1/add";

  static const postDailyCheckin = "/chkin";
  static const getReactsOfMessage = "/chatroom/react/message_id/<message_id>";
  static String getListUserOfChatRoom(String id) =>
      "/chatroom/${id}/getListUser";

  static const notificationEndpoint = "/";
  static const userEndpoint = "/user/";
  static const deleteRoom = "/chatRoom/delRoom/1/";
}
