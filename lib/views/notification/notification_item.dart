import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/view_models/auth/auth_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationItem extends StatefulWidget {
  final int type;
  final String body;
  final String senderAvatar;
  final String screen_id;
  const NotificationItem({
    Key? key,
    required this.type,
    required this.body,
    required this.senderAvatar,
    required this.screen_id,
  }) : super(key: key);

  @override
  _NotificationItemState createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  Widget imageType() {
    String imagePath = "assets/images/global_noti.png";
    if (widget.type == 3) {
      imagePath = "assets/images/global_noti.png";
    }
    if (widget.type == 4) {
      imagePath = "assets/images/chat_noti.png";
    }
    if (widget.type == 1) {
      imagePath = "assets/images/tag_noti.png";
    }
    if (widget.type == 2) {
      imagePath = "assets/images/warn_noti.png";
    }
    return (Image(
      image: AssetImage(imagePath),
      fit: BoxFit.cover,
      height: 24.h,
      width: 24.w,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return (Container(
        child: Row(
      children: <Widget>[
        Stack(children: <Widget>[
          Container(
            height: 90.h,
            margin: EdgeInsets.only(right: 10.w),
            child: CircleAvatar(
              radius: 30.0,
              backgroundColor: AppColors.kPopupBackgroundColor,
              child: Image.network(
                widget.senderAvatar,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(top: 50.h, right: 5.w, child: imageType())
        ]),
        Container(
            child: Flexible(
                child: Text(widget.body, style: TextConfigs.kText16w400Black))),
      ],
    )));
  }
}
