import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/models/commutity/post.dart';
import 'package:flutter_mental_health/models/commutity/post_topic.dart';
import 'package:flutter_mental_health/view_models/admin/admin_change_container.dart';
import 'package:flutter_mental_health/view_models/community/community_provider.dart';
import 'package:flutter_mental_health/views/admin/admin_post_screen.dart';
import 'package:flutter_mental_health/views/admin/admin_user_screen.dart';
import 'package:flutter_mental_health/views/admin/widgets/drop_down.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/src/provider.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);
  static const id = "AdminScreen";

  @override
  Widget build(BuildContext context) {
    return const AdminPage();
  }
}

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);
  static String selectPost = '';

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  // @override
  // void dispose() {
  //   Provider.of<ChangeContainer>(context, listen: false).c;
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    String selectChoose = 'Post';
    List<PostTopic> postList = [];
    context.read<CommunityProvider>().postTopicList.forEach((element) {
      postList.add(element);
    });

    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: AppColors.kPopupBackgroundColor,
          title: Text('Administration', style: TextConfigs.kText24w400Black),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(CupertinoIcons.back, color: AppColors.kBlackColor),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Column(
          children: [
            Container(
              child: context.read<ChangeContainer>().isCollapsed
                  ? Container(
                      width: 414.w,
                      height: 44.h,
                      color: AppColors.kPopupBackgroundColor,
                      child: GestureDetector(
                          onTap: () {
                            context.read<ChangeContainer>().expand();
                          },
                          child: Icon(Icons.keyboard_arrow_down)))
                  : Container(
                      width: 414.w,
                      height: context.read<ChangeContainer>().height,
                      color: AppColors.kPopupBackgroundColor,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                top: 18.0.h, left: 27.w, right: 27.w),
                            padding: EdgeInsets.only(left: 27.w, right: 16.w),
                            decoration: BoxDecoration(
                                color: AppColors.kDropDownButton,
                                borderRadius: BorderRadius.circular(25.r)),
                            child: DropdownButton(
                              value: selectChoose,
                              underline: SizedBox(),
                              icon: Icon(Icons.keyboard_arrow_down),
                              iconSize: 30.0.r,
                              hint: Text('Post'),
                              isExpanded: true,
                              items: <String>['Post', 'User']
                                  .map(
                                    (value) => DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
                                        onTap: () {
                                          if (value == 'Post') {
                                            context
                                                .read<ChangeContainer>()
                                                .changeToPost(true);
                                          } else {
                                            context
                                                .read<ChangeContainer>()
                                                .changeToPost(false);
                                          }
                                        }),
                                  )
                                  .toList(),
                              onChanged: (newValue) {
                                selectChoose = newValue.toString();
                              },
                            ),
                          ),
                          context.read<ChangeContainer>().isPost
                              ? Container(
                                  margin: EdgeInsets.only(
                                      top: 18.0.h, left: 27.w, right: 27.w),
                                  padding:
                                      EdgeInsets.only(left: 27.w, right: 16.w),
                                  decoration: BoxDecoration(
                                      color: AppColors.kDropDownButton,
                                      border: Border.all(
                                        color: AppColors.kDropDownButton,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(25.r)),
                                  child: DropdownButton(
                                    underline: SizedBox(),
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    iconSize: 30.0.r,
                                    hint: Text(
                                      'All/Post',
                                    ),
                                    value: AdminPage.selectPost,
                                    isExpanded: true,
                                    items: postList
                                        .map(
                                          (value) => DropdownMenuItem(
                                            value: value.topicID,
                                            child: Text(value.title),
                                            onTap: () {
                                              context
                                                  .read<ChangeContainer>()
                                                  .filterPostByTopic(
                                                      value.topicID);
                                            },
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (newValue) {
                                      AdminPage.selectPost =
                                          newValue.toString();
                                    },
                                  ))
                              : Container(
                                  width: 100.0.w,
                                  height: 40.0.h,
                                  color: AppColors.kPopupBackgroundColor),
                          GestureDetector(
                              onTap: () {
                                context.read<ChangeContainer>().collapsed();
                              },
                              child: Icon(Icons.keyboard_arrow_up)),
                        ],
                      ),
                    ),
            ),
            Container(
              child: context.watch<ChangeContainer>().isPost
                  ? AdminPostScreen()
                  : AdminUserScreen(),
            )
          ],
        ),
      );
    });
  }
}
