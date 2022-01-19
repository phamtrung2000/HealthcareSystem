import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountDownText extends StatefulWidget {
  const CountDownText({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CountDownTextState();
  }
}

class _CountDownTextState extends State<CountDownText> {
  Duration duration = const Duration();
  static const countdownDuration = Duration(minutes: 5);
  Timer? timer;
  bool isCountDown = true;
  @override
  void initState() {
    super.initState();
    startTimer();
    reset();
  }

  void reset() {
    if (!isCountDown) {
      setState(() {
        duration = const Duration();
      });
    } else {
      setState(() {
        duration = countdownDuration;
      });
    }
  }

  void startTimer() {
    timer =
        Timer.periodic(const Duration(seconds: 1), (_) => {countdownTime()});
  }

  void countdownTime() {
    const countseconds = -1;
    setState(() {
      final seconds = duration.inSeconds + countseconds;
      if (seconds < 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return (Text(
      '$minutes:$seconds',
      style: TextConfigs.kText14w700linkColor,
    ));
  }
}
