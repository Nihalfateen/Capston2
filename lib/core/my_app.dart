import 'package:capstone/core/theme/theme.dart';
import 'package:capstone/core/utils/app_routes.dart';
import 'package:capstone/core/utils/cache_helper.dart';
import 'package:capstone/view/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../view/home/home_view.dart';
import '../view/login_view.dart';
import 'constants/constants.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final String isLogged = CacheHelper.getPrefs(key: Constants.tokenPrefKey);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      supportedLocales: AppLocalizations.supportedLocales,

      localizationsDelegates: AppLocalizations.localizationsDelegates,
      locale: const Locale('ar'),
      // Method responsible for localeResolutionCallback return  device current locale
      localeResolutionCallback: (currentLocale, supportedLocales) {
        if (currentLocale != null) {
          for (Locale locale in supportedLocales) {
            if (currentLocale.languageCode == locale.languageCode) {
              return currentLocale;
            }
          }
        }
        return supportedLocales.first;
      },

      initialRoute: SplashView.route,
      routes: appRoutes(context),
    );
  }
}
