import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'core/my_app.dart';
import 'core/utils/cache_helper.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;
const USE_DATABASE_EMULATOR = true;
// The port we've set the Firebase Database emulator to run on via the
// `firebase.json` configuration file.
const emulatorPort = 9000;
// Android device emulators consider localhost of the host machine as 10.0.2.2
// so let's use that if running on Android.
final emulatorHost =
(!kIsWeb && defaultTargetPlatform == TargetPlatform.android)
    ? '10.0.2.2'
    : 'localhost';
// String messageTitle = "Title";
// String notificationAlert = "Alert";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  if (USE_DATABASE_EMULATOR) {
    FirebaseDatabase.instance.useDatabaseEmulator(emulatorHost, emulatorPort);
  }
  await CacheHelper.init();
  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  _handleCameraAndMic();
  // CacheHelper.clearAll();
  runApp(const ProviderScope(child: MyApp()));
}

_handleCameraAndMic() async {
  await [Permission.camera, Permission.microphone].request();
}
