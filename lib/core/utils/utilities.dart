import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:flutter_svg/svg.dart';

import '../localization/localization.dart';
import '../shared_widgets/animations.dart';
import '../theme/style.dart';

// AppLocalizations getString(BuildContext context) {
//   return AppLocalizations.of(context)!;
// }
String dateConverter(String dateUtc) {
  return DateFormat("yyyy-MM-dd HH:mm")
      .format(DateTime.parse(dateUtc).toLocal())
      .toString();
}

extension DebugPrintText on String {
  void printText() {
    debugPrint(this);
  }
}

showCustomDialogWithMultiSelect({
  required String text,
  // required DialogStatus status,
  required BuildContext context,
  required VoidCallback onCancelPressed,
  required VoidCallback onConfirmPressed,
  Color confirmColor = errorColor,
  Color cancelColor = textColor,
}) async {
  return showGeneralDialog(
    context: context,
    barrierLabel: '',
    barrierDismissible: true,
    transitionBuilder: (context, _animation, _secondaryAnimation, _child) {
      return Animations.grow(_animation, _secondaryAnimation, _child);
    },
    pageBuilder: (_animation, _secondaryAnimation, _child) {
      return AlertDialog(
        title: Text(
          getString(context).alert_title,
          style: TextStyle(
            color: cancelColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AutoSizeText(
                text,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 18,
                  color: blackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 13),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    child: AutoSizeText(
                      getString(context).ok,
                      style: TextStyle(
                        color: confirmColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: onConfirmPressed,
                  ),
                  TextButton(
                    child: AutoSizeText(
                      getString(context).cancel,
                      style: TextStyle(
                        color: cancelColor,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    onPressed: onCancelPressed,
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
