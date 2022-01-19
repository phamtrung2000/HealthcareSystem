// ignore_for_file: prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/models/reports/user_report.dart';
import 'package:flutter_mental_health/utils/utils.dart';
import 'package:flutter_mental_health/view_models/auth/auth_provider.dart';
import 'package:flutter_mental_health/view_models/reports/report_user_provider.dart';
import 'package:flutter_mental_health/views/reports/report_user/widgets/circular_checkbox.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ReportUserScreen extends StatelessWidget {
  static const id = "ReportUserScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPopupBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.kPopupBackgroundColor,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back, color: AppColors.kBlackColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Report a user",
          style: TextStyle(fontSize: 24.sp, color: AppColors.kBlackColor),
        ),
      ),
      body: ReportUserBody(),
    );
  }
}

class ReportUserBody extends StatefulWidget {
  const ReportUserBody({
    Key? key,
  }) : super(key: key);
  @override
  State<ReportUserBody> createState() => _ReportUserBodyState();
}

class _ReportUserBodyState extends State<ReportUserBody> {
  void _handleTapboxChanged(bool? newValue) {
    setState(() {
      context.read<ReportUserProvider>().isCheck = newValue;
    });
  }

  late ReportUserProvider provider;

  @override
  void initState() {
    provider = context.read<ReportUserProvider>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 40.w),
                decoration: BoxDecoration(
                  color: AppColors.kPopupBackgroundColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.kGreyBackgroundColor.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Center(
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 22.h, bottom: 8.h),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: AppColors.kGreyBackgroundColor,
                            ),
                          ),
                          Text(
                            provider.reportedUser.fullname,
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.kBlackColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 23.h, bottom: 21.h, left: 20.w, right: 20.w),
                      child: Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Expanded(
                            child: Text(
                              "Email",
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: AppColors.kBlackColor,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              provider.reportedUser.email.isEmpty
                                  ? "Not Found"
                                  : provider.reportedUser.email,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: AppColors.kBlackColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20.w,
                        right: 20.w,
                        bottom: 20.h,
                      ),
                      child: Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Expanded(
                            child: Text(
                              "Phome Number",
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: AppColors.kBlackColor,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              provider.reportedUser.phoneNumber.isEmpty
                                  ? "Not Found"
                                  : provider.reportedUser.phoneNumber,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: AppColors.kBlackColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                decoration: ShapeDecoration(
                  color: AppColors.kPopupBackgroundColor,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1.0, style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                ),
                margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 40.w),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: DropdownButtonHideUnderline(
                    child: Consumer<ReportUserProvider>(
                      builder: (
                        context,
                        reportUserProvider,
                        child,
                      ) {
                        return DropdownButton<UserReportType>(
                          dropdownColor: AppColors.kPopupBackgroundColor,
                          isDense: true,
                          isExpanded: true,
                          icon:
                              SvgPicture.asset('assets/icons/ic_dropdown.svg'),
                          items: [
                            DropdownMenuItem(
                              child: Text(
                                "Abuse",
                                style: TextConfigs.kText18w400Black,
                              ),
                              value: UserReportType.abuse,
                            ),
                            DropdownMenuItem(
                              child: Text(
                                "Fake Account",
                                style: TextConfigs.kText18w400Black,
                              ),
                              value: UserReportType.fakeAccount,
                            ),
                            DropdownMenuItem(
                              child: Text(
                                "Violate Community Standard",
                                style: TextConfigs.kText18w400Black,
                              ),
                              value: UserReportType.violateCommunityStandard,
                            ),
                            DropdownMenuItem(
                              child: Text(
                                "Violate Terms of Use",
                                style: TextConfigs.kText18w400Black,
                              ),
                              value: UserReportType.violateTermOfUse,
                            ),
                          ],
                          onChanged: (UserReportType? value) {
                            setState(
                              () {
                                reportUserProvider.set(value);
                              },
                            );
                          },
                          value: reportUserProvider.get(),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 35.w),
                child: Row(
                  children: [
                    CircularCheckbox(
                      value: context.read<ReportUserProvider>().isCheck,
                      onChanged: _handleTapboxChanged,
                    ),
                    Expanded(
                      child: Text(
                        "Receive email about this report",
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: AppColors.kBlackColor,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          height: 43.h,
          width: 342.w,
          margin: EdgeInsets.symmetric(
            horizontal: 36.w,
            vertical: 8.h,
          ),
          child: OutlinedButton(
            onPressed: () => context
                .read<ReportUserProvider>()
                .submitUserReport(
                    () async => await Utils.successfulSubmission(
                        context, "Submit User Report Successfully"),
                    context.read<AuthProvider>().user.id),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: AppColors.kButtonColor,
            ),
            child: Text(
              'Submit',
              style: TextStyle(
                color: AppColors.kPopupBackgroundColor,
                fontSize: 15.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
