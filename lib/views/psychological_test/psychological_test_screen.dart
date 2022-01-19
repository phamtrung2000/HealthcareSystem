// ignore_for_file: constant_identifier_names, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/view_models/psychological_test/psychological_test_provider.dart';
import 'package:flutter_mental_health/views/psychological_test/test_result_screen.dart';
import 'package:flutter_mental_health/views/psychological_test/widgets/radio_group.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PsychologicalTestScreen extends StatefulWidget {
  const PsychologicalTestScreen({Key? key}) : super(key: key);
  static const id = "PsychologicalTestScreen";
  @override
  State<StatefulWidget> createState() => _PsychologicalTestScreenState();
}

class _PsychologicalTestScreenState extends State<PsychologicalTestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kPopupBackgroundColor,
        title: const Text(
          'Psychological test',
          style: TextStyle(
            color: AppColors.kBlackColor,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.kBlackColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 10.h),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Consumer<PsychologicalTestProvider>(
                builder: (context, provider, listTitle) {
                  return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 20.h,
                          ),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.kPopupBackgroundColor,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.kGreyBackgroundColor
                                    .withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 3,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 10.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Question ' + (index + 1).toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                ),
                              ),
                              Text(
                                provider.questionDetailList![index].question
                                    .content,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                ),
                              ),
                              SizedBox(
                                height: 13.h,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: const Divider(
                                  thickness: 2,
                                ),
                              ),
                              SizedBox(
                                height: 13.h,
                              ),
                              RadioGroup(
                                  size: 20.w,
                                  style: TextStyle(fontSize: 13.sp),
                                  shape: BoxShape.circle,
                                  items: [
                                    ...QuestionResult.values
                                        .map((e) => e.name)
                                        .toList()
                                  ],
                                  onCheckChanged: (val) {
                                    setState(() {
                                      QuestionResult questionResult =
                                          QuestionResultExtension.fromName(val);
                                      switch (questionResult) {
                                        case QuestionResult.Always:
                                          {
                                            provider.setQuestionDetail(
                                                index, 4);
                                          }
                                          break;
                                        case QuestionResult.Often:
                                          {
                                            provider.setQuestionDetail(
                                                index, 3);
                                          }
                                          break;
                                        case QuestionResult.Sometimes:
                                          {
                                            provider.setQuestionDetail(
                                                index, 2);
                                          }
                                          break;
                                        case QuestionResult.Rarely:
                                          {
                                            provider.setQuestionDetail(
                                                index, 1);
                                          }
                                          break;
                                        case QuestionResult.Never:
                                          {
                                            provider.setQuestionDetail(
                                                index, 0);
                                          }
                                          break;
                                      }
                                    });
                                  })
                            ],
                          ),
                        );
                      },
                      itemCount: provider.questionDetailList!.length);
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, TestResultScreen.id, (route) => false);
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
                          'Finish the test',
                          style: TextStyle(
                            color: AppColors.kPopupBackgroundColor,
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum QuestionResult {
  // ignore: constant_identifier_names
  Always,
  Often,
  Sometimes,
  Rarely,
  Never
}

extension QuestionResultExtension on QuestionResult {
  String get name {
    final Map<QuestionResult, String> names = {
      QuestionResult.Always: 'Always',
      QuestionResult.Often: 'Often',
      QuestionResult.Sometimes: 'Sometimes',
      QuestionResult.Rarely: 'Rarely',
      QuestionResult.Never: 'Never'
    };
    return names[this]!;
  }

  static QuestionResult fromName(String val) {
    final names = {
      'Always': QuestionResult.Always,
      'Often': QuestionResult.Often,
      'Sometimes': QuestionResult.Sometimes,
      'Rarely': QuestionResult.Rarely,
      'Never': QuestionResult.Never,
    };
    return names[val]!;
  }
}
