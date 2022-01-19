import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/models/authentication/login_request_model.dart';
import 'package:flutter_mental_health/services/data_repository.dart';
import '../data_provicy.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'signup/sign_up_body.dart';
import 'login_body.dart';

class TabControl extends StatefulWidget {
  const TabControl({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TabControlState();
  }
}

class _TabControlState extends State<TabControl>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Builder(builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.kPopupBackgroundColor,
            shadowColor: Colors.transparent,
            bottom: TabBar(
                controller: _tabController,
                indicatorColor: AppColors.kBlackColor,
                labelColor: AppColors.kBlackColor,
                unselectedLabelColor: AppColors.kGreyBackgroundColor,
                tabs: [
                  Tab(
                    child: Text("Login", style: TextConfigs.kText24w600Black),
                  ),
                  Tab(
                    child: Text("Sign up", style: TextConfigs.kText24w600Black),
                  )
                ]),
          ),
          body: TabBarView(controller: _tabController, children: [
            LoginScreen(),
            const SignUpScreen(),
          ]),
        );
      }),
    );
  }
}
