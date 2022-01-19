import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';

class ExpandedMenuItem extends StatelessWidget {
  const ExpandedMenuItem({
    Key? key,
    required this.children,
    required this.icon,
    required this.title,
  }) : super(key: key);

  final Widget icon;
  final List<Widget> children;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        title,
        style: TextConfigs.kText20w400Black,
      ),
      leading: icon,
      children: children,
      textColor: Colors.black,
      iconColor: Colors.black,
      tilePadding: const EdgeInsets.symmetric(horizontal: 8.0),
      childrenPadding: EdgeInsets.zero,
    );
  }
}
