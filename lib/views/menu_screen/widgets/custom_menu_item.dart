import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_mental_health/views/Menu_screen/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomMenuItem extends StatelessWidget {
  CustomMenuItem({
    Key? key,
    required this.title,
    required this.iconPath,
    required this.onTap,
  }) : super(key: key);
  final String title;
  final VoidCallback onTap;
  final String iconPath;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextConfigs.kText20w400Black,
      ),
      leading: SvgPicture.asset(
        'assets/icons/$iconPath',
        height: 40,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
      onTap: onTap,
    );
  }
}
