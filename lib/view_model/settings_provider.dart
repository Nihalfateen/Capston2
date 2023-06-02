import 'package:capstone/core/constants/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/cache_helper.dart';

final settingsProvider =
    ChangeNotifierProvider<SettingsProvider>((ref) => SettingsProvider());

class SettingsProvider with ChangeNotifier {
  bool isDark = false;
  String _token = "";
  String locale = CacheHelper.getPrefs(key: "locale") ?? "en";

  changeTheme(bool theme) {
    isDark = theme;
    notifyListeners();
  }

  getToken() {
    _token = CacheHelper.getPrefs(key: Constants.tokenPrefKey) ?? "";
    notifyListeners();
  }

  changeLocale(String localeCode) {
    locale = localeCode;
    CacheHelper.savePrefs(key: Constants.localePrefKey, value: localeCode);
    notifyListeners();
  }

  String get token => _token;
}
