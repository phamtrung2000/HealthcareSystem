import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/constants/format_date.dart';
import 'package:flutter_mental_health/view_models/auth/auth_provider.dart';
import 'package:flutter_mental_health/view_models/community/community_provider.dart';
import 'package:flutter_mental_health/views/community/create_post_screen.dart';
import 'package:flutter_mental_health/views/community/fullpost_screen.dart';
import 'package:flutter_mental_health/views/community/widgets/sidebar_community.dart';
import 'package:flutter_mental_health/views/community/widgets/topic_item.dart';
import 'package:flutter_mental_health/views/reports/report_user/report_user_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mental_health/views/notification/notification_screen.dart';

class CommunityScreen extends StatefulWidget {
  static const id = "CommunityScreen";

  const CommunityScreen({Key? key}) : super(key: key);

  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  void didChangeDependencies() {
    context.read<CommunityProvider>().getAllPost();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kProfileInputColor,
      appBar: AppBar(
        backgroundColor: AppColors.kPopupBackgroundColor,
        elevation: 1,
        title: Text(
          'Community',
          style: TextConfigs.kText24w400Black,
        ),
        centerTitle: true,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: SvgPicture.asset('assets/icons/ic_menu.svg'),
            onPressed: () => Scaffold.of(context).openDrawer(),
          );
        }),
        actions: [
          IconButton(
            onPressed: () async {
              final result = await Navigator.of(context, rootNavigator: true)
                      .pushNamed(CreatePost.id) ??
                  false;
              if (result == true) {
                context.read<CommunityProvider>().getAllPost();
              }
            },
            icon: SvgPicture.asset('assets/icons/ic_add_topic.svg'),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationScreen()));
            },
            icon: SvgPicture.asset('assets/icons/ic_notify.svg'),
          ),
        ],
      ),
      drawer: const SideBarCommunity(),
      body: Consumer<CommunityProvider>(
        builder: (context, provider, title) {
          return RefreshIndicator(
            onRefresh: provider.refeshPost,
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true)
                            .pushNamed(FullPostScreen.id,
                                arguments: provider.postList[index])
                            .then(
                              (value) => setState(
                                () {
                                  if (value.toString() == "Delete Post") {
                                    provider.deletePostById(
                                        provider.postList[index].id);
                                  } else if (value.toString() == "Update") {
                                    provider.updatePostCommentState(
                                        provider.postList[index].id,
                                        !provider.postList[index].allowComment);
                                  } else {
                                    provider.refeshPost();
                                  }
                                },
                              ),
                            );
                      },
                      child: TopicItem(
                        post: provider.postList[index],
                        hasLiked: provider.checkReact(
                            provider.postList[index].reacts,
                            context.read<AuthProvider>().user.id),
                      ));
                },
                separatorBuilder: (context, index) => SizedBox(
                      height: 4.h,
                    ),
                itemCount: provider.postList.length),
          );
        },
      ),
    );
  }
}
