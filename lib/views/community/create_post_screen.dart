import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/models/commutity/post_topic.dart';
import 'package:flutter_mental_health/utils/utils.dart';
import 'package:flutter_mental_health/view_models/auth/auth_provider.dart';
import 'package:flutter_mental_health/view_models/community/community_provider.dart';
import 'package:flutter_mental_health/view_models/community/create_post_provider.dart';
import 'package:flutter_mental_health/views/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CreatePost extends StatefulWidget {
  static const String id = "AddTopic";

  const CreatePost({Key? key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  Future<bool?> _discardPost() async {
    return await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('Do you want to discard?',
                style: TextConfigs.kText18w400Black),
            actions: [
              Container(
                margin: EdgeInsets.only(
                  left: 20.w,
                  right: 20.w,
                  bottom: 20.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).pop(false),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 45.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: AppColors.kButtonColor.withOpacity(0.35),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            'No',
                            style: TextConfigs.kText12w400Black,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context, true),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 45.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: AppColors.kButtonColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            'Yes',
                            style: TextConfigs.kText12w400Black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.kProfileInputColor,
      appBar: AppBar(
        backgroundColor: AppColors.kPopupBackgroundColor,
        title: Text('Create post', style: TextConfigs.kText24w400Black),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.kBlackColor,
          ),
          onPressed: () async {
            final result = await _discardPost() ?? false;
            if (result) {
              Navigator.pop(context);
            }
          },
        ),
        elevation: 1,
      ),
      body: BodyAddTopic(),
    );
  }
}

class BodyAddTopic extends StatefulWidget {
  const BodyAddTopic({Key? key}) : super(key: key);

  @override
  _BodyAddTopicState createState() => _BodyAddTopicState();
}

class _BodyAddTopicState extends State<BodyAddTopic> {
  CommunityProvider? communityProvider;
  final TextEditingController postContentController = TextEditingController();
  final TextEditingController postTitleController = TextEditingController();
  PostTopic? selectedPostTopic;
  @override
  void didChangeDependencies() {
    communityProvider = Provider.of<CommunityProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    selectedPostTopic = context.read<CommunityProvider>().postTopicListNoAll[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: SingleChildScrollView(
            child: Container(
              // ignore: prefer_const_constructors
              decoration: BoxDecoration(
                // ignore: prefer_const_constructors
                borderRadius: BorderRadius.only(
                  topLeft: Radius.zero,
                  topRight: Radius.zero,
                  bottomLeft: const Radius.circular(15.0),
                  bottomRight: const Radius.circular(15.0),
                ),
                color: AppColors.kPopupBackgroundColor,
                shape: BoxShape.rectangle,
              ),
              padding: EdgeInsets.symmetric(
                vertical: 13.h,
                horizontal: 25.w,
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      // avatar user
                      CircleAvatar(
                        radius: 30.0,
                        backgroundImage: NetworkImage(
                            context.read<AuthProvider>().user.avatar),
                        backgroundColor: Colors.transparent,
                      ),
                      SizedBox(
                        width: 11.w,
                      ),
                      // Dropdown: choosen topic
                      Container(
                        padding: EdgeInsets.all(5.h),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<PostTopic>(
                            value: selectedPostTopic,
                            style: TextConfigs.kText18w700Black,
                            icon: SvgPicture.asset(
                                'assets/icons/ic_dropdown2.svg'),
                            isDense: true,
                            // ignore: prefer_const_literals_to_create_immutables
                            items: communityProvider!.postTopicListNoAll
                                .map((PostTopic item) {
                              return DropdownMenuItem<PostTopic>(
                                child: Text(item.title),
                                value: item,
                              );
                            }).toList(),
                            onChanged: (PostTopic? value) {
                              setState(() {
                                selectedPostTopic = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormField(
                    maxLines: 1,
                    controller: postTitleController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Add title',
                      hintStyle: TextConfigs.kText24w400Grey,
                      border: InputBorder.none,
                    ),
                    style: TextConfigs.kText24w700Black,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormField(
                    maxLines: 10,
                    controller: postContentController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Add body text',
                      hintStyle: TextConfigs.kText24w400Grey,
                      border: InputBorder.none,
                    ),
                    style: TextConfigs.kText24w400Black,
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 15.h,
          ),
          height: 100.h,
          child: Consumer<CreatePostProvider>(
            builder: (context, postProvider, child) {
              return ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    if (postProvider.listImage.length == index) {
                      return GestureDetector(
                        onTap: () => postProvider.pickImage(),
                        child: Container(
                          height: 100.h,
                          width: 100.h,
                          decoration: BoxDecoration(
                            color: AppColors.kPopupBackgroundColor,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: IconButton(
                              icon: Icon(
                                CupertinoIcons.plus,
                                color: AppColors.kProfileInputColor,
                                size: 36.w,
                              ),
                              onPressed: null,
                            ),
                          ),
                        ),
                      );
                    }

                    return WidgedAddImage(
                      image: postProvider.listImage[index],
                      press: () {
                        postProvider.deleteImage(index);
                      },
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                        width: 21.w,
                      ),
                  itemCount: postProvider.listImage.length + 1);
            },
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(
                  left: 20.w,
                  top: 55.h,
                  right: 20.w,
                  bottom: 10.h,
                ),
                child: OutlinedButton(
                  onPressed: () {
                    context.read<CreatePostProvider>().submitPost(() async {
                      await Utils.successfulSubmission(
                          context, "Submit Post Successfully.");
                      Navigator.pop(context, true);
                    }, postContentController.text, postTitleController.text,
                        selectedPostTopic!.topicID, true);
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: AppColors.kButtonColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(15.h),
                    child: Text(
                      'Post',
                      style: TextConfigs.kText16w400White,
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class WidgedAddImage extends StatelessWidget {
  final File image;
  final VoidCallback press;
  const WidgedAddImage({Key? key, required this.image, required this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: 100.h,
      decoration: BoxDecoration(
        color: AppColors.kPopupBackgroundColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.file(image),
          ),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: press,
              child: Container(
                margin: EdgeInsets.all(4.h),
                height: 19.h,
                width: 19.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.kPopupBackgroundColor,
                ),
                child: Icon(
                  CupertinoIcons.multiply,
                  color: AppColors.kGreyTextTouchableColor,
                  size: 14.h,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
