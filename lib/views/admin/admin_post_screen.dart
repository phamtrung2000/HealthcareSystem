import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/models/commutity/post.dart';
import 'package:flutter_mental_health/services/data_repository.dart';
import 'package:flutter_mental_health/view_models/admin/admin_change_container.dart';
import 'package:flutter_mental_health/views/admin/admin_screen.dart';
import 'package:flutter_mental_health/views/admin/widgets/drop_down.dart';
import 'package:flutter_mental_health/views/admin/widgets/topic.dart';
import 'package:flutter_mental_health/views/onboard_screen/widgets/generic_loading_animation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/src/provider.dart';

class AdminPostScreen extends StatefulWidget {
  const AdminPostScreen({Key? key}) : super(key: key);

  @override
  State<AdminPostScreen> createState() => _AdminPostScreenState();
}

class _AdminPostScreenState extends State<AdminPostScreen> {
  @override
  void initState() {
    context.read<ChangeContainer>().getAllPostPending();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () {
          AdminPage.selectPost = '';
          return context.read<ChangeContainer>().getAllPostPending();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 27.0.w, top: 29.0.h),
                    child: Text(
                      'Sort by:',
                      style: TextConfigs.kText16w400Black,
                    ),
                  ),
                  Container(
                      width: 140.w,
                      height: 40.h,
                      margin: EdgeInsets.only(top: 16.0.h, left: 11.0.w),
                      decoration: BoxDecoration(
                          color: AppColors.kPopupBackgroundColor,
                          border: Border.all(
                              color: AppColors.kBackgroundColor, width: 1.w),
                          borderRadius: BorderRadius.circular(15.r)),
                      child: DropDown(
                        hint: 'Date',
                        isPostScreen: false,
                      )),
                  Container(
                    width: 140.w,
                    height: 40.h,
                    margin: EdgeInsets.only(top: 17.0.h, left: 11.w),
                    decoration: BoxDecoration(
                        color: AppColors.kPopupBackgroundColor,
                        border: Border.all(
                            color: AppColors.kBackgroundColor, width: 1.w),
                        borderRadius: BorderRadius.circular(15.r)),
                    child: DropdownButton(
                      value: context.read<ChangeContainer>().selectDay,
                      underline: SizedBox(),
                      icon: Icon(Icons.keyboard_arrow_down),
                      iconSize: 30.0.r,
                      hint: Text('Ascending'),
                      isExpanded: true,
                      items: <String>['Ascending', 'Descending']
                          .map(
                            (value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                                onTap: () {
                                  if (value == 'Descending' &&
                                      context
                                          .read<ChangeContainer>()
                                          .isAscending) {
                                    context
                                        .read<ChangeContainer>()
                                        .filterPostByDescending();
                                  } else if (value == 'Ascending' &&
                                      !context
                                          .read<ChangeContainer>()
                                          .isAscending) {
                                    context
                                        .read<ChangeContainer>()
                                        .filterPostByAscending();
                                  }
                                }),
                          )
                          .toList(),
                      onChanged: (_) {},
                    ),
                  ),
                ],
              ),
              FutureBuilder<void>(
                  future: DataRepository().getAllPostPending(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: GenericLoadingAnimation(),
                      );
                    } else {
                      // List<Datum> newDatum = snapshot.hasData;
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              context.read<ChangeContainer>().postList.length,
                          itemBuilder: (context, index) {
                            return Topic(
                              email: context
                                  .read<ChangeContainer>()
                                  .postList[index]
                                  .user
                                  .email,
                              topic: context
                                  .read<ChangeContainer>()
                                  .postList[index]
                                  .topic
                                  .title,
                              id: context
                                  .read<ChangeContainer>()
                                  .postList[index]
                                  .id,
                              userId: context
                                  .read<ChangeContainer>()
                                  .postList[index]
                                  .user
                                  .id,
                              content: context
                                  .read<ChangeContainer>()
                                  .postList[index]
                                  .content,
                              fullName: context
                                  .read<ChangeContainer>()
                                  .postList[index]
                                  .user
                                  .fullname,
                              topicTitle: context
                                  .read<ChangeContainer>()
                                  .postList[index]
                                  .title,
                              avatar: context
                                  .read<ChangeContainer>()
                                  .postList[index]
                                  .user
                                  .avatar,
                              images: context
                                  .read<ChangeContainer>()
                                  .postList[index]
                                  .images,
                            );
                          });
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
