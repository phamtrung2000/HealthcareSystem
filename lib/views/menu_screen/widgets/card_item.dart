import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    Key? key,
    required this.icon,
    required this.title,
    this.onTap,
  }) : super(key: key);

  final Widget icon;
  final String title;
  final GestureTapCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: AppColors.kPopupBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              icon,
              const SizedBox(width: 8.0),
              Text(
                title,
                style: TextConfigs.kText18w400BlueGrey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
