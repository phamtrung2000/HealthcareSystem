class FeedbackArguments {
  final String feedbackID;
  final String title;
  final String description;
  final String userID;
  final List<String>? files;

  FeedbackArguments({
    required this.feedbackID,
    required this.title,
    required this.description,
    required this.userID,
    required this.files
  });
}