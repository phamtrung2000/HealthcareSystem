import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// If we have options for user to watch the Onboarding again
/// ex: D
class AppStartedProvider extends ChangeNotifier {
  static const String appStartedKey = 'show-onboarding-key';
  final SharedPreferences prefs;

  AppStartedProvider(this.prefs);

  /// The first time we got null - so show user onboarding screen.
  bool get showOnboarding {
    final isFirstTime = prefs.getBool(appStartedKey);
    prefs.setBool(appStartedKey, false);
    return isFirstTime ?? true;
  }
}
