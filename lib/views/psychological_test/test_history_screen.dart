import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/constants/format_date.dart';
import 'package:flutter_mental_health/view_models/psychological_test/psychological_test_provider.dart';
import 'package:flutter_mental_health/view_models/psychological_test/test_history_provider.dart';
import 'package:flutter_mental_health/views/home_screen.dart';
import 'package:flutter_mental_health/views/psychological_test/psychological_test_screen.dart';
import 'package:flutter_mental_health/views/psychological_test/test_result_screen.dart';
import 'package:flutter_mental_health/views/psychological_test/widgets/test_history_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class TestHistoryScreen extends StatefulWidget {
  const TestHistoryScreen({Key? key}) : super(key: key);
  static const id = "TestHistoryScreen";

  @override
  _TestHistoryScreenState createState() => _TestHistoryScreenState();
}

class _TestHistoryScreenState extends State<TestHistoryScreen> {
  @override
  void didChangeDependencies() {
    context.read<TestHistoryProvider>().getAllQuestionForTest();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.kPopupBackgroundColor,
        leading: IconButton(
            icon: Icon(CupertinoIcons.back, color: AppColors.kBlackColor),
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.id, (route) => false)),
        title: Text(
          "Test History",
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
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 10.h),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Consumer<TestHistoryProvider>(
                    builder: (context, provider, _) {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return TestHistoryItem(
                            onSeeMorePress: () {
                              context
                                  .read<PsychologicalTestProvider>()
                                  .viewTestHistoryDetail = true;
                              context
                                  .read<PsychologicalTestProvider>()
                                  .setQuestionDetailList(context
                                      .read<TestHistoryProvider>()
                                      .psychologicalTestList[index]
                                      .questionDetailList);
                              Navigator.pushNamed(context, TestResultScreen.id);
                            },
                            point: provider.psychologicalTestList[index].point,
                            date: FormatDateTime.formatterDay.format(provider
                                .psychologicalTestList[index].createdAt),
                          );
                        },
                        itemCount: provider.psychologicalTestList.length,
                        separatorBuilder: (context, index) => SizedBox(
                          height: 5.h,
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
                  context
                      .read<PsychologicalTestProvider>()
                      .clearPsychologicalTest(true);
                  Navigator.pushNamed(context, PsychologicalTestScreen.id);
                },
                child: Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 25.w),
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 25.w),
                  decoration: const BoxDecoration(
                    color: AppColors.kButtonColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Take the test",
                      style: TextStyle(
                        fontSize: 12.sp,
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
