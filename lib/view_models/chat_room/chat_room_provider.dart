import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mental_health/models/chat/room.dart';
import 'package:flutter_mental_health/services/data_repository.dart';
import 'package:flutter_mental_health/views/admin/widgets/show_snack_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatRoomProvider extends ChangeNotifier {
  Future<void> createRoom(String room, int role, File file) async {
    await DataRepository().createRoom(room, role, file);

    notifyListeners();
  }

  Future<void> createRoomWithOutAvatar(String room, int role) async {
    await DataRepository().createRoomWithOutAvatar(room, role);

    notifyListeners();
  }

  // Future<List<Room>> getAllRoom() async {
  //   await DataRepository().getAllRoom();

  //   notifyListeners();
  // }
}
