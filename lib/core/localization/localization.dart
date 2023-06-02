import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

AppLocalizations getString(BuildContext context) {
  return AppLocalizations.of(context)!;
}

extension MyAppocalization on BuildContext {
  AppLocalizations getString() {
    return AppLocalizations.of(this)!;
  }
}
