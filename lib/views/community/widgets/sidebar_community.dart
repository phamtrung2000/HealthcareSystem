import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/view_models/community/community_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SideBarCommunity extends StatefulWidget {
  static String id = "SideBarCommunity";

  const SideBarCommunity({Key? key}) : super(key: key);

  _SideBarCommunityState createState() => _SideBarCommunityState();
}

class _SideBarCommunityState extends State<SideBarCommunity> {
  final _searchController = TextEditingController();
  String _searchText = "";

  @override
  void initState() {
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 10.h),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Center(
                child: Text(
                  "Choose topic",
                  style: TextConfigs.kText24w400Black,
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 17.h),
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.kSearchButtonColor,
                  shape: BoxShape.rectangle,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: TextFormField(
                    // ignore: prefer_const_constructors
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextConfigs.kText18w400Grey,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    maxLines: 1,
                    onChanged: (value) {
                      Provider.of<CommunityProvider>(context, listen: false)
                          .changeSearchString(value);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 9.h,
              ),
              Consumer<CommunityProvider>(
                builder: (context, provider, title) {
                  return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.kGreyTextTouchableColor,
                                width: 1,
                              ),
                            ),
                          ),
                          child: ListTile(
                            title: Text(
                              provider.postTopicList[index].title,
                              style: TextConfigs.kText18w400Black
                                  .copyWith(fontSize: 16.sp),
                            ),
                            onTap: () {
                              context
                                  .read<CommunityProvider>()
                                  .filterPostByTopic(
                                      provider.postTopicList[index].topicID);
                              Navigator.pop(context);
                            },
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                            height: 10.h,
                          ),
                      itemCount: provider.postTopicList.length);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
