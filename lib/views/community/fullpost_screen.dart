// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_group_sliver/flutter_group_sliver.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/view_models/auth/auth_provider.dart';
import 'package:flutter_mental_health/view_models/community/community_provider.dart';
import 'package:flutter_mental_health/view_models/community/full_post_provider.dart';
import 'package:flutter_mental_health/views/community/comment_reply_screen.dart';
import 'package:flutter_mental_health/views/community/widgets/comment_item.dart';

import 'package:flutter_mental_health/views/community/widgets/post_info.dart';
import 'package:flutter_mental_health/views/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';

class FullPostScreen extends StatefulWidget {
  static const id = "FullPostScreen";

  const FullPostScreen({Key? key}) : super(key: key);

  @override
  _FullPostScreenState createState() => _FullPostScreenState();
}

class _FullPostScreenState extends State<FullPostScreen> {
  void showBottomDialog(
      BuildContext thisContext, VoidCallback onCommentPostStatePress) {
    showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
      ),
      context: thisContext,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.kPopupBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.h),
              topRight: Radius.circular(15.h),
            ),
          ),
          padding:
              EdgeInsets.only(left: 15.w, right: 15, top: 10.h, bottom: 10.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  thisContext.read<FullPostProvider>().deletePostById();
                  Navigator.pop(context);
                  Navigator.pop(context, "Delete Post");
                },
                child: Container(
                  color: AppColors.kPopupBackgroundColor,
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 20.w,
                          height: 20.h,
                          child: SvgPicture.asset(
                              'assets/icons/ic_recyclebin.svg')),
                      SizedBox(
                        width: 7.w,
                      ),
                      Text(
                        "Delete Post",
                        style: TextConfigs.kText14w400Black,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              GestureDetector(
                onTap: onCommentPostStatePress,
                child: Container(
                  color: AppColors.kPopupBackgroundColor,
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 20.w,
                          height: 20.h,
                          child:
                              SvgPicture.asset('assets/icons/ic_comment.svg')),
                      SizedBox(
                        width: 7.w,
                      ),
                      Text(
                        "Turn on/off commenting",
                        style: TextConfigs.kText14w400Black,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.h),
                      ))),
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: TextConfigs.kText12w400White,
                      )),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.kProfileInputColor,
        appBar: AppBar(
          backgroundColor: AppColors.kPopupBackgroundColor,
          title: Text('Post', style: TextConfigs.kText24w400Black),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.kBlackColor,
            ),
            onPressed: () => Navigator.pop(
                context, context.read<FullPostProvider>().postState),
          ),
          elevation: 1,
          actions: [
            context.read<FullPostProvider>().post.user.id ==
                    context.read<AuthProvider>().user.id
                ? Consumer<FullPostProvider>(
                    builder: (context, provider, child) {
                      return IconButton(
                        onPressed: () {
                          // onCommentPostStatePress
                          showBottomDialog(
                            context,
                            () {
                              provider.updatePostCommentState(provider.post.id,
                                  !provider.post.allowComment);
                              provider.postState = "Update";
                              Navigator.pop(context);
                            },
                          );
                        },
                        icon: SvgPicture.asset('assets/icons/ic_more.svg'),
                      );
                    },
                  )
                : SizedBox(width: 0.w)
          ],
        ),
        body: const FullPostBody(),
      ),
    );
  }
}

class FullPostBody extends StatefulWidget {
  const FullPostBody({
    Key? key,
  }) : super(key: key);
  @override
  _FullPostBodyState createState() => _FullPostBodyState();
}

class _FullPostBodyState extends State<FullPostBody> {
  late FocusNode focusNode;
  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final commentBoxController = TextEditingController();
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: PostInfo(
                onCommentPress: () {
                  focusNode.requestFocus();
                },
                image: context.read<FullPostProvider>().post.images,
              ),
            ),
            SliverGroupBuilder(
              margin: EdgeInsets.only(top: 10.h),
              decoration: BoxDecoration(
                color: AppColors.kPopupBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.h),
                  topRight: Radius.circular(10.h),
                ),
              ),
              child: Consumer<FullPostProvider>(
                builder: (context, provider, child) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: CommentItem(
                            editCommentPress: () {
                              Navigator.pop(context);
                              focusNode.requestFocus();
                              provider.commentPost.text =
                                  provider.commentList[index].comment;
                              provider.editCommentId =
                                  provider.commentList[index].commentId;
                              provider.isEditComment = true;
                            },
                            comment: provider.commentList[index],
                            pressReply: () {
                              Navigator.pushNamed(
                                context,
                                CommentReply.id,
                                arguments: CommentReplyAgrument(
                                    provider.commentList[index],
                                    provider.post.id,
                                    provider),
                              ).then(
                                (value) => setState(
                                  () {
                                    if (value.toString() ==
                                        "Delete Parent Comment") {
                                      provider.deleteCommentById(provider
                                          .commentList[index].commentId);
                                    } else if (value.toString() == "Normal") {
                                      //do nothing
                                    } else {
                                      // provider.updateCommentById(
                                      //     provider.commentList[index].commentId,
                                      //     value.toString());
                                      provider.loadPostComment();
                                    }
                                  },
                                ),
                              );

                              FocusScope.of(context).unfocus();
                            },
                            reply: true,
                          ),
                        );
                      },
                      childCount: provider.commentList.length,
                    ),
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 50.h,
              ),
            )
          ],
        ),
        Consumer<FullPostProvider>(
          builder: (context, provider, child) {
            return Visibility(
              visible: provider.post.allowComment,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.only(
                      top: 5.h, bottom: 5.h, left: 10.w, right: 5.w),
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.kBackgroundColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.h))),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 15.w),
                          child: TextField(
                            focusNode: focusNode,
                            controller:
                                context.read<FullPostProvider>().commentPost,
                            textCapitalization: TextCapitalization.sentences,
                            onChanged: (value) {},
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Input comment here...',
                            ),
                          ),
                        ),
                      ),
                      Consumer<FullPostProvider>(
                        builder: (context, provider, child) {
                          return IconButton(
                            icon: const Icon(Icons.send_rounded,
                                color: AppColors.kIconColor),
                            iconSize: 32.sp,
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              if (provider.isEditComment) {
                                provider.updateCommentById(
                                    provider.editCommentId,
                                    provider.commentPost.text);
                                FocusScope.of(context).unfocus();
                                provider.commentPost.clear();
                              } else {
                                provider.sendComment();
                                FocusScope.of(context).unfocus();
                              }
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
