import 'package:flutter_mental_health/configs/app_configs.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketHelper {
  static final SocketHelper _singleton = SocketHelper._internal();
  late Socket postSocket;
  late Socket chatSocket;

  factory SocketHelper() {
    return _singleton;
  }

  SocketHelper._internal() {}

  void connectPostSocket(String token) {
    postSocket = io(
      /**
       * url: gồm apiUrl và namespace
       * Format: "<AppConfigs.apiUrl><namespace>"
       * Ví dụ: Nếu BE gọi io.of("/comments")
       * Thì ở đây namespace là "/comments"
       */
      "${AppConfigs.apiUrl}/posts",
      /**
       * Option: Để vậy là được, nếu set thêm các option khác thì thêm vào
       * Đọc docs của lib socket_io_client để biết thêm chi tiết
       */
      OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setQuery({'token': token})
          .build(),
    );
    //connect đến server
    postSocket.connect()
      ..onConnect((data) => print("postSocket Connect Successfully $data"))
      ..onError((data) => print("postSocket Connect Error $data"));
  }

  void clearPostSocket() {
    postSocket.disconnect();
    postSocket.close();
  }

  void connectChatSocket(String token) {
    chatSocket = io(
      "${AppConfigs.apiUrl}/chat",
      OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setQuery({'token': token})
          .build(),
    );
    //connect đến server
    chatSocket
        .connect()
        .onError((data) => print("chatSocket Connect Error $data"));
  }

  void clearChatSocket() {
    chatSocket.disconnect();
    chatSocket.close();
  }

}
