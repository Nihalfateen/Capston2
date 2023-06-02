// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';

// import '../core/utils/log.dart';

// final detailsVM = ChangeNotifierProvider(
//   (ref) => DetailsViewModel(),
// );

// class DetailsViewModel with ChangeNotifier {
//   bool _isLoading = false;
//   Future downloadFileFromUrl(String link) async {
//     _isLoading = true;
//     notifyListeners();
//     final file = await downloadFile(link);
//     if (file == null) {
//       return;
//     }
//     Log.d(file.path.toString());
//     OpenFile.open(file.path);
//     _isLoading = false;
//     notifyListeners();
//   }

//   bool get isLoading => _isLoading;

//   Future<File?> downloadFile(String link) async {
//     try {
//       final appStorage = await getApplicationDocumentsDirectory();
//       final file = File('${appStorage.path}/$link');
//       final response =
//           await Dio().get("http://notifications.emmobank.com/download/$link",
//               options: Options(
//                 responseType: ResponseType.bytes,
//                 followRedirects: false,
//                 receiveTimeout: 0,
//               ));
//       final raf = file.openSync(mode: FileMode.write);
//       raf.writeFromSync(response.data);
//       await raf.close();
//       return file;
//     } catch (e) {
//       Log.e(e.toString());
//     }
//   }
// }
