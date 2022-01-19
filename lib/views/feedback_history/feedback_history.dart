import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/models/feedback_model.dart';
import 'package:shimmer/shimmer.dart';

import 'feedback_item.dart';

class FeedbackHistoryPage extends StatelessWidget {
  const FeedbackHistoryPage({Key? key}) : super(key: key);
  static const String id = "EmptyPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPopupBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Feedback history', style: TextConfigs.kText24w400Black),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 1,
      ),
      body: FutureBuilder<List<FeedbackModel>>(
        future: _futureFeedbacks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingFeedbackPlaceholder();
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final feedback = snapshot.data![index];
                  return FeedbackItem(feedback);
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class LoadingFeedbackPlaceholder extends StatelessWidget {
  const LoadingFeedbackPlaceholder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.kFeedbackCardItemColor,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 25,
            ),
            margin: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    LoadingShimmerText(width: 80),
                    LoadingShimmerText(width: 130),
                  ],
                ),
                const SizedBox(height: 8),
                const LoadingShimmerText(),
                const SizedBox(height: 8),
                const LoadingShimmerText(),
                const SizedBox(height: 8),
                const LoadingShimmerText(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class LoadingShimmerText extends StatelessWidget {
  const LoadingShimmerText({
    Key? key,
    this.width = double.infinity,
  }) : super(key: key);
  final double width;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.kFeedbackCardItemPlaceholderColor,
      highlightColor:
          AppColors.kFeedbackCardItemPlaceholderColor.withOpacity(0.3),
      child: Container(
        color: AppColors.kBackgroundAdmin,
        width: width,
        height: 16,
      ),
    );
  }
}

final _futureFeedbacks = Future<List<FeedbackModel>>.delayed(
  const Duration(seconds: 5),
  () => _feedbacks,
);

final _feedbacks = <FeedbackModel>[
  FeedbackModel(
    feedbackID: 'feedbackID',
    title: 'Title',
    date: DateTime.now(),
    description:
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
    files: ['files', 'file2', 'file3'],
    userID: 'Foobar',
  ),
  FeedbackModel(
    feedbackID: 'feedbackID',
    title: 'Title',
    date: DateTime.now(),
    description: 'content',
    files: ['files'],
    userID: 'Foobar',
  ),
  FeedbackModel(
    feedbackID: 'feedbackID',
    title: 'Title',
    date: DateTime.now(),
    description: 'content',
    userID: 'Foobar',
  ),
  FeedbackModel(
    feedbackID: 'feedbackID',
    title: 'Title',
    date: DateTime.now(),
    description: 'content',
    userID: 'Foobar',
  ),
  FeedbackModel(
    feedbackID: 'feedbackID',
    title: 'Title',
    date: DateTime.now(),
    description: 'content',
    files: ['files'],
    userID: 'Foobar',
  ),
];
