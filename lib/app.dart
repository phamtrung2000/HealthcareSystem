import 'package:flutter/material.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mental_health/routes/app_routes.dart';
import 'package:flutter_mental_health/services/data_provider.dart';
import 'package:flutter_mental_health/view_models/admin/admin_provider.dart';
import 'package:flutter_mental_health/view_models/app_provider.dart';
import 'package:flutter_mental_health/view_models/app_started/app_started_provider.dart';
import 'package:flutter_mental_health/view_models/auth/auth_provider.dart';
import 'package:flutter_mental_health/view_models/chat_room/chat_room_add_provider.dart';
import 'package:flutter_mental_health/view_models/daily_checkin/daily_checkin_provider.dart';
import 'package:flutter_mental_health/view_models/psychological_test/psychological_test_provider.dart';
import 'package:flutter_mental_health/view_models/psychological_test/test_history_provider.dart';
import 'package:flutter_mental_health/view_models/reports/report_problem_provider.dart';
import 'package:flutter_mental_health/views/change_password/change_password_screen.dart';
import 'package:flutter_mental_health/views/feedback_history/edit_feedback_screen.dart';
import 'package:flutter_mental_health/views/feedback_history/feedback_history_screen.dart';
import 'package:flutter_mental_health/views/feedback_history/feedback_screen.dart';
import "package:flutter_mental_health/views/home_screen.dart";
import 'package:flutter_mental_health/view_models/daily_checkin/daily_checkin_provider.dart';
import 'package:flutter_mental_health/view_models/notification/notification_provider.dart';
import 'package:flutter_mental_health/view_models/user/user_provider.dart';
import 'package:flutter_mental_health/views/authentication/authentication_screen.dart';
import 'package:flutter_mental_health/view_models/reports/report_user_provider.dart';
import 'package:flutter_mental_health/views/chat/chat_screen.dart';
import 'package:flutter_mental_health/views/onboarding_screen/onboarding_screen.dart';
import 'package:flutter_mental_health/view_models/community/community_provider.dart';
import 'package:flutter_mental_health/view_models/help_center/help_center.dart';
import 'package:flutter_mental_health/view_models/chat/chat_room_message_provider.dart';
import 'package:flutter_mental_health/view_models/psychological_test/test_history_provider.dart';
import 'package:flutter_mental_health/view_models/reports/report_problem_provider.dart';
import 'package:flutter_mental_health/view_models/reports/report_user_provider.dart';
import 'package:flutter_mental_health/views/onboarding_screen/onboarding_screen.dart';
import 'package:flutter_mental_health/views/help_center/help_center_screen.dart';
import 'package:flutter_mental_health/views/chat/chat_screen.dart';
import 'package:flutter_mental_health/views/reset_password/forgot_password_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mental_health/view_models/auth/auth_provider.dart';

class MentalHealthApp extends StatelessWidget {
  const MentalHealthApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 736),
      builder: () {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
                create: (BuildContext context) => AuthProvider()),
            ChangeNotifierProvider(
                create: (BuildContext context) => AdminProvider()),
            ChangeNotifierProvider(
              create: (BuildContext context) => ReportProblemProvider(),
            ),
            ChangeNotifierProvider(
              create: (BuildContext context) => PsychologicalTestProvider(),
            ),
            ChangeNotifierProvider<TestHistoryProvider>(
              create: (context) => TestHistoryProvider(),
              lazy: false,
            ),
            ChangeNotifierProvider(
              create: (BuildContext context) => CommunityProvider(),
            ),
            ChangeNotifierProvider(
              create: (BuildContext context) => HelpCenterProvider(),
            ),
            ChangeNotifierProvider(
              create: (BuildContext context) => DailyCheckinProvider(),
            ),
            ChangeNotifierProvider(
              create: (BuildContext context) => ChatRoomAddProvider(),
            ),
            ChangeNotifierProvider(
              create: (BuildContext context) => ChatMessageProvider(),
            ),
            ChangeNotifierProvider(
              create: (BuildContext context) =>
                  NotificationProvider(context.read<AuthProvider>().user),
            ),
            ChangeNotifierProvider(
              create: (BuildContext context) => UserProvider(),
            ),
          ],
          child: MaterialApp(
            localizationsDelegates: const [
              //AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('vi'),
            ],
            locale: context.watch<AppProvider>().locale,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: AppRoutes().onGenerateRoute,
            //home: HomeScreen(),
            initialRoute: context.read<AppStartedProvider>().showOnboarding
                ? OnboardingScreen.id
                : AuthenticationScreen.id,
          ),
        );
      },
    );
  }
}
