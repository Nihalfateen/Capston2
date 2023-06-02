import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool> checkInternetConnection() async {
  try {
    final result = await InternetAddress.lookup("google.com");
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      debugPrint("connect");
      return true;
    } else {
      debugPrint("disconnect");
      return false;
    }
  } on SocketException catch (_) {
    return false;
  }
}

// // String getString(BuildContext context, String key) {
// //   return AppLocale.of(context)!.getString(key).toString();
// // }

// String convertDecToHex(String data) {
//   const dec2hex = AnyBase(AnyBase.dec, AnyBase.hex);
//   final result = dec2hex.convert(data);
//   Log.d("HEX $result");

//   return result;
// }

showToast({
  required String text,
  Toast length = Toast.LENGTH_LONG,
  ToastGravity gravity = ToastGravity.BOTTOM,
  Color bgColor = Colors.black,
  Color textColor = Colors.white,
  double fontSize = 16.0,
}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: length,
    gravity: gravity,
    timeInSecForIosWeb: 3,
    backgroundColor: bgColor,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

// showLoaderDialog(BuildContext context) {
//   AlertDialog alert = AlertDialog(
//     content: Row(
//       children: [
//         const CircularProgressIndicator(color: primaryColor),
//         const SizedBox(width: 10),
//         Text(getString(context).connecting),
//       ],
//     ),
//   );
//   showDialog(
//     barrierDismissible: false,
//     context: context,
//     builder: (BuildContext context) {
//       return alert;
//     },
//   );
// }

// showCustomDialog({
//   required String text,
//   required DialogStatus status,
//   required BuildContext context,
//   required VoidCallback onPressed,
//   required String image,
// }) async {
//   return showGeneralDialog(
//     context: context,
//     barrierLabel: '',
//     barrierDismissible: true,
//     transitionBuilder: (context, _animation, _secondaryAnimation, _child) {
//       return Animations.grow(_animation, _secondaryAnimation, _child);
//     },
//     pageBuilder: (_animation, _secondaryAnimation, _child) {
//       return AlertDialog(
//         title: SvgPicture.asset(
//           image,
//           // width: 45,
//           // height: 60,
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             AutoSizeText(
//               text,
//               style: const TextStyle(
//                 fontSize: 15,
//                 color: blackColor,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 13),
//             TextButton(
//               child: AutoSizeText(
//                 DialogStatus.success == status
//                     ? getString(context).ok
//                     : getString(context).cancel,
//                 style: TextStyle(
//                   color: DialogStatus.success == status
//                       ? successColor
//                       : errorColor,
//                   fontSize: 15,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               onPressed: onPressed,
//             )
//           ],
//         ),
//       );
//     },
//   );
// }

// showCustomDialogWithMultiSelect({
//   required String text,
//   // required DialogStatus status,
//   required BuildContext context,
//   required VoidCallback onCancelPressed,
//   required VoidCallback onConfirmPressed,
//   Color confirmColor = successColor,
//   Color cancelColor = errorColor,
//   required String image,
// }) async {
//   return showGeneralDialog(
//     context: context,
//     barrierLabel: '',
//     barrierDismissible: true,
//     transitionBuilder: (context, _animation, _secondaryAnimation, _child) {
//       return Animations.grow(_animation, _secondaryAnimation, _child);
//     },
//     pageBuilder: (_animation, _secondaryAnimation, _child) {
//       return AlertDialog(
//         title: SvgPicture.asset(
//           image,
//           width: 45,
//           height: 60,
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             AutoSizeText(
//               text,
//               maxLines: 1,
//               style: const TextStyle(
//                 fontSize: 18,
//                 color: blackColor,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 13),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 TextButton(
//                   child: AutoSizeText(
//                     getString(context).ok,
//                     style: TextStyle(
//                       color: confirmColor,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   onPressed: onConfirmPressed,
//                 ),
//                 TextButton(
//                   child: AutoSizeText(
//                     getString(context).cancel,
//                     style: TextStyle(
//                       color: cancelColor,
//                       fontSize: 16,
//                       fontWeight: FontWeight.normal,
//                     ),
//                   ),
//                   onPressed: onCancelPressed,
//                 ),
//               ],
//             )
//           ],
//         ),
//       );
//     },
//   );
// }

extension DebugPrintText on String {
  void printText() {
    debugPrint(this);
  }
}

// /// This method is return true if bluetooth and location adapters are actived
// /// and return false if  not activated
// Future<bool> checkBluetoothPermissions() async {
//   bool _isLocationEnable =
//       await Permission.locationWhenInUse.serviceStatus.isEnabled;
//   await Permission.location.request();
//   bool isBluetooth = await FlutterBluePlus.instance.isOn;
//   if (_isLocationEnable && isBluetooth) {
//     return true;
//   } else {
//     return false;
//   }
// }

// void showCustomBottomSheet(BuildContext context, Device device) {
//   // BuildContext context, bool isFavourite, bool isQuick, Device device) {
//   showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (builder) {
//         return DeviceStatusBottomSheet(
//           device: device,
//           // isFavourite: isFavourite,
//           // isQuick: isQuick,
//         );
//       });
// }

// showErrorTextDialog({
//   required BuildContext context,
//   required String text,
//   required VoidCallback onPressed,
// }) async {
//   return showGeneralDialog(
//     context: context,
//     barrierLabel: '',
//     barrierDismissible: true,
//     transitionBuilder: (context, _animation, _secondaryAnimation, _child) {
//       return Animations.grow(_animation, _secondaryAnimation, _child);
//     },
//     pageBuilder: (_animation, _secondaryAnimation, _child) {
//       return AlertDialog(
//         content: Text(
//           text,
//           style: const TextStyle(
//             color: blackColor,
//             fontSize: 20,
//           ),
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: Text(
//               getString(context).ok,
//               style: const TextStyle(
//                 color: primaryColor,
//                 fontSize: 18,
//               ),
//             ),
//             onPressed: onPressed,
//           ),
//         ],
//       );
//     },
//   );
// }
