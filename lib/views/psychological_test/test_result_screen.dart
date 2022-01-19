import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/utils/utils.dart';
import 'package:flutter_mental_health/view_models/auth/auth_provider.dart';
import 'package:flutter_mental_health/view_models/psychological_test/psychological_test_provider.dart';
import 'package:flutter_mental_health/views/psychological_test/test_history_screen.dart';
import 'package:flutter_mental_health/views/psychological_test/widgets/result_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class TestResultScreen extends StatefulWidget {
  const TestResultScreen({Key? key}) : super(key: key);
  static const id = "TestResultScreen";
  @override
  _TestResultScreenState createState() => _TestResultScreenState();
}

class _TestResultScreenState extends State<TestResultScreen> {
  late PsychologicalTestProvider _psychologicalTestProvider;

  @override
  void didChangeDependencies() {
    _psychologicalTestProvider = context.read<PsychologicalTestProvider>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.kPopupBackgroundColor,
        title: Text(
          "Result",
          style: TextStyle(
              fontSize: 24.sp,
              color: AppColors.kBlackColor,
              fontWeight: FontWeight.normal),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 10.h),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 10.w),
                        decoration: BoxDecoration(
                          color: AppColors.kPopupBackgroundColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.r),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Overall Test",
                              style: TextStyle(
                                fontSize: 26.sp,
                                color: AppColors.kBlackColor,
                              ),
                            ),
                            Text(
                              _psychologicalTestProvider.totalPoint.toString(),
                              style: TextStyle(
                                fontSize: 38.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.kBlackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(left: 40.w, right: 40.w, top: 20.h),
                        child: const Divider(
                          thickness: 2,
                        ),
                      ),
                      Text(
                        "Review",
                        style: TextStyle(
                          fontSize: 26.sp,
                          color: AppColors.kBlackColor,
                        ),
                      ),
                      SizedBox(height: 10.h)
                    ],
                  ),
                  Consumer<PsychologicalTestProvider>(
                    builder: (context, provider, listTitle) {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ResultItem(
                            index: index,
                            point: _psychologicalTestProvider
                                .questionDetailList![index].point,
                            contentQuestion: _psychologicalTestProvider
                                .questionDetailList![index].question.content,
                          );
                        },
                        itemCount: _psychologicalTestProvider
                            .questionDetailList!.length,
                        separatorBuilder: (context, index) => SizedBox(
                          height: 20.h,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 65.h,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 65.h,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: AppColors.kPopupBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.kGreyBackgroundColor.withOpacity(0.5),
                    spreadRadius: 4,
                    blurRadius: 4,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () {
                  if (!context
                      .read<PsychologicalTestProvider>()
                      .viewTestHistoryDetail) {
                    context
                        .read<PsychologicalTestProvider>()
                        .submitPsychologicalTest(() async {
                      await Utils.successfulSubmission(
                          context, "Submit Psychological Test Successfully");
                      Navigator.pushNamedAndRemoveUntil(
                          context, TestHistoryScreen.id, (route) => false);
                    }, context.read<AuthProvider>().user.id);
                  } else {
                    context
                        .read<PsychologicalTestProvider>()
                        .viewTestHistoryDetail = false;
                    context
                        .read<PsychologicalTestProvider>()
                        .clearPsychologicalTest(false);
                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 25.w),
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 25.w),
                  decoration: BoxDecoration(
                    color: AppColors.kButtonColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.r),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Done",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.kPopupBackgroundColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
