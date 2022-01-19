import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/app_configs.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/constants/format_date.dart';
import 'package:flutter_mental_health/models/commutity/comment.dart';
import 'package:flutter_mental_health/view_models/auth/auth_provider.dart';
import 'package:flutter_mental_health/view_models/community/comments_reply_provider.dart';
import 'package:flutter_mental_health/view_models/community/full_post_provider.dart';
import 'package:flutter_mental_health/views/community/fullpost_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CommentItem extends StatefulWidget {
  final Comment comment;
  final VoidCallback pressReply;
  final VoidCallback editCommentPress;
  final bool reply;

  const CommentItem({
    Key? key,
    required this.comment,
    required this.pressReply,
    required this.reply,
    required this.editCommentPress,
  }) : super(key: key);

  @override
  _CommentItemState createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  void showBottomDialog(BuildContext thisContext) {
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
                  if (widget.reply) {
                    thisContext
                        .read<FullPostProvider>()
                        .deleteCommentById(widget.comment.commentId);
                  } else {
                    thisContext
                        .read<CommentReplyProvider>()
                        .deleteCommentById(widget.comment.commentId);
                    thisContext.read<CommentReplyProvider>().commentState =
                        "Delete";
                  }
                  Navigator.of(context).pop();
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
                onTap: widget.editCommentPress,
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
        widget.reply
            ? Positioned(
                left: 35.w,
                top: 75.h,
                child: IntrinsicHeight(
                  child: Visibility(
                    visible: widget.comment.childrenCount > 0,
                    child: Container(
                      color: Colors.grey,
                      width: 1.w,
                      height: 2000.h,
                      margin: EdgeInsets.only(bottom: 10.h),
                    ),
                  ),
                ),
              )
            : Positioned(
                left: 0.w,
                top: 0.h,
                child: IntrinsicHeight(
                  child: Container(
                    color: Colors.grey,
                    width: 1.w,
                    height: 2000.h,
                    margin: EdgeInsets.only(bottom: 10.h),
                  ),
                ),
              ),
        GestureDetector(
          onLongPress: () {
            if (context.read<AuthProvider>().user.id ==
                widget.comment.user.id) {
              showBottomDialog(context);
            }
          },
          child: Container(
            padding: widget.reply
                ? EdgeInsets.only(
                    top: 10.h, left: 10.w, right: 25.w, bottom: 0.h)
                : EdgeInsets.only(
                    top: 10.h, left: 15.w, right: 25.w, bottom: 0.h),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30.sp,
                          backgroundImage:
                              NetworkImage(widget.comment.user.avatar),
                          backgroundColor: Colors.transparent,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          widget.comment.user.fullname,
                          style: TextConfigs.kText20w400Black.copyWith(
                              fontWeight: FontWeight.w700, fontSize: 16.sp),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          FormatDateTime.formatterTimeAndDate
                              .format(widget.comment.createdAt),
                          style: TextConfigs.kText20w400Black.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                              fontStyle: FontStyle.italic),
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 65.w),
                        child: Text(widget.comment.comment,
                            style: TextConfigs.kText20w400Black
                                .copyWith(fontSize: 16.sp)),
                      ),
                    ),
                    GestureDetector(
                      onLongPress: widget.pressReply,
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 20.w, bottom: 5.h, top: 10.h),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            widget.comment.childrenCount > 0
                                ? Padding(
                                    padding: EdgeInsets.only(left: 20.w),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 10,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 30.sp,
                                                    backgroundImage:
                                                        NetworkImage(widget
                                                            .comment
                                                            .childCommentList[0]
                                                            .user
                                                            .avatar),
                                                    backgroundColor:
                                                        Colors.transparent,
                                                  ),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  Text(
                                                    widget
                                                        .comment
                                                        .childCommentList[0]
                                                        .user
                                                        .fullname,
                                                    style: TextConfigs
                                                        .kText20w400Black
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 16.sp),
                                                  ),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  Text(
                                                    FormatDateTime
                                                        .formatterTimeAndDate
                                                        .format(widget
                                                            .comment
                                                            .childCommentList[0]
                                                            .createdAt),
                                                    style: TextConfigs
                                                        .kText20w400Black
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16.sp,
                                                            fontStyle: FontStyle
                                                                .italic),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                padding:
                                                    EdgeInsets.only(left: 70.w),
                                                child: Text(
                                                    widget
                                                        .comment
                                                        .childCommentList[0]
                                                        .comment,
                                                    style: TextConfigs
                                                        .kText20w400Black
                                                        .copyWith(
                                                            fontSize: 16.sp)),
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              widget.comment.childrenCount > 1
                                                  ? GestureDetector(
                                                      onTap: widget.pressReply,
                                                      child: Container(
                                                        width: double.infinity,
                                                        decoration: BoxDecoration(
                                                            color: Colors.blue,
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        20.h))),
                                                        alignment:
                                                            Alignment.center,
                                                        margin: EdgeInsets.only(
                                                            left: 70.w),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    10.w,
                                                                vertical: 5.h),
                                                        child: Text(
                                                          'More replies',
                                                          style: TextConfigs
                                                              .kText20w400Black
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize:
                                                                      16.sp,
                                                                  color: AppColors
                                                                      .kPopupBackgroundColor),
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : SizedBox(
                                    width: 0.w,
                                  )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: widget.reply,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: widget.pressReply,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset('assets/icons/ic_reply.svg'),
                          Text("Reply",
                              style: TextConfigs.kText20w400Black
                                  .copyWith(fontSize: 16.sp))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
