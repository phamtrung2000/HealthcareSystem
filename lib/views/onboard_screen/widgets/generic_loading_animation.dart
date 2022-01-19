import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GenericLoadingAnimation extends StatelessWidget {
  final String animation;

  static const String _defaultAnimation = 'assets/animations/smooth_healthy_animation.json';
  const GenericLoadingAnimation({Key? key, this.animation = _defaultAnimation}) : super(key : key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Lottie.asset(animation),
    );
  }
}