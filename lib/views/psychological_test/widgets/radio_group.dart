import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';

import 'custom_radio.dart';

class RadioGroup extends StatefulWidget {
  RadioGroup(
      {Key? key,
      required this.items,
      required this.onCheckChanged,
      this.checkedFillColor = AppColors.kPopupBackgroundColor,
      this.unCheckedBorderColor = AppColors.kBlackColor,
      this.haveCheckIcon = true,
      this.icon,
      this.shape = BoxShape.rectangle,
      this.titleMaxLines = 2,
      this.margin = const EdgeInsets.all(4),
      this.padding = const EdgeInsets.all(2),
      this.size = 24,
      this.borderRadius,
      this.style,
      this.centerSpace = 0,
      this.crossAxisAlignment = CrossAxisAlignment.start,
      this.mainAxisAlignment = MainAxisAlignment.spaceBetween})
      : super(key: key);
  final List<String> items;
  final Color checkedFillColor;
  final Color unCheckedBorderColor;
  final Widget? icon;
  final bool haveCheckIcon;
  final BoxShape shape;
  final int titleMaxLines;
  final void Function(String selectedItems) onCheckChanged;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double size;
  final BorderRadius? borderRadius;
  final TextStyle? style;
  final double centerSpace;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  @override
  _RadioGroupState createState() => _RadioGroupState();
}

class RadioState {
  final String title;
  bool value;

  RadioState({required this.title, this.value = false});
}

class _RadioGroupState extends State<RadioGroup> {
  List<RadioState> items = [];

  String? groupValue;

  @override
  void initState() {
    super.initState();
    items = widget.items.map((e) => RadioState(title: e)).toList();
    groupValue = widget.items.last;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: widget.mainAxisAlignment,
      crossAxisAlignment: widget.crossAxisAlignment,
      children: items.map(_buildCheckBox).toList(),
    );
  }

  Widget _buildCheckBox(RadioState radio) {
    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Theme(
            data: Theme.of(context).copyWith(
              unselectedWidgetColor: widget.unCheckedBorderColor,
            ),
            child: CustomRadio<String>(
              margin: widget.margin,
              padding: widget.padding,
              unCheckedBorderColor: widget.unCheckedBorderColor,
              checkedFillColor: widget.checkedFillColor,
              size: widget.size,
              shape: widget.shape,
              value: radio.title,
              groupValue: groupValue!,
              borderRadius: widget.shape == BoxShape.rectangle
                  ? widget.borderRadius
                  : null,
              onChanged: (String value) => setState(
                () {
                  groupValue = value;
                  widget.onCheckChanged(value);
                },
              ),
            ),
          ),
          SizedBox(
            width: widget.centerSpace,
          ),
          Text(
            radio.title,
            maxLines: widget.titleMaxLines,
            overflow: TextOverflow.ellipsis,
            style: widget.style,
          ),
        ],
      ),
    );
  }
}
