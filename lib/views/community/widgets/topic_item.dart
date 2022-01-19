import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/app_configs.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/constants/format_date.dart';
import 'package:flutter_mental_health/models/commutity/post.dart';
import 'package:flutter_mental_health/services/data_repository.dart';
import 'package:flutter_mental_health/view_models/auth/auth_provider.dart';
import 'package:flutter_mental_health/view_models/community/community_provider.dart';
import 'package:flutter_mental_health/views/community/widgets/image_post.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class TopicItem extends StatefulWidget {
  final Post post;
  final bool? hasLiked;
  const TopicItem({
    Key? key,
    required this.post,
    this.hasLiked = false,
  }) : super(key: key);

  @override
  _TopicItemState createState() => _TopicItemState();
}

class _TopicItemState extends State<TopicItem> {
  final baseUrl = AppConfigs.apiUrl;
  @override
  Widget build(BuildContext context) {
    Future<bool> onLikeButtonTapped(bool isLiked) async {
      await context.read<CommunityProvider>().updatePostReact(
          widget.post.id, context.read<AuthProvider>().user.id);
      return !isLiked;
    }

    return Container(
      margin: EdgeInsets.only(
        right: 5.w,
        left: 5.w,
        top: 5.h,
      ),
      padding: EdgeInsets.symmetric(vertical: 11.h, horizontal: 15.w),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.kPopupBackgroundColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage:
                        NetworkImage(context.read<AuthProvider>().user.avatar),
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.post.topic.title,
                        style: TextConfigs.kText18w700Black,
                      ),
                      Text(
                        widget.post.user.fullname,
                        style: TextConfigs.kText18w400Black,
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                FormatDateTime.formatterTimeAndDate
                    .format(widget.post.createdAt),
                style: TextConfigs.kText14w400Black,
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Flexible(
            child: Text(
              widget.post.title,
              style: TextConfigs.kText18w700Black,
              maxLines: 2,
            ),
          ),
          Flexible(
            child: Text(
              widget.post.content,
              style: TextConfigs.kText14w400Black,
              maxLines: 3,
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          widget.post.images.isEmpty
              ? const SizedBox.shrink()
              : SizedBox(
                  height: 202.h,
                  child: PostImage(images: widget.post.images),
                ),
          SizedBox(
            height: 25.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              LikeButton(
                isLiked: widget.hasLiked,
                onTap: onLikeButtonTapped,
                likeBuilder: (isLike) {
                  return Icon(
                    isLike ? CupertinoIcons.heart_solid : CupertinoIcons.heart,
                    color:
                        isLike ? AppColors.kReactColor : AppColors.kIconColor,
                  );
                },
                likeCount: widget.post.reacts.length,
              ),
              SizedBox(
                width: 2.w,
              ),
              Text(
                'React',
                style: TextConfigs.kText14w400Grey,
              ),
              SizedBox(
                width: 27.w,
              ),
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset('assets/icons/ic_comment.svg'),
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                widget.post.comments.toString() + ' Commets',
                style: TextConfigs.kText14w400Grey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
