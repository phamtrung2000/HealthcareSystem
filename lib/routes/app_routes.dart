import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mental_health/models/authentication/user.dart';
import 'package:flutter_mental_health/models/commutity/post.dart';
import 'package:flutter_mental_health/view_models/admin/admin_change_container.dart';
import 'package:flutter_mental_health/view_models/chat_room/chat_room_add_provider.dart';
import 'package:flutter_mental_health/view_models/chat_room/chat_room_provider.dart';
import 'package:flutter_mental_health/view_models/community/comments_reply_provider.dart';
import 'package:flutter_mental_health/view_models/community/community_provider.dart';
import 'package:flutter_mental_health/view_models/community/create_post_provider.dart';
import 'package:flutter_mental_health/view_models/community/full_post_provider.dart';
import 'package:flutter_mental_health/view_models/psychological_test/psychological_test_provider.dart';
import 'package:flutter_mental_health/view_models/psychological_test/test_history_provider.dart';
import 'package:flutter_mental_health/view_models/reports/report_problem_provider.dart';
import 'package:flutter_mental_health/view_models/reports/report_user_provider.dart';
import 'package:flutter_mental_health/views/admin/admin_screen.dart';
import 'package:flutter_mental_health/view_models/reports/report_problem_provider.dart';
import 'package:flutter_mental_health/view_models/daily_checkin/daily_checkin_provider.dart';
import 'package:flutter_mental_health/view_models/notification/notification_provider.dart';
import 'package:flutter_mental_health/views/admin/components/admin_ban_user.dart';
import 'package:flutter_mental_health/views/admin/components/admin_mute_user.dart';
import 'package:flutter_mental_health/views/admin/widgets/ban_mute_user.dart';
import 'package:flutter_mental_health/views/admin/widgets/hero_dialog_route.dart';
import 'package:flutter_mental_health/views/admin/widgets/show_dialog.dart';
import 'package:flutter_mental_health/views/authentication/authentication_screen.dart';
import 'package:flutter_mental_health/views/authentication/components/signup/signup_with_email/sign_up_email_body.dart';
import 'package:flutter_mental_health/views/authentication/components/signup/signup_with_phone/create_password.dart';
import 'package:flutter_mental_health/views/authentication/components/signup/signup_with_phone/phone_authentication/sign_up_authen.dart';
import 'package:flutter_mental_health/views/authentication/components/signup/signup_with_phone/sign_up_with_phone.dart';
import 'package:flutter_mental_health/views/change_password/change_password_screen.dart';
import 'package:flutter_mental_health/views/chat/chat_admin_add_member.dart';
import 'package:flutter_mental_health/views/chat/chat_admin_controller.dart';
import 'package:flutter_mental_health/views/chat/chat_admin_members.dart';
import 'package:flutter_mental_health/views/chat/chat_screen.dart';
import 'package:flutter_mental_health/views/chat/create_chat_room_screen.dart';
import 'package:flutter_mental_health/views/community/comment_reply_screen.dart';
import 'package:flutter_mental_health/views/community/community_screen.dart';
import 'package:flutter_mental_health/views/community/create_post_screen.dart';
import 'package:flutter_mental_health/views/community/fullpost_screen.dart';
import 'package:flutter_mental_health/views/community/photoview_screen.dart';
import 'package:flutter_mental_health/views/community/widgets/image_post.dart';
import 'package:flutter_mental_health/views/data_policy/data_policy_screen.dart';
import 'package:flutter_mental_health/views/feedback_history/edit_feedback_screen.dart';
import 'package:flutter_mental_health/views/feedback_history/feedback_screen.dart';
import 'package:flutter_mental_health/views/help_center/help_center_screen.dart';
import 'package:flutter_mental_health/views/home_screen.dart';
import 'package:flutter_mental_health/views/menu_screen/menu_screen.dart';
import 'package:flutter_mental_health/views/onboard_screen/loading_screen.dart';
import 'package:flutter_mental_health/views/onboarding_screen/onboarding_screen.dart';
import 'package:flutter_mental_health/views/profile/my_profile_screen.dart';
import 'package:flutter_mental_health/views/notification/notification_screen.dart';
import 'package:flutter_mental_health/views/psychological_test/psychological_test_screen.dart';
import 'package:flutter_mental_health/views/psychological_test/test_history_screen.dart';
import 'package:flutter_mental_health/views/psychological_test/test_result_screen.dart';
import 'package:flutter_mental_health/views/reports/report_problem/report_problem_screen.dart';
import 'package:flutter_mental_health/views/reports/report_user/report_user_screen.dart';
import 'package:flutter_mental_health/views/reset_password/forgot_password_screen.dart';
import 'package:flutter_mental_health/views/reset_password/mobile_code_screen.dart';
import 'package:flutter_mental_health/views/reset_password/reset_password_screen.dart';
import 'package:flutter_mental_health/views/daily_checkin/add_description_screen.dart';
import 'package:provider/provider.dart';

class AppRoutes {
  static final AppRoutes _singleton = AppRoutes._internal();

  factory AppRoutes() {
    return _singleton;
  }

  AppRoutes._internal();
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ReportProblemScreen.id:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => ChangeNotifierProvider(
            create: (BuildContext context) => ReportProblemProvider(),
            child: ReportProblemScreen(),
          ),
        );
      case HomeScreen.id:
        // final args = settings.arguments as HomeScreenArgument;
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => HomeScreen(),
        );
      case DataPolicyScreen.id:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => DataPolicyScreen(),
        );
      case FullPostScreen.id:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => ChangeNotifierProvider(
            create: (BuildContext context) =>
                FullPostProvider(settings.arguments as Post),
            child: FullPostScreen(),
          ),
        );
      case MyProfileScreen.id:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => MyProfileScreen(),
        );
      case HelpCenterScreen.id:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => HelpCenterScreen(),
        );
      case MenuScreen.id:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => const MenuScreen(),
        );

      case TestHistoryScreen.id:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => ChangeNotifierProvider(
            create: (BuildContext context) => TestHistoryProvider(),
            child: TestHistoryScreen(),
          ),
        );
      case TestResultScreen.id:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => TestResultScreen(),
        );
      case ReportUserScreen.id:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => ChangeNotifierProvider(
            create: (BuildContext context) =>
                ReportUserProvider(settings.arguments as User),
            child: ReportUserScreen(),
          ),
        );
      case PsychologicalTestScreen.id:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => PsychologicalTestScreen(),
        );
      case CommunityScreen.id:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => ChangeNotifierProvider(
            create: (BuildContext context) => CommunityProvider(),
            child: CommunityScreen(),
          ),
        );
      case CommentReply.id:
        final args = settings.arguments as CommentReplyAgrument;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (BuildContext context) => CommentReplyProvider(
                  args.parent.commentId,
                  args.postId,
                ),
              ),
              ChangeNotifierProvider.value(value: args.fullPostProvider)
            ],
            child: const CommentReply(),
          ),
        );
      case CreatePost.id:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => ChangeNotifierProvider(
            create: (BuildContext context) => CreatePostProvider(),
            child: CreatePost(),
          ),
        );

      case AuthenticationScreen.id:
        return CupertinoPageRoute(
          settings: settings,
          builder: (context) => AuthenticationScreen(),
        );
      case AdminScreen.id:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => ChangeNotifierProvider.value(
            value: ChangeContainer(),
            child: const AdminScreen(),
          ),
        );
      // settings: settings, builder: (context) => AdminScreen());
      // case SignUpWithPhone.id:
      //   return MaterialPageRoute(
      //       settings: settings, builder: (context) => const SignUpWithPhone());
      case SignUpWithEmail.id:
        return MaterialPageRoute(
            settings: settings, builder: (context) => const SignUpWithEmail());
      // case SignUpAuthenticate.id:
      //   return MaterialPageRoute(
      //       settings: settings,
      //       builder: (context) {
      //         return SignUpAuthenticate();
      //       });
      case CreatePassword.id:
        return MaterialPageRoute(
            settings: settings, builder: (context) => CreatePassword());
      case AdminBanUser.id:
        final args = settings.arguments as BanUserArguments;
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => AdminBanUser(
                  fullName: args.name,
                  userId: args.userId,
                  email: args.email,
                  avatar: args.avatar,
                ));
      case AdminMuteUser.id:
        final args = settings.arguments as MuteUserArguments;
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => AdminMuteUser(
                  userId: args.userId,
                  email: args.email,
                  fullName: args.fullName,
                  avatar: args.avatar,
                ));
      case HeroDialogRoute.id:
        final args = settings.arguments as BanMuteUserArguments;
        return HeroDialogRoute(
          builder: (context) {
            return BanMuteUser(
              userId: args.userId,
              fullName: args.fullName,
              avatar: args.avatar,
              email: args.email,
            );
          },
        );
      case ShowDialog.id:
        final args = settings.arguments as String;

        return HeroDialogRoute(
          builder: (context) {
            return ShowDialog(string: args);
          },
        );
      case ForgotPasswordScreen.id:
        return MaterialPageRoute(
            settings: settings, builder: (context) => const ForgotPasswordScreen());
      case MobileCodeScreen.id:
        return MaterialPageRoute(
            settings: settings, builder: (context) => const MobileCodeScreen());
      case ResetPasswordScreen.id:
        return MaterialPageRoute(
            settings: settings, builder: (context) => const ResetPasswordScreen());
      case LoadingScreen.id:
        return MaterialPageRoute(
            settings: settings, builder: (context) => const LoadingScreen());
      case ChatScreen.id:
        final args = settings.arguments as ChatScreenArgument;
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => ChatScreen(
                  roomId: args.idRoom,
                  roomName: args.roomName,
                ));
      case ChangePasswordScreen.id:
        return MaterialPageRoute(
            settings: settings, builder: (context) => ChangePasswordScreen());
      case OnboardingScreen.id:
        return MaterialPageRoute(
            settings: settings, builder: (context) => OnboardingScreen());
      case CreateChatRoomScreen.id:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => ChangeNotifierProvider(
            create: (BuildContext context) => ChatRoomProvider(),
            child: CreateChatRoomScreen(),
          ),
        );
      case ChatScreenMembers.id:
        final args = settings.arguments as ChatAdminMemberArgument;

        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => ChatScreenMembers(
            roomId: args.roomId,
          ),
        );
      case PhotoViewer.id:
        final args = settings.arguments as PostImageArgument;
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => PhotoViewer(
            initialIndex: args.index,
            imagePaths: args.image,
          ),
        );
      case AddDescriptionScreen.id:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => ChangeNotifierProvider(
            create: (BuildContext context) => DailyCheckinProvider(),
            child: AddDescriptionScreen(),
          ),
        );
      case ChatAdminController.id:
        final args = settings.arguments as ChatAdminControllerArgument;
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => ChatAdminController(
                  roomId: args.roomId,
                ));
      case ChatAdminAddMember.id:
        final args = settings.arguments as ChatAdminAddMemberArgument;

        return CupertinoPageRoute(
          settings: settings,
          builder: (BuildContext context) =>
              ChatAdminAddMember(roomId: args.roomId),
        );
      case NotificationScreen.id:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => ChangeNotifierProvider(
            create: (BuildContext context) =>
                NotificationProvider(settings.arguments as User),
            child: NotificationScreen(),
          ),
        );

      default:
        return _errorRoute();
    }
  }

  Route _errorRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text('Error'),
        ),
      ),
      settings: const RouteSettings(
        name: '/error',
      ),
    );
  }
}
