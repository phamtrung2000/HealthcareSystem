import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/constants/format_date.dart';
import 'package:flutter_mental_health/models/feedback_model.dart';
import 'package:flutter_mental_health/services/data_provider.dart';
import 'package:flutter_mental_health/views/feedback_history/edit_feedback_screen.dart';
import 'package:flutter_mental_health/views/feedback_history/feedback_history_screen.dart';
import 'package:flutter_mental_health/views/onboard_screen/widgets/generic_loading_animation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'feedback_arguments.dart';

class FeedbackScreen extends StatefulWidget {
  static const id = "FeedbackScreen";

  final String feedbackID;
  const FeedbackScreen({Key? key, required this.feedbackID}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FeedbackState();
  }
}

class _FeedbackState extends State<FeedbackScreen> {
  Future<FeedbackModel> _getFeedback(String id) async {
    return await DataProvider().getFeedback(id);
  }

  String _feedbackID = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _feedbackID = widget.feedbackID;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kProfileInputColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        foregroundColor: AppColors.kBlackColor,
        backgroundColor: AppColors.kPopupBackgroundColor,
        title: Text(
          'Feedback',
          style: TextConfigs.kText24w400Black,
        ),
      ),

      body: FutureBuilder<FeedbackModel>(
        future: _getFeedback(_feedbackID),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: GenericLoadingAnimation(),);
          }
          else {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.kPopupBackgroundColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15.h),
                            bottomRight: Radius.circular(15.h),
                          )),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(
                            height: 1,
                            thickness: 1,
                            color: AppColors.kGreyTextTouchableColor,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 30.w, right: 30.w, bottom: 20.h, top: 15.h),
                            child: Column(

                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                  children: [
                                    Flexible(
                                      child: Text(
                                        snapshot.data!.title,
                                        style: TextConfigs.kText18w700Black,
                                        maxLines: 2,
                                      ),
                                    ),
                                    Text(
                                      FormatDateTime.formatterDay.format(snapshot.data!.date),
                                      style: TextConfigs.kText14w400Black,
                                    ),
                                  ],
                                ),
                                Text(
                                  snapshot.data!.description,
                                  style: TextConfigs.kText20w400Black,
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            height: 1,
                            thickness: 1,
                            color: AppColors.kGreyTextTouchableColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                    height: 130,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.files?.length,
                        itemBuilder: (context, index){
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    height: 130,
                                    width: 130,
                                    child: Image.network(snapshot.data!.files!.elementAt(index),),
                                  ),
                                ),
                              ],
                            ),

                          );
                        }
                    )
                ),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: Divider(thickness: 2,),
                  //Divider(thickness: 2,),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 43.h,
                      width: 342.w,
                      margin: EdgeInsets.fromLTRB(36.w, 2.h, 36.w, 12.h),
                      child: TextButton(
                        onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => EditFeedBackScreen(feedID: _feedbackID,)),);},
                        style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),), backgroundColor: AppColors.kButtonColor,),
                        child: Text('Edit', style: TextConfigs.kText16w400White,),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),

    );
  }
}