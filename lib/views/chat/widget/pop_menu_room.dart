import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/services/data_repository.dart';
import 'package:flutter_mental_health/view_models/chat_room/chat_room_add_provider.dart';
import 'package:flutter_mental_health/views/chat/chat_admin_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/src/provider.dart';

class MyPopRoomButton extends StatelessWidget {
  MyPopRoomButton({required this.roomId, Key? key}) : super(key: key);
  String roomId;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: PopupMenuButton(
        icon: Icon(Icons.more_vert, size: 35.w, color: AppColors.kIconColor),
        itemBuilder: (context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'Delete',
            child: Text(
              'Delete',
            ),
          ),
        ],
        onSelected: (value) async {
          switch (value) {
            case 'Delete':
              await context.read<ChatRoomAddProvider>().deleteRoom(roomId);
              await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Success'),
                      content: Text('Delete room success!'),
                      actions: <Widget>[
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Close')),
                      ],
                    );
                  });
              // await context.read<ChatRoomAddProvider>().getAllRoom();
              break;
            default:
          }
        },
      ),
    );
  }
}
