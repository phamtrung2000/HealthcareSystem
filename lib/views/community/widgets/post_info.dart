import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/constants/format_date.dart';
import 'package:flutter_mental_health/view_models/auth/auth_provider.dart';
import 'package:flutter_mental_health/view_models/community/community_provider.dart';
import 'package:flutter_mental_health/view_models/community/full_post_provider.dart';
import 'package:flutter_mental_health/views/community/widgets/image_post.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class PostInfo extends StatefulWidget {
  PostInfo({
    Key? key,
    required this.onCommentPress,
    required this.image,
  }) : super(key: key);

  final List<String> image;
  final VoidCallback onCommentPress;

  @override
  _PostInfoState createState() => _PostInfoState();
}

class _PostInfoState extends State<PostInfo> {
  @override
  Widget build(BuildContext context) {
    Future<bool> onLikeButtonTapped(bool isLiked) async {
      await context.read<CommunityProvider>().updatePostReact(
          context.read<FullPostProvider>().post.id,
          context.read<AuthProvider>().user.id);
      return !isLiked;
    }

    return Container(
      decoration: BoxDecoration(
          color: AppColors.kPopupBackgroundColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.h),
            bottomRight: Radius.circular(10.h),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                color: AppColors.kPopupBackgroundColor,
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(context
                              .read<FullPostProvider>()
                              .post
                              .user
                              .avatar),
                          backgroundColor: Colors.transparent,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Consumer<FullPostProvider>(
                          builder: (context, provider, _) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  provider.post.topic.title,
                                  style: TextConfigs.kText18w700Black,
                                ),
                                Text(
                                  provider.post.user.fullname,
                                  style: TextConfigs.kText18w400Black,
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                    Consumer<FullPostProvider>(
                      builder: (context, provider, child) {
                        return Text(
                          FormatDateTime.formatterTimeAndDate
                              .format(provider.post.createdAt),
                          style: TextConfigs.kText14w400Black,
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
          const Divider(
            height: 1,
            thickness: 1,
            color: AppColors.kGreyTextTouchableColor,
          ),
          Container(
              margin: EdgeInsets.only(
                  left: 24.w, right: 24.w, bottom: 20.h, top: 5.h),
              child: Consumer<FullPostProvider>(
                builder: (context, provider, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        provider.post.title,
                        style: TextConfigs.kText20w400Black.copyWith(
                            fontWeight: FontWeight.w700, fontSize: 24.sp),
                        maxLines: 2,
                      ),
                      Text(
                        provider.post.content,
                        style: TextConfigs.kText20w400Black,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      widget.image.isEmpty
                          ? const SizedBox.shrink()
                          : SizedBox(
                              height: 202.h,
                              child: PostImage(images: widget.image),
                            ),
                    ],
                  );
                },
              )),
          const Divider(
            height: 1,
            thickness: 1,
            color: AppColors.kGreyTextTouchableColor,
          ),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: LikeButton(
                      onTap: onLikeButtonTapped,
                      isLiked: context.read<CommunityProvider>().checkReact(
                          context.read<FullPostProvider>().post.reacts,
                          context.read<AuthProvider>().user.id),
                      likeBuilder: (bool isLike) {
                        return Icon(
                          isLike
                              ? CupertinoIcons.heart_solid
                              : CupertinoIcons.heart,
                          color: isLike
                              ? AppColors.kReactColor
                              : AppColors.kIconColor,
                        );
                      },
                      likeCount:
                          context.read<FullPostProvider>().post.reacts.length,
                    ),
                  ),
                ),
                const VerticalDivider(
                  thickness: 1,
                  color: AppColors.kGreyTextTouchableColor,
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: widget.onCommentPress,
                    child: Container(
                      color: AppColors.kPopupBackgroundColor,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/icons/ic_comment.svg'),
                          SizedBox(
                            width: 7.w,
                          ),
                          Text(
                            "Comment",
                            style: TextConfigs.kText14w400Black,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
