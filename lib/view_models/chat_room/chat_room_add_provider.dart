import 'package:flutter/material.dart';
import 'package:flutter_mental_health/models/authentication/user.dart';
import 'package:flutter_mental_health/models/chat/room.dart';
import 'package:flutter_mental_health/services/data_repository.dart';
import 'package:flutter_mental_health/views/admin/widgets/show_snack_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatRoomAddProvider extends ChangeNotifier {
  List<String> _listUserId = [];
  List<String> get listUserId => _listUserId;
  List<Room> _listRoom = [];
  List<Room> get listRoom => _listRoom;
  Future<void> addUserToChatRoom(String idRoom, String userId) async {
    await DataRepository().addUserToChatRoom(idRoom, userId);

    notifyListeners();
  }

  Future<List<User>> getListUserOfChatRoom(String idRoom) async {
    List<User> listUser;
    listUser = await DataRepository().getListUserOfChatRoom(idRoom);
    for (var element in listUser) {
      _listUserId.add(element.id);
    }
    notifyListeners();

    return listUser;
  }

  Future<void> deleteRoom(String roomId) async {
    // _listRoom.removeWhere((element) => element.id == roomId);
    await DataRepository().deleteRoom(roomId);
    notifyListeners();
  }

  Future<List<Room>> getAllRoom() async {
    _listRoom = await DataRepository().getAllRoom();
    notifyListeners();
    return _listRoom;
  }
}
