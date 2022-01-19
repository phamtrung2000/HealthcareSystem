import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/models/authentication/user.dart';
import 'package:flutter_mental_health/services/data_repository.dart';
import 'package:flutter_mental_health/view_models/admin/admin_provider.dart';
import 'package:flutter_mental_health/views/admin/widgets/container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/src/provider.dart';

class FindUser extends StatefulWidget {
  const FindUser({Key? key}) : super(key: key);

  @override
  _FindUserState createState() => _FindUserState();
}

class _FindUserState extends State<FindUser> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
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
                child: Padding(
                  padding: EdgeInsets.only(left: 27.0.w, top: 10.h),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: "Search"),
                    onChanged: (value) {
                      context.watch<AdminProvider>().OnChange(value);
                    },
                  ),
                ),
              ),
            ),
            FutureBuilder<List<User>>(
                future:context.read<AdminProvider>().Fututure(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    // List<Datum> newDatum = snapshot.hasData;
                    return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ContainerUsesr(
                            fullName: snapshot.data![index].fullname,
                            email: snapshot.data![index].email,
                            id: snapshot.data![index].id,
                            avatar: snapshot.data![index].avatar,
                          );
                        });
                  }
                })
          ],
        ),
      ),
    );
  }
}
