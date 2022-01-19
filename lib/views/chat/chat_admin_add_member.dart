import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/models/admin/all_user.dart';
import 'package:flutter_mental_health/models/authentication/user.dart';
import 'package:flutter_mental_health/services/data_repository.dart';
import 'package:flutter_mental_health/view_models/admin/admin_provider.dart';
import 'package:flutter_mental_health/views/admin/widgets/ban_mute_user.dart';
import 'package:flutter_mental_health/views/admin/widgets/container.dart';
import 'package:flutter_mental_health/views/admin/widgets/hero_dialog_route.dart';
import 'package:flutter_mental_health/views/authentication/components/widgets/text_field_input.dart';
import 'package:flutter_mental_health/views/chat/widget/container_add_user.dart';
import 'package:flutter_mental_health/views/onboard_screen/widgets/generic_loading_animation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/src/provider.dart';

class ChatAdminAddMember extends StatefulWidget {
  static const id = 'ChatAdminAddMember';
  ChatAdminAddMember({required this.roomId, Key? key}) : super(key: key);

  String roomId;

  @override
  State<ChatAdminAddMember> createState() => _ChatAdminAddMemberState();
}

class _ChatAdminAddMemberState extends State<ChatAdminAddMember> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add member',
          style: TextConfigs.kText24w400Black,
        ),
        centerTitle: true,
        backgroundColor: AppColors.kPopupBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 30.sp,
          color: AppColors.kBlackColor,
          onPressed: () {
            context.read<AdminProvider>().listUserId.clear();

            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 14.0.h),
              child: Container(
                  width: 360.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                      color: AppColors.kPopupBackgroundColor,
                      borderRadius: BorderRadius.circular(25.r)),
                  child: TextField(
                    onChanged: (value) {
                      context.read<AdminProvider>().OnChange(value);
                    },
                    decoration: InputDecoration(
                        hintText: "Search",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.r))),
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(top: 13.0.h),
              child: FutureBuilder<List<User>>(
                  future: context.watch<AdminProvider>().Fututure(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: GenericLoadingAnimation(),
                      );
                    } else {
                      return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return ContainerAddUsesr(
                              fullName: snapshot.data![index].fullname,
                              email: snapshot.data![index].email,
                              id: snapshot.data![index].id,
                              avatar: snapshot.data![index].avatar,
                              roomId: widget.roomId,
                            );
                          });
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class ChatAdminAddMemberArgument {
  String roomId;
  ChatAdminAddMemberArgument(this.roomId);
}
