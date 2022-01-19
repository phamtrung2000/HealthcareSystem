import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'feedback_detail.dart';
import '../../models/feedback_model.dart';

class FeedbackItem extends StatelessWidget {
  final FeedbackModel feedback;

  const FeedbackItem(
    this.feedback, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => pushNewScreen(context, screen: FeedbackDetail(feedback)),
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 25,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.kFeedbackCardItemColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(feedback.title, style: TextConfigs.kText18w700Black),
                Text(
                  DateFormat.yMMMd().format(feedback.date),
                  style: TextConfigs.kText14w400Black,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              feedback.description,
              maxLines: 3,
              style: TextConfigs.kText16w400Black,
            ),
            const SizedBox(height: 8),
            feedback.files != null
                ? SizedBox(
                    height: 30,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/ic_attach.svg',
                          height: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Attached files',
                          style: TextConfigs.kText14w400Black,
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
