import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';

class CustomRadio<T> extends StatefulWidget {
  final T value;
  final T groupValue;
  final double size;
  final Color checkedFillColor;
  final Color unCheckedBorderColor;
  final Color checkedBorderColor;
  final Color iconColor;
  final ValueChanged<T> onChanged;
  final BorderRadius? borderRadius;
  final BoxShape shape;
  final EdgeInsets margin;
  final EdgeInsets padding;
  CustomRadio({
    required this.value,
    this.size = 24,
    this.checkedFillColor = AppColors.kPopupBackgroundColor,
    required this.onChanged,
    this.unCheckedBorderColor = AppColors.kBlackColor,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
    this.margin = const EdgeInsets.all(4),
    this.padding = const EdgeInsets.all(2),
    required this.groupValue,
    this.checkedBorderColor = AppColors.kBlackColor,
    this.iconColor = AppColors.kBlackColor,
  });

  @override
  _CustomRadioState<T> createState() => _CustomRadioState<T>();
}

class _CustomRadioState<T> extends State<CustomRadio<T>> {
  bool get _isSelected => widget.value == widget.groupValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(widget.value);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.linearToEaseOut,
        margin: widget.margin,
        padding: widget.padding,
        decoration: BoxDecoration(
            color: _isSelected ? widget.checkedFillColor : Colors.transparent,
            shape: widget.shape,
            borderRadius: widget.shape == BoxShape.circle
                ? null
                : widget.borderRadius ?? BorderRadius.circular(4),
            border: _isSelected
                ? Border.all(width: 1.0, color: widget.checkedBorderColor)
                : Border.all(
                    color: widget.unCheckedBorderColor,
                    width: 1.0,
                  )),
        width: widget.size,
        height: widget.size,
        constraints: BoxConstraints(
          minHeight: widget.size,
          maxWidth: widget.size,
          minWidth: widget.size,
          maxHeight: widget.size,
        ),
        child: _isSelected
            ? Center(
                child: Container(
                // ignore: prefer_const_constructors
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.iconColor,
                ),
              ))
            : null,
      ),
    );
  }
}
