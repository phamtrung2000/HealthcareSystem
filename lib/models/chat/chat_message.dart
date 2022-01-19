/*
import 'package:flutter/material.dart';

enum ChatMessageType {text, image, sticker}
enum MessageStatus {not_send, not_view, viewed}

class ChatMessage {
  final String text;
  final ChatMessageType messageType;
  final MessageStatus messageStatus;
  final bool isSender;
  final String name;
  final String avatar;

  ChatMessage({
    this.text = "",
    this.name = "",
    this.avatar = "",
    @required this.messageType = ChatMessageType.text,
    @required this.messageStatus = MessageStatus.not_view,
    @required this.isSender = false,
  });

}

List chatMessages = [
  ChatMessage(
      text: "Hello |61adef6a244d733e1dc4e3b0|",
      name: "Doctor",
      avatar: "assets/images/avatar.png",
      messageType: ChatMessageType.text,
      messageStatus: MessageStatus.viewed,
      isSender: false),
  ChatMessage(
      text: "How are you today ? How are you today ? How are you today ? How are you today ? How are you today ? How are you today ?",
      name: "Doctor",
      avatar: "assets/images/avatar.png",
      messageType: ChatMessageType.text,
      messageStatus: MessageStatus.viewed,
      isSender: false),
  ChatMessage(
      text: "Not really fine",
      name: "Me",
      avatar: "assets/images/avatar.png",
      messageType: ChatMessageType.text,
      messageStatus: MessageStatus.viewed,
      isSender: true),
  ChatMessage(
      text: "Can I help you ?",
      name: "Doctor",
      avatar: "assets/images/avatar.png",
      messageType: ChatMessageType.text,
      messageStatus: MessageStatus.viewed,
      isSender: false),
  ChatMessage(
      text: "Maybe....",
      name: "Me",
      avatar: "assets/images/avatar.png",
      messageType: ChatMessageType.text,
      messageStatus: MessageStatus.viewed,
      isSender: true),
  ChatMessage(
    text: "assets/images/this_person_does_not_exist.png",
    name: "Doctor",
    avatar: "assets/images/avatar.png",
    messageType: ChatMessageType.image,
    messageStatus: MessageStatus.viewed,
    isSender: false,
  ),
];*/
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_mental_health/models/authentication/user.dart';
import 'package:flutter_mental_health/view_models/chat/list_user_provider.dart';

enum ChatMessageType { text, image, sticker }

class ChatMessage {
  final String content;
  final ChatMessageType messageType;
  final bool isSender;
  final String userId;

  ChatMessage({
    required this.content,
    required this.messageType,
    required this.isSender,
    required this.userId,
  });

  ChatMessage copyWith({
    String? content,
    ChatMessageType? messageType,
    bool? isSender,
    String? userId,
  }) {
    return ChatMessage(
      content: content ?? this.content,
      messageType: messageType ?? this.messageType,
      isSender: isSender ?? this.isSender,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {

    return {
      'content': content,
      'messageType': messageType,
      'user': userId,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {

    ChatMessageType type = ChatMessageType.text;

    switch (map['messageType']){
      case 'TEXT':
        type = ChatMessageType.text;
        break;
      case 'IMAGE' :
        type = ChatMessageType.image;
        break;
      case 'STICKER': type =  ChatMessageType.sticker;
      break;
    }

    print(map['content']);
    print(map['messageType']);
    print(map['user']);
    return ChatMessage(
      content: map['content'],
      userId: map['user'],
      messageType: type,
      isSender: true,
      // imageUrls: List<String>.from(map['imageUrls']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessage.fromJson(String source) => ChatMessage.fromMap(json.decode(source));

}