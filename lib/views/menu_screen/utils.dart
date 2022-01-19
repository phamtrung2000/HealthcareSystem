import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Wrapper for WebsafeSvg, easier to use without duplicating ourselves
extension SvgAsset on SvgPicture {
  static Widget getAsset(String name) {
    return SvgPicture.asset('assets/icons/$name');
  }
}
