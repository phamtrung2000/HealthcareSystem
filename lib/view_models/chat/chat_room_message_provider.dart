import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mental_health/models/chat/chat_message.dart';
import 'package:flutter_mental_health/services/data_provider.dart';
import 'package:flutter_mental_health/utils/socket_helper.dart';

class ChatMessageProvider extends ChangeNotifier {
  List<ChatMessage> chatMessages = [];

  ChatMessageProvider() {
    SocketHelper().chatSocket.on("receive_message", receiveMessage);
    print("receive mess");
  }

  receiveMessage(dynamic message) {
    //print("Message: " + message.toString());
    //chatMessages.add(ChatMessage.fromMap(message as Map<String, dynamic>));
    print("Message: " + message.toString());
    print("check receive");
    chatMessages.add(ChatMessage.fromMap(message as Map<String, dynamic>));
    notifyListeners();
  }

  Future sendTextMessage(String content, String roomId) async {
    SocketHelper().chatSocket.emit("send_message",
        {"roomId": roomId, "content": content, "messageType": "TEXT"});
    print(content);
  }

  List<ChatMessage> get allMessage {
    SocketHelper().chatSocket.on("receive_message", receiveMessage);
    return chatMessages;
  }
}
