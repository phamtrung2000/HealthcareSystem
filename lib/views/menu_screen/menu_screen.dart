import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/app_configs.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/models/authentication/user.dart';
import 'package:flutter_mental_health/services/data_repository.dart';
import 'package:flutter_mental_health/view_models/auth/auth_provider.dart';
import 'package:flutter_mental_health/views/admin/admin_screen.dart';
import 'package:flutter_mental_health/views/authentication/components/login_body.dart';
import 'package:flutter_mental_health/views/feedback_history/feedback_history.dart';
import 'package:flutter_mental_health/views/feedback_history/feedback_history_screen.dart';
import 'package:flutter_mental_health/views/menu_screen/utils.dart';
import 'package:flutter_mental_health/views/menu_screen/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/src/provider.dart';
import 'package:flutter_mental_health/views/authentication/authentication_screen.dart';
import 'package:flutter_mental_health/views/change_password/change_password_screen.dart';
import 'package:flutter_mental_health/views/data_policy/data_policy_screen.dart';
import 'package:flutter_mental_health/views/help_center/help_center_screen.dart';
import 'package:flutter_mental_health/views/menu_screen/utils.dart';
import 'package:flutter_mental_health/views/menu_screen/widgets/widgets.dart';
import 'package:flutter_mental_health/views/profile/my_profile_screen.dart';
import 'package:flutter_mental_health/views/psychological_test/test_history_screen.dart';
import 'package:flutter_mental_health/views/reports/report_problem/report_problem_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);
  static const id = "MenuScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.kBackgroundColor,
        title: Text(
          'Menu',
          style: TextConfigs.kText24w400Black,
        ),
      ),
      body: const Body(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingItems = [
      CardItem(
        onTap: () {
          Navigator.of(context, rootNavigator: true)
              .pushNamed(ChangePasswordScreen.id);
        },
        icon: SvgAsset.getAsset('key.svg'),
        title: 'Change password',
      ),
    ];
    final helpItems = [
      CardItem(
        onTap: () {
          Navigator.of(context, rootNavigator: true)
              .pushNamed(HelpCenterScreen.id);
        },
        icon: SvgAsset.getAsset('help.svg'),
        title: 'Help center',
      ),
      CardItem(
        onTap: () {
          Navigator.of(context, rootNavigator: true)
              .pushNamed(ReportProblemScreen.id);
        },
        icon: SvgAsset.getAsset('report.svg'),
        title: 'Report a problem',
      ),
      CardItem(
        onTap: () {
          Navigator.of(context, rootNavigator: true)
              .pushNamed(DataPolicyScreen.id);
        },
        icon: SvgAsset.getAsset('policies.svg'),
        title: 'Data policy',
      ),
    ];
    void navigatorToAdmin() {
      Navigator.of(context, rootNavigator: true).pushNamed(AdminScreen.id);
    }

    final sections = [
      context.watch<AuthProvider>().user.role == 1
          ? Column(children: [
              CustomMenuItem(
                title: 'Administration',
                iconPath: 'administration.svg',
                onTap: () {
                  navigatorToAdmin();
                },
              ),
              Divider(),
            ])
          : SizedBox(height: 0.0.h),
      CustomMenuItem(
          title: 'Test history',
          iconPath: 'list2.svg',
          onTap: () => Navigator.of(context, rootNavigator: true)
              .pushNamed(TestHistoryScreen.id)),
      Divider(),
      CustomMenuItem(
        title: 'Feedback History',
        iconPath: 'ic_history.svg',
        onTap: () => pushNewScreen(
          context,
          screen: const FeedbackHistoryScreen(),
          withNavBar: false,
        ),
      ),
      Divider(),
      CustomMenuItem(
        title: 'Check in history',
        iconPath: 'calendar.svg',
        onTap: () {},
      ),
      Divider(),
      CustomMenuItem(
        title: 'My question',
        iconPath: 'list.svg',
        onTap: () {},
      ),
      Divider(),
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.0.h),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0.h),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 24,
                  backgroundImage:
                      NetworkImage(context.watch<AuthProvider>().user.avatar),
                ),
                title: Text(context.watch<AuthProvider>().user.fullname,
                    style: TextConfigs.kText24w400Black),
                subtitle: Text('See your profile',
                    style: TextConfigs.kText14w400Black),
                contentPadding: EdgeInsets.zero,
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(MyProfileScreen.id);
                },
              ),
            ),
            const Divider(),
            Column(children: sections),
            ExpandedMenuItem(
              children: helpItems,
              icon: SvgPicture.asset(
                'assets/icon/info.svg',
                height: 40.h,
              ),
              title: 'Help & support',
            ),
            const Divider(),
            ExpandedMenuItem(
              children: settingItems,
              icon: SvgPicture.asset(
                'assets/icons/settings.svg',
                height: 40.h,
              ),
              title: 'Setting',
            ),
            const SizedBox(height: 12.0),
            DefaultButton(
              onTap: () => showDialog(
                context: context,
                builder: _buildSignOutConfirmDialog,
              ),
              title: 'Sign out',
              color: AppColors.kButtonColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignOutConfirmDialog(context) {
    return AlertDialog(
      backgroundColor: AppColors.kBackgroundColor,
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0.r),
      ),
      actionsPadding: EdgeInsets.all(8.0.r),
      insetPadding: EdgeInsets.zero,
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.width * 0.15,
        child: Center(
          child: Text(
            'Log out from Healthcare?',
            style: TextConfigs.kText14w400Black,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      contentPadding: EdgeInsets.zero,
      actions: [
        Row(
          children: [
            Expanded(
              child: DefaultButton(
                onTap: () => Navigator.pop(context, 'NO'),
                color: AppColors.kButtonColor.withOpacity(0.35),
                title: 'No',
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: DefaultButton(
                onTap: () => Navigator.of(context, rootNavigator: true)
                    .pushNamedAndRemoveUntil(
                        AuthenticationScreen.id, (_) => false),
                color: AppColors.kButtonColor,
                title: 'Yes',
              ),
            ),
          ],
        )
      ],
    );
  }
}

class EmptyPage extends StatelessWidget {
  const EmptyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('login page'));
  }
}
