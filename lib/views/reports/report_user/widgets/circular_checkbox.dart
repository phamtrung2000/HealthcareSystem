import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';

class CircularCheckbox extends StatelessWidget {
  final bool? value;
  final ValueChanged<bool?>? onChanged;
  const CircularCheckbox(
      {Key? key, required this.value, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.3,
      child: Checkbox(
        activeColor: AppColors.kBlackColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        side: BorderSide(width: 1.5, color: AppColors.kBlackColor),
        splashRadius: 0,
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
