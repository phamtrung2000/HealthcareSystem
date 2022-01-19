import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    required this.onTap,
    required this.title,
    required this.color,
    this.width = double.infinity,
    this.titleStyle,
  }) : super(key: key);
  final VoidCallback onTap;
  final String title;
  final Color color;
  final double width;
  final TextStyle? titleStyle;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: color,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: titleStyle ?? TextConfigs.kText16w400White,
          ),
        ),
      ),
    );
  }
}
