import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_group_sliver/flutter_group_sliver.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/constants/format_date.dart';
import 'package:flutter_mental_health/models/commutity/comment.dart';
import 'package:flutter_mental_health/view_models/auth/auth_provider.dart';
import 'package:flutter_mental_health/view_models/community/comments_reply_provider.dart';
import 'package:flutter_mental_health/view_models/community/full_post_provider.dart';
import 'package:flutter_mental_health/views/community/fullpost_screen.dart';
import 'package:flutter_mental_health/views/community/widgets/comment_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CommentReply extends StatefulWidget {
  static const id = "CommentReplyScreen";

  const CommentReply({Key? key}) : super(key: key);

  @override
  _CommentReplyState createState() => _CommentReplyState();
}

class CommentReplyAgrument {
  final Comment parent;
  final String postId;
  final FullPostProvider fullPostProvider;

  CommentReplyAgrument(this.parent, this.postId, this.fullPostProvider);
}

class _CommentReplyState extends State<CommentReply> {
  @override
  Widget build(BuildContext context) {
    final CommentReplyAgrument parentComment =
        ModalRoute.of(context)!.settings.arguments as CommentReplyAgrument;
    context.read<CommentReplyProvider>().setParentComment(parentComment.parent);
    context.read<CommentReplyProvider>().post =
        parentComment.fullPostProvider.post;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.kPopupBackgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.kPopupBackgroundColor,
          title: Text('Replies', style: TextConfigs.kText24w400Black),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.kBlackColor,
            ),
            onPressed: () => Navigator.pop(
                context, context.read<CommentReplyProvider>().commentState),
          ),
          elevation: 1,
        ),
        body: BodyCommentReply(
          parent: parentComment.parent,
        ),
      ),
    );
  }
}

class BodyCommentReply extends StatefulWidget {
  const BodyCommentReply({
    Key? key,
    required this.parent,
  }) : super(key: key);

  final Comment parent;

  @override
  State<BodyCommentReply> createState() => _BodyCommentReplyState();
}

class _BodyCommentReplyState extends State<BodyCommentReply> {
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

  void showBottomDialog(BuildContext thisContext, VoidCallback onDeletePress) {
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
                onTap: onDeletePress,
                child: Container(
                  color: AppColors.kPopupBackgroundColor,
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20.w,
                        height: 20.h,
                        child:
                            SvgPicture.asset('assets/icons/ic_recyclebin.svg'),
                      ),
                      SizedBox(
                        width: 7.w,
                      ),
                      Text(
                        "Delete Comment",
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
                onTap: () {
                  focusNode.requestFocus();
                  thisContext.read<CommentReplyProvider>().commentReply.text =
                      widget.parent.comment;
                  thisContext.read<CommentReplyProvider>().isEditParentComment =
                      true;
                  thisContext.read<CommentReplyProvider>().editCommentId =
                      widget.parent.commentId;
                  Navigator.of(thisContext).pop();
                },
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
                        "Edit Comment",
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
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: GestureDetector(onLongPress: () {
                if (context.read<AuthProvider>().user.id ==
                    widget.parent.user.id) {
                  showBottomDialog(
                    context,
                    () {
                      context
                          .read<CommentReplyProvider>()
                          .deleteCommentById(widget.parent.commentId);
                      Navigator.pop(context);
                      Navigator.pop(context, "Delete Parent Comment");
                    },
                  );
                }
              }, child: Consumer<CommentReplyProvider>(
                builder: (context, provider, child) {
                  return Container(
                    padding: EdgeInsets.only(
                        top: 10.h, left: 10.w, right: 25.w, bottom: 10.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30.sp,
                              backgroundImage: NetworkImage(
                                  provider.parentComment.user.avatar),
                              backgroundColor: Colors.transparent,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              provider.parentComment.user.fullname,
                              style: TextConfigs.kText20w400Black.copyWith(
                                  fontWeight: FontWeight.w700, fontSize: 16.sp),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              FormatDateTime.formatterTimeAndDate
                                  .format(provider.parentComment.createdAt),
                              style: TextConfigs.kText20w400Black.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp,
                                  fontStyle: FontStyle.italic),
                            )
                          ],
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 70.w),
                          child: Text(provider.parentComment.comment,
                              style: TextConfigs.kText20w400Black
                                  .copyWith(fontSize: 16.sp)),
                        ),
                      ],
                    ),
                  );
                },
              )),
            ),
            SliverPadding(
              padding: EdgeInsets.only(left: 35.w),
              sliver: SliverGroupBuilder(
                margin: EdgeInsets.only(top: 10.h),
                decoration: BoxDecoration(
                  color: AppColors.kPopupBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.h),
                    topRight: Radius.circular(10.h),
                  ),
                ),
                child: Consumer<CommentReplyProvider>(
                  builder: (context, provider, child) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return CommentItem(
                            editCommentPress: () {
                              focusNode.requestFocus();
                              provider.isEditChildComment = true;
                              provider.editCommentId =
                                  provider.listCommentReply[index].commentId;
                              provider.commentReply.text =
                                  provider.listCommentReply[index].comment;
                              provider.commentState = "Update";
                              Navigator.pop(context);
                            },
                            comment: provider.listCommentReply[index],
                            pressReply: () {},
                            reply: false,
                          );
                        },
                        childCount: provider.listCommentReply.length,
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 35.h,
              ),
            )
          ],
        ),
        Visibility(
          visible: context.read<CommentReplyProvider>().post.allowComment,
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
                            context.read<CommentReplyProvider>().commentReply,
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: (value) {},
                        decoration: const InputDecoration.collapsed(
                          hintText: 'Input comment here...',
                        ),
                      ),
                    ),
                  ),
                  Consumer<CommentReplyProvider>(
                    builder: (context, provider, child) {
                      return IconButton(
                        icon: const Icon(Icons.send_rounded,
                            color: AppColors.kIconColor),
                        iconSize: 32.sp,
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          if (provider.isEditChildComment) {
                            provider.updateCommentById(provider.editCommentId,
                                provider.commentReply.text);
                            FocusScope.of(context).unfocus();
                            provider.commentState = provider.commentReply.text;
                            provider.commentReply.clear();
                          } else if (provider.isEditParentComment) {
                            provider.updateParentComment(
                                provider.commentReply.text);
                            FocusScope.of(context).unfocus();
                            provider.commentState = provider.commentReply.text;
                            provider.commentReply.clear();
                          } else {
                            provider.sendComment();
                            FocusScope.of(context).unfocus();
                            provider.commentState = "Update";
                          }
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
