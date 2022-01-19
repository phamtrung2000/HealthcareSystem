import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/app_configs.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/models/chat/room.dart';
import 'package:flutter_mental_health/services/data_repository.dart';
import 'package:flutter_mental_health/view_models/auth/auth_provider.dart';
import 'package:flutter_mental_health/view_models/chat_room/chat_room_add_provider.dart';
import 'package:flutter_mental_health/views/chat/chat_screen.dart';
import 'package:flutter_mental_health/views/chat/create_chat_room_screen.dart';
import 'package:flutter_mental_health/views/chat/widget/room_item.dart';
import 'package:flutter_mental_health/views/onboard_screen/widgets/generic_loading_animation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/src/provider.dart';

class ChatRoomList extends StatefulWidget {
  const ChatRoomList({Key? key}) : super(key: key);
  static const id = "ChatRoomList";

  @override
  State<ChatRoomList> createState() => _ChatRoomListState();
}

class _ChatRoomListState extends State<ChatRoomList> {
  late Future<List<Room>> listRoom;
  @override
  void initState() {
    // TODO: implement initState
    listRoom = DataRepository().getAllRoom();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Chat',
            style: TextConfigs.kText24w400Black,
          ),
          backgroundColor: AppColors.kPopupBackgroundColor,
          elevation: 1,
          centerTitle: true,
          actions: [
            context.read<AuthProvider>().user.role == 1
                ? IconButton(
                    icon: SvgPicture.asset('assets/icons/add.svg'),
                    onPressed: () {
                      if (context.read<AuthProvider>().user.role == 1) {
                        Navigator.of(context)
                            .pushNamed(CreateChatRoomScreen.id);
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Thông báo'),
                                content: Text(
                                    'Bạn không có quyền để thao tác chức năng này!'),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Close')),
                                ],
                              );
                            });
                      }
                    },
                  )
                : SizedBox(),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () {
            setState(() {});
            return _reFreshListRoom();
          },
          child: FutureBuilder<List<Room>>(
              future: context.read<ChatRoomAddProvider>().getAllRoom(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: GenericLoadingAnimation(),
                  );
                } else {
                  // List<Datum> newDatum = snapshot.hasData;
                  return ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            await DataRepository().userJoinChatRoom(
                                snapshot.data![index].id,
                                context.read<AuthProvider>().user.id);

                            Navigator.of(context).pushNamed(ChatScreen.id,
                                arguments: ChatScreenArgument(
                                    snapshot.data![index].name,
                                    snapshot.data![index].id));
                          },
                          child: RoomItem(
                              roomName: snapshot.data![index].name,
                              avatar: snapshot.data![index].avatar,
                              roomId: snapshot.data![index].id),
                        );
                      });
                }
              }),
        ),
      ),
    );
  }

  Future<void> _reFreshListRoom() async {
    listRoom = DataRepository().getAllRoom();
  }
}
