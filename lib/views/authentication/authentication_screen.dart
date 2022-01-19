import 'package:flutter/material.dart';

import 'components/tabcontrol.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);
  static const id = "Authentication";

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    return (const Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(child: TabControl()),
    ));
  }
}
