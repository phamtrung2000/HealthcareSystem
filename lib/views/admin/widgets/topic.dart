import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/services/data_repository.dart';
import 'package:flutter_mental_health/view_models/admin/admin_change_container.dart';
import 'package:flutter_mental_health/view_models/auth/auth_provider.dart';
import 'package:flutter_mental_health/views/admin/widgets/ban_mute_user.dart';
import 'package:flutter_mental_health/views/admin/widgets/button.dart';
import 'package:flutter_mental_health/views/admin/widgets/hero_dialog_route.dart';
import 'package:flutter_mental_health/views/admin/widgets/show_dialog.dart';
import 'package:flutter_mental_health/views/admin/widgets/show_snack_bar.dart';
import 'package:flutter_mental_health/views/community/widgets/image_post.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/src/provider.dart';

class Topic extends StatefulWidget {
  String topicTitle;
  String fullName;
  String content;
  String id;
  String userId;
  String topic;
  String avatar;
  String email;
  List<String> images;
  Topic({
    required this.email,
    required this.avatar,
    required this.topic,
    required this.userId,
    required this.id,
    required this.content,
    required this.fullName,
    required this.topicTitle,
    required this.images,
    Key? key,
  }) : super(key: key);

  @override
  State<Topic> createState() => _TopicState();
}

class _TopicState extends State<Topic> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 414.w,
      // height: 234.h,
      color: AppColors.kPopupBackgroundColor,
      margin: EdgeInsets.only(top: 14.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 13.0.w, top: 11.0.h),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      HeroDialogRoute.id,
                      arguments: BanMuteUserArguments(widget.email,
                          widget.userId, widget.fullName, widget.avatar),
                    );
                  },
                  child: CircleAvatar(
                      backgroundColor: AppColors.kBackgroundColor,
                      backgroundImage: NetworkImage(widget.avatar)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 13.0.w, top: 14.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.topic, style: TextConfigs.kText18w700Black),
                    Text(widget.fullName, style: TextConfigs.kText18w400Black),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 21.0),
                child: myPopMenuButton(),
              ),
            ],
          ),
          Divider(
            color: AppColors.kBackgroundColor,
          ),
          Padding(
            padding: EdgeInsets.only(left: 21.0.w),
            child: Text(widget.topicTitle, style: TextConfigs.kText18w700Black),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0.h, left: 21.0.w, right: 21.0.w),
            child: Container(
              width: 372.w,
              height: 16.h,
              child: Text(widget.content),
            ),
          ),
          SizedBox(height: 9.h),
          Padding(
            padding: EdgeInsets.only(left: 21.0.w, right: 21.0.w),
            child: SizedBox(width: 372.w, height: 16.h),
          ),
          widget.images.isEmpty
              ? const SizedBox.shrink()
              : SizedBox(
                  height: 202.h,
                  child: Padding(
                    padding: EdgeInsets.only(left: 21.0.w, right: 21.0.w),
                    child: PostImage(images: widget.images),
                  ),
                ),
          Divider(
            color: AppColors.kBackgroundColor,
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.0.w),
                child: Container(
                  width: 180.0.w,
                  height: 43.0.h,
                  child: Button(
                    text: 'Decline',
                    color: AppColors.kButtonTopicDecline,
                    onClicked: () async {
                      // declinePost(widget.id);
                      await context
                          .read<ChangeContainer>()
                          .deletePost(widget.id);
                      Navigator.of(context)
                          .pushNamed(ShowDialog.id, arguments: "decline");
                    },
                  ),
                ),
              ),
              SizedBox(width: 15.w),
              Container(
                width: 180.0.w,
                height: 43.0.h,
                child: Button(
                  text: 'Accept',
                  color: AppColors.kButtonColor,
                  onClicked: () async {
                    await context.read<ChangeContainer>().acceptPost(widget.id);
                    Navigator.of(context)
                        .pushNamed(ShowDialog.id, arguments: "accept");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget myPopMenuButton() {
    return IconButton(
      onPressed: () {},
      icon: PopupMenuButton(
        icon: Icon(Icons.more_horiz),
        itemBuilder: (context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'decline',
            child: Text(
              'decline',
            ),
          ),
        ],
        onSelected: (value) async {
          switch (value) {
            case 'decline':
              await context.read<ChangeContainer>().deletePost(widget.id);
              Navigator.of(context)
                  .pushNamed(ShowDialog.id, arguments: "decline");
              break;
            default:
          }
        },
      ),
    );
  }
}
