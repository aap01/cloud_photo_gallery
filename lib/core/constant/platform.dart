import 'package:flutter/material.dart';

class Platform {
  Platform._();
  static bool isIOS(BuildContext context) =>
      Theme.of(context).platform == TargetPlatform.iOS;
  static bool isAndroid(BuildContext context) =>
      Theme.of(context).platform == TargetPlatform.android;
  static bool isMobile(BuildContext context) =>
      isIOS(context) || isAndroid(context);
}
