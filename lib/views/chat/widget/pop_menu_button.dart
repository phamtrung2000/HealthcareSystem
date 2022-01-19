import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/views/chat/chat_admin_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyPopMenuButton extends StatelessWidget {
  MyPopMenuButton({required this.roomId, Key? key}) : super(key: key);
  String roomId;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: PopupMenuButton(
        icon: Icon(Icons.more_horiz, size: 35.w, color: AppColors.kIconColor),
        itemBuilder: (context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'Edit',
            child: Text(
              'Edit',
            ),
          ),
        ],
        onSelected: (value) async {
          switch (value) {
            case 'Edit':
              Navigator.of(context).pushNamed(ChatAdminController.id,
                  arguments: ChatAdminControllerArgument(roomId));

              break;
            default:
          }
        },
      ),
    );
  }
}
