// ignore_for_file: prefer_const_constructors, constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/models/reports/problem_report.dart';
import 'package:flutter_mental_health/utils/utils.dart';
import 'package:flutter_mental_health/view_models/auth/auth_provider.dart';
import 'package:flutter_mental_health/view_models/reports/report_problem_provider.dart';
import 'package:flutter_mental_health/views/home_screen.dart';
import 'package:flutter_mental_health/views/reports/report_problem/list_item_file_report.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ReportProblemScreen extends StatefulWidget {
  const ReportProblemScreen({Key? key}) : super(key: key);
  static const id = "ReportProblemScreen";

  @override
  State<ReportProblemScreen> createState() => _ReportProblemScreenState();
}

class _ReportProblemScreenState extends State<ReportProblemScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    ///Lấy argument như sau
    // final arguments =
    //     ModalRoute.of(context)!.settings.arguments as ReportProblemArguments;
    // print(arguments.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kPopupBackgroundColor,
        title: Text('Report a problem', style: TextConfigs.kText24w400Black),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.kBlackColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 1,
      ),
      body: BodyReportProblem(),
    );
  }
}

class ReportProblemArguments {
  final String text;

  ReportProblemArguments(this.text);
}

class BodyReportProblem extends StatefulWidget {
  const BodyReportProblem({
    Key? key,
  }) : super(key: key);

  @override
  State<BodyReportProblem> createState() => _BodyReportProblemState();
}

class _BodyReportProblemState extends State<BodyReportProblem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 36.w,
                vertical: 21.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    decoration: BoxDecoration(
                      color: AppColors.kPopupBackgroundColor,
                      borderRadius: BorderRadius.circular(20),
                      // ignore: prefer_const_literals_to_create_immutables
                      boxShadow: [
                        const BoxShadow(
                            color: AppColors.kBlackColor, spreadRadius: 1),
                      ],
                    ),
                    child: Consumer<ReportProblemProvider>(builder: (
                      context,
                      reportProblemProvider,
                      child,
                    ) {
                      return DropdownButton<ProblemReportType>(
                        dropdownColor: AppColors.kPopupBackgroundColor,
                        icon: SvgPicture.asset('assets/icons/ic_dropdown.svg'),
                        underline: SizedBox(),
                        isExpanded: true,
                        style: TextStyle(
                          color: AppColors.kBlackColor,
                          backgroundColor: AppColors.kPopupBackgroundColor,
                        ),
                        onChanged: (ProblemReportType? val) {
                          setState(() {
                            reportProblemProvider.set(val);
                          });
                        },
                        value: reportProblemProvider.get(),
                        // ignore: prefer_const_literals_to_create_immutables
                        items: [
                          DropdownMenuItem(
                            child: Text(
                              "Bug",
                              style: TextConfigs.kText18w400Black,
                            ),
                            value: ProblemReportType.Bug,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              "Other",
                              style: TextConfigs.kText18w400Black,
                            ),
                            value: ProblemReportType.Other,
                          ),
                        ],
                      );
                    }),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 40.w,
                    ),
                    child: Divider(
                      thickness: 2,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Description',
                    style: TextConfigs.kText18w400Black,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    height: 200.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 18.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.kPopupBackgroundColor,
                      borderRadius: BorderRadius.circular(5),
                      // ignore: prefer_const_literals_to_create_immutables
                      boxShadow: [
                        const BoxShadow(
                            color: AppColors.kBlackColor, spreadRadius: 1),
                      ],
                    ),
                    child: TextFormField(
                      controller: context
                          .read<ReportProblemProvider>()
                          .descriptionController,
                      minLines: 1,
                      maxLines: 8,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Description',
                        hintStyle: TextStyle(
                          color: AppColors.kGreyBackgroundColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 22.h,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 40.w,
                    ),
                    child: Divider(
                      thickness: 2,
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      SvgPicture.asset('assets/icons/ic_attach.svg'),
                      InkWell(
                        onTap: () =>
                            context.read<ReportProblemProvider>().pickFiles(),
                        child: Text(
                          'Add file',
                          style: TextConfigs.kText18w400Black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Consumer<ReportProblemProvider>(
                    builder: (context, provider, child) {
                      return ItemFileReport(files: provider.pickedFiles);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Divider(
          thickness: 2,
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
                .read<ReportProblemProvider>()
                .submitProblemReport(
                    () async => await Utils.successfulSubmission(
                        context, "Submit Problem Report Successfully"),
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
