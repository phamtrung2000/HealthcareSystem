import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mental_health/views/notification/notification_item.dart';
import 'package:flutter_mental_health/view_models/notification/notification_provider.dart';
import 'package:flutter_mental_health/views/chat/chat_screen.dart';
import 'package:flutter_mental_health/view_models/auth/auth_provider.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  static const id = "NotificationScreen";

  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool _hasbeenPressed = false;

  @override
  void didChangeDependencies() {
    context.read<NotificationProvider>().loadNotification();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.kPopupBackgroundColor,
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios)),
            centerTitle: true,
            foregroundColor: AppColors.kBlackColor,
            backgroundColor: AppColors.kPopupBackgroundColor,
            //backgroundColor: Colors.transparent,
            elevation: 1,
            title: Text(
              "Notification",
              style: TextConfigs.kText24w400Black,
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      _hasbeenPressed = !_hasbeenPressed;
                    });
                  },
                  icon: Icon(Icons.notifications_off_sharp,
                      size: 30.sp,
                      color: _hasbeenPressed
                          ? AppColors.kTouchButtonNotification
                          : AppColors.kButtonNotification)),
            ]),
        body:
            Consumer<NotificationProvider>(builder: (context, provider, title) {
          return ListView.builder(
              itemCount: provider.notificationList.length,
              itemBuilder: (context, index) {
                return Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: AppColors.kGreyTextTouchableColor,
                                width: 1.w))),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).pushNamed(
                            provider.notificationList[index].screen_id);
                      },
                      child: ListTile(
                        title: NotificationItem(
                            senderAvatar:
                                provider.notificationList[index].senderAvatar,
                            type: provider.notificationList[index].type,
                            body: provider.notificationList[index].body,
                            screen_id:
                                provider.notificationList[index].screen_id),
                      ),
                    ));
              });
        }));
  }
}
